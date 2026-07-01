# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Purpose

`base_core` é o package de fundação do ecossistema PayPay. Fornece os contratos de arquitetura (Either, CustomController, IHttpDriver, INavigationDriver), todos os drivers de infraestrutura (Firebase, storage, HTTP, biometria, localização) e utilitários compartilhados. Todo micro-app e app do ecossistema depende deste package.

**Localização no ecossistema:** `/Users/leobidoous/Projects/Packages/base_core`  
**Consumidores diretos:** `paypay_core`, todos os micro-apps (via `paypay_core`)

## Estrutura

```
lib/src/
  core/utils/          # Utilitários: CrashLog, DateFormat, NumberFormat, BasePath, LoadMock
  domain/
    entities/          # Entidades base: PaginationEntity, DeviceInfoEntity, entidades Firebase Analytics
    enums/             # PermissionType, BiometricType, ConnectivityStatus, SortingOrderType
    failures/          # ICustomFailure, ICrashLogFailure
    interfaces/        # CustomController, Either, Disposable, RouterObserver
    services/          # Interfaces de serviço: ICrashLogService, IPermissionService, ILocationService…
  infra/
    context/           # RequestContext — zona para propagação automática de CancelToken
    drivers/           # Interfaces de driver: IHttpDriver, INavigationDriver, IDependencyManagerDriver…
    models/            # Models de infra: PaginationModel, QueryParamsModel, etc.
    services/          # Implementações concretas dos serviços
  data/drivers/        # Implementações concretas: DioClientDriver, FirebaseDriver, LocalAuthDriver…
  presentation/
    extensions/        # StringExt
    mixins/            # CancelTokenMixin
    observers/         # CustomRouterObserver
    widgets/           # CustomListenableBuilder
```

## Contratos principais

### Either

Implementação própria — **não usar dartz**.

```dart
Either<L, R> Left<L, R>(L l);    // construtor função
Either<L, R> Right<L, R>(R r);   // construtor função

result.fold((l) => /* erro */, (r) => /* sucesso */);
result.bind((r) => outraEither);         // flatMap
result.asyncBind((r) => futureEither);
result.map((r) => transforma(r));        // Right continua, Left passa
result.leftMap((l) => transformaErro);
```

Também existe `Unit` / `const unit` para retornos sem valor.

### CustomController

Estende `ValueNotifier<S>`, **não Cubit**. Tipo params: `<E extends ICustomFailure, S>`.

```dart
class MeuController extends CustomController<MeuFailure, MeuState> {
  MeuController({required this.usecase}) : super(MeuState.initial());
  final IMeuUsecase usecase;

  Future<void> carregar() async {
    await execute(() => usecase.buscarDados());
    // execute: seta loading→true, chama fn, fold Either, update(state) ou setError, loading→false
  }
}

// Accessors de estado:
controller.isLoading   // bool
controller.hasError    // bool
controller.error       // E?
controller.state       // S (alias para .value)

// Mutação manual (quando não usar execute):
controller.update(novoState);
controller.setError(falha);
controller.setLoading(true);
controller.clearError();
```

**CancelToken automático:** `execute()` usa `RequestContext.runWithCancelToken` para propagar o token ao `DioClientDriver` sem passar manualmente. `cancelRequests()` cancela todas as requisições pendentes do controller.

### IHttpDriver / DioClientDriver

Retorno sempre `Either<HttpDriverResponse, HttpDriverResponse>` — **Left = erro, Right = sucesso**.

```dart
// HttpDriverResponse
response.data        // dynamic — corpo da resposta
response.statusCode  // int?
response.statusMessage // String?

// HttpDriverOptions
HttpDriverOptions(
  baseUrl: () => 'https://api.exemplo.com',  // lazy fn
  accessToken: 'Bearer token',
  apiKey: 'chave',
  apiMapKey: 'X-Api-Key',        // nome do header, default 'apiKey'
  accessTokenType: 'Bearer',     // default
  contentType: 'application/json',
  responseType: ResponseType.json,
  extraHeaders: {'X-Custom': 'valor'},
)

// Métodos: get, post, put, patch, delete, sendFile, getFile
// CancelToken é injetado automaticamente via RequestContext
```

### INavigationDriver

```dart
Nav.to.pushNamed(MinhaRota.path);
Nav.to.pushReplacementNamed(MinhaRota.path);
Nav.to.pop();
Nav.to.popUntil(MinhaRota.path);
Nav.to.navigate(MinhaRota.path);   // remove toda a stack
Nav.to.canPop(context);
Nav.to.args.data       // dynamic — argumento passado via arguments:
Nav.to.args.params     // Map<String,dynamic> — route params (:id)
Nav.to.args.queryParams // Map<String,String>
Nav.to.history         // List<String>
```

### BasePath

```dart
final rota = BasePath('detalhe', parentRota);
rota.completePath   // '/parent/detalhe'
rota.relativePath   // 'parent/detalhe'
rota.name           // 'detalhe'
rota.prevPath()     // '../detalhe'
rota.prevPath(2)    // '../../detalhe'
rota.concate(outraRota)
```

### CrashLog

```dart
final crashLog = CrashLog(logs: [SentryService(), CrashlyticsService()]);
await crashLog.capture(exception: e, stackTrace: s, fatal: false);
// Faz fan-out para todos os ICrashLogService registrados + sempre printa no console
```

### Failures

```dart
// Base para falhas de domínio
abstract class ICustomFailure implements Exception {
  final String message;
  final String detailError;
  final StackTrace? stackTrace;
}

// Base para falhas que carregam contexto HTTP (usado por HttpFailure)
abstract class ICrashLogFailure extends Equatable implements Exception {
  final String? path;
  final Map<String,dynamic>? params;
  final Object? exception;
  final StackTrace? stackTrace;
}
```

### RequestContext

```dart
// Acesso ao CancelToken da zona atual (setado por CustomController.execute)
RequestContext.current  // CancelToken? — lido automaticamente pelo DioClientDriver

// Para casos fora de execute():
RequestContext.runWithCancelToken(cancelToken, () => minhaRequisicao());
```

### Utilitários

```dart
// DateFormat (static)
DateFormat.toDate(dateTime, pattern: 'dd/MM/yyyy')
DateFormat.tryParse('2024-01-15', pattern: 'yyyy-MM-dd')
DateFormat.isSameDate(a, b)
DateFormat.dateIsToday(date)

// NumberFormat (static)
NumberFormat.toCurrency(valor, symbol: 'R\$', decimalDigits: 2)
NumberFormat.toNumber(valor, decimalDigits: 0)

// StringExt (extension on String)
'1.234,56'.tryParseCurrencyToDouble  // 1234.56
'João Silva'.initials                // 'JS'
'hello world'.capitalize()           // 'Hello World'

// PaginationModel
PaginationModel.fromMap(map)         // keys: limit, offset, page, sortingBy, sortingOrder
paginationModel.toMap                // omite campos nulos

// LoadMock (dev/test)
LoadMock.fromAsset('assets/mock/dados.json')
```

### CancelTokenMixin

Para `StatefulWidget` que faz requisições **sem** `CustomController`:

```dart
class _MinhaPaginaState extends State<MinhaPagina> with CancelTokenMixin {
  @override
  void _buscar() {
    httpDriver.get('/path', options: HttpDriverOptions(cancelToken: cancelToken));
    // dispose() cancela automaticamente
  }
}
```

### Disposable mixin

Aplicar em drivers concretos para que o flutter_modular faça dispose automático ao sair do módulo:

```dart
class MeuDriver extends IMeuDriver with Disposable {
  @override
  void dispose() { /* limpar recursos */ }
}
```

## Adicionando um novo driver/serviço

1. Criar interface em `infra/drivers/i_meu_driver.dart`
2. Criar serviço interface em `domain/services/i_meu_service.dart`  
3. Implementar driver concreto em `data/drivers/meu_driver.dart` (+ `with Disposable` se necessário)
4. Implementar serviço em `infra/services/meu_service.dart`
5. Exportar tudo em `base_core.dart`

## Linting

`analysis_options.yaml` → `package:flutter_lints/flutter.yaml`. O arquivo `lib/linter_rules.yaml` é exportado para consumo pelos outros packages do ecossistema:

```yaml
# Em qualquer package do ecossistema:
include: package:base_core/linter_rules.yaml
```
