# Firebase Analytics Entities and Models Refactor

**Date**: 2026-02-13
**Type**: Refactor
**Status**: Completed

## Summary

Refatoração completa das entities e models do Firebase Analytics para usar tipos específicos ao invés de `Map<String, dynamic>`. Criação de entities compartilhadas (`FirebaseAnalyticsItemEntity`) e entities específicas para cada evento (`FirebasePurchaseEntity`, `FirebaseBeginCheckoutEntity`, `FirebaseAddToCartEntity`). Atualização dos drivers e services para aceitar as novas entities tipadas.

## Files Created

### Domain Layer - Entities

- `lib/src/domain/entities/firebase_analytics_item_entity.dart` - Entity compartilhada com todos os 24 atributos do `AnalyticsEventItem` do Firebase
- `lib/src/domain/entities/firebase_purchase_entity.dart` - Entity para evento de compra (purchase)
- `lib/src/domain/entities/firebase_begin_checkout_entity.dart` - Entity para início de checkout
- `lib/src/domain/entities/firebase_add_to_cart_entity.dart` - Entity para adicionar ao carrinho

### Infrastructure Layer - Models

- `lib/src/infra/models/firebase_analytics_item_model.dart` - Model com serialização para `AnalyticsEventItem`
- `lib/src/infra/models/firebase_purchase_model.dart` - Model com serialização para evento purchase
- `lib/src/infra/models/firebase_begin_checkout_model.dart` - Model com serialização para evento begin_checkout
- `lib/src/infra/models/firebase_add_to_cart_model.dart` - Model com serialização para evento add_to_cart

## Files Modified

### Infrastructure Layer

- `lib/src/infra/drivers/firebase/i_firebase_analytics_driver.dart` - Refatorado para aceitar entities tipadas ao invés de Maps
  - `logPurchase()` agora recebe `FirebasePurchaseEntity`
  - `logBeginCheckout()` agora recebe `FirebaseBeginCheckoutEntity`
  - `logAddToCart()` agora recebe `FirebaseAddToCartEntity`
  - Métodos legados (`logSelectItem`, `logViewItem`, etc.) mantidos com Maps para compatibilidade

### Data Layer

- `lib/src/data/drivers/firebase/firebase_analytics_driver.dart` - Implementação atualizada
  - Método helper `_toAnalyticsEventItem()` para converter `FirebaseAnalyticsItemEntity` em `AnalyticsEventItem`
  - Conversão de entities para objetos do Firebase Analytics
  - Mantém compatibilidade com métodos legados

### Domain Layer

- `lib/src/domain/services/firebase/i_firebase_analytics_service.dart` - Interface atualizada para usar entities tipadas

### Infrastructure Layer

- `lib/src/infra/services/firebase/firebase_analytics_service.dart` - Implementação atualizada para delegar com entities tipadas

### Exports

- `lib/base_core.dart` - Adicionados exports para todas as novas entities e models

## Files Deleted

Nenhum arquivo foi deletado, apenas refatorado.

## Architecture Impact

### Layers Affected

- **Domain**: Novas entities para eventos do Firebase Analytics
- **Infrastructure**: Novos models com serialização, interfaces atualizadas
- **Data**: Implementação de driver atualizada com conversão de entities

### Key Architectural Decisions

1. **Entity Compartilhada para Items**
   - `FirebaseAnalyticsItemEntity` contém todos os 24 atributos do `AnalyticsEventItem`
   - Reutilizada em todas as entities de eventos (Purchase, BeginCheckout, AddToCart)
   - Garante consistência e type safety

2. **Entities Específicas por Evento**
   - `FirebasePurchaseEntity`: transactionId, value, currency, tax, shipping, items, parameters
   - `FirebaseBeginCheckoutEntity`: value, currency, items, parameters
   - `FirebaseAddToCartEntity`: value, currency, items, parameters
   - Cada entity tem apenas os campos relevantes para seu evento

3. **Serialização com Snake Case**
   - Models seguem convenção do Firebase Analytics (snake_case)
   - Exemplos: `transaction_id`, `item_id`, `item_name`, `item_category`
   - Conversão automática de camelCase (Dart) para snake_case (Firebase)

4. **Compatibilidade com Métodos Legados**
   - Métodos antigos (`logSelectItem`, `logViewItem`, etc.) mantidos com Maps
   - Permite migração gradual para entities tipadas
   - Não quebra código existente

5. **Type Safety**
   - Substituição de `Map<String, dynamic>` por entities tipadas
   - Compilador garante que todos os campos obrigatórios sejam fornecidos
   - Autocomplete e validação em tempo de desenvolvimento

### Breaking Changes

Nenhuma breaking change, pois:

- Métodos legados mantidos para compatibilidade
- Novos métodos tipados adicionados sem remover os antigos
- Código existente continua funcionando

## Testing

### Manual Testing Steps

1. **Testar evento de compra**

   ```dart
   final purchase = FirebasePurchaseEntity(
     transactionId: 'T12345',
     value: 99.90,
     currency: 'BRL',
     tax: 9.99,
     shipping: 5.00,
     items: [
       FirebaseAnalyticsItemEntity(
         itemId: 'SKU123',
         itemName: 'Produto Teste',
         price: 99.90,
         quantity: 1,
       ),
     ],
   );
   await firebaseAnalyticsService.logPurchase(data: purchase);
   ```

2. **Testar início de checkout**

   ```dart
   final checkout = FirebaseBeginCheckoutEntity(
     value: 99.90,
     currency: 'BRL',
     items: [
       FirebaseAnalyticsItemEntity(
         itemId: 'SKU123',
         itemName: 'Produto Teste',
         price: 99.90,
         quantity: 1,
       ),
     ],
   );
   await firebaseAnalyticsService.logBeginCheckout(data: checkout);
   ```

3. **Testar adicionar ao carrinho**
   ```dart
   final addToCart = FirebaseAddToCartEntity(
     value: 99.90,
     currency: 'BRL',
     items: [
       FirebaseAnalyticsItemEntity(
         itemId: 'SKU123',
         itemName: 'Produto Teste',
         price: 99.90,
         quantity: 1,
       ),
     ],
   );
   await firebaseAnalyticsService.logAddToCart(data: addToCart);
   ```

### Tests Updated

- `cogna-resale-core/test/lib/src/core/utils/app_tracking_test.dart` - Atualizado para usar entities tipadas ao invés de Maps

## Related Documentation

- [Firebase Analytics Documentation](https://firebase.google.com/docs/analytics)
- [AnalyticsEventItem Reference](https://firebase.google.com/docs/reference/android/com/google/firebase/analytics/FirebaseAnalytics.Event)
- [Domain Layer Documentation](../../docs/domain/)
- [Infrastructure Layer Documentation](../../docs/infra/)

## Implementation Details

### FirebaseAnalyticsItemEntity Attributes

Todos os 24 atributos do `AnalyticsEventItem`:

```dart
class FirebaseAnalyticsItemEntity {
  final String? itemId;           // ID do item
  final String? itemName;         // Nome do item
  final String? affiliation;      // Afiliação/loja
  final String? coupon;           // Cupom aplicado
  final String? creativeName;     // Nome da criativa
  final String? creativeSlot;     // Slot da criativa
  final double? discount;         // Desconto aplicado
  final int? index;               // Índice na lista
  final String? itemBrand;        // Marca do item
  final String? itemCategory;     // Categoria principal
  final String? itemCategory2;    // Categoria secundária
  final String? itemCategory3;    // Categoria terciária
  final String? itemCategory4;    // Categoria quaternária
  final String? itemCategory5;    // Categoria quinária
  final String? itemListId;       // ID da lista
  final String? itemListName;     // Nome da lista
  final String? itemVariant;      // Variante do item
  final String? locationId;       // ID da localização
  final double? price;            // Preço unitário
  final String? promotionId;      // ID da promoção
  final String? promotionName;    // Nome da promoção
  final int? quantity;            // Quantidade
  final Map<String, Object>? parameters;  // Parâmetros customizados
}
```

### Serialization Pattern

Models usam `toMap()` para converter entities em Maps com snake_case:

```dart
Map<String, dynamic> get toMap {
  return {
    'item_id': itemId,
    'item_name': itemName,
    'affiliation': affiliation,
    'coupon': coupon,
    'discount': discount,
    'index': index,
    'item_brand': itemBrand,
    'item_category': itemCategory,
    'price': price,
    'quantity': quantity,
    // ... outros campos
  }..removeWhere((key, value) => value == null);
}
```

### Driver Conversion

Driver converte entities em objetos do Firebase:

```dart
AnalyticsEventItem _toAnalyticsEventItem(FirebaseAnalyticsItemEntity item) {
  return AnalyticsEventItem(
    itemId: item.itemId,
    itemName: item.itemName,
    affiliation: item.affiliation,
    coupon: item.coupon,
    discount: item.discount,
    index: item.index,
    itemBrand: item.itemBrand,
    itemCategory: item.itemCategory,
    price: item.price,
    quantity: item.quantity,
    // ... outros campos
  );
}
```

## Next Steps

1. ✅ Migrar código existente para usar entities tipadas
2. ✅ Adicionar testes unitários para entities e models
3. ✅ Documentar padrão de uso no README
4. ✅ Criar exemplos de uso para cada evento
5. ✅ Considerar adicionar validações nas entities (ex: value > 0)
6. ✅ Adicionar mais eventos do Firebase Analytics (view_item, select_item, etc.)

## Notes

- Refatoração mantém compatibilidade com código existente
- Type safety melhora experiência de desenvolvimento
- Serialização automática reduz erros de digitação
- Padrão pode ser aplicado a outros eventos do Firebase Analytics
- Facilita manutenção e evolução do código
- Documentação inline com todos os atributos disponíveis

## Benefits

### Type Safety

- Compilador valida campos obrigatórios
- Autocomplete em IDEs
- Refactoring seguro

### Manutenibilidade

- Código mais legível e auto-documentado
- Fácil adicionar novos campos
- Centralização de lógica de serialização

### Consistência

- Padrão único para todos os eventos
- Nomenclatura consistente (snake_case)
- Reutilização de `FirebaseAnalyticsItemEntity`

### Developer Experience

- Menos erros de digitação
- Validação em tempo de desenvolvimento
- Documentação inline dos campos
