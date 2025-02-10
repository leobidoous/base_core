# base_core

**Base Core** é um package auxiliar para Flutter projetado para simplificar a gestão de dependências globais em aplicações multi-repositório e mono-repositório. Ele fornece uma estrutura modular e organizada para facilitar a integração de serviços essenciais em projetos Flutter, garantindo maior reutilização de código e padronização do desenvolvimento.

## 👉 Recursos
- **Gestão centralizada de dependências**: Facilidade para organizar e acessar serviços globais.
- **Compatibilidade com Firebase**: Suporte embutido para `cloud_firestore`, `firebase_auth` e outros serviços.
- **Facilidade de integração**: Estrutura modular para facilitar o uso em diferentes projetos Flutter.
- **Expansível**: Permite a adição de novos serviços conforme a necessidade do projeto.

## 👉 Instalação
Adicione o **base_core** ao seu arquivo `pubspec.yaml`:

```yaml
dependencies:
  base_core: latest_version
```

Em seguida, rode o comando:

```sh
flutter pub get
```

## 👉 Como Usar
### Exemplo Básico de Uso

```dart
import 'package:base_core/base_core.dart';

void main() {
  BaseCore.init(); // Inicializa os serviços globais
  
  final authService = BaseCore.get<AuthService>();
  authService.signInWithEmailAndPassword('email@example.com', 'senha123');
}
```

## 👉 Contribuição
Contribuições são bem-vindas! Para sugerir melhorias ou reportar problemas, abra uma issue ou envie um pull request no [repositório do GitHub](https://github.com/seu-repositorio).

## 👉 Licença
Este projeto está licenciado sob a Licença MIT - veja o arquivo [LICENSE](LICENSE) para mais detalhes.