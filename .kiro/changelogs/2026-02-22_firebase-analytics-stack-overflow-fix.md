# Firebase Analytics Stack Overflow Fix

**Date**: 2026-02-22
**Type**: Bugfix
**Status**: Completed
**Severity**: Critical

## Summary

Corrigido bug crítico de recursão infinita no método `setUserProperty` do `FirebaseAnalyticsDriver` que causava Stack Overflow. O método estava chamando a si mesmo ao invés de chamar o método da instância do Firebase Analytics.

## Problem

O método `setUserProperty` estava implementado incorretamente:

```dart
// ❌ ERRADO - Recursão infinita
await setUserProperty(name: name, value: value);
```

Isso causava:

- Stack Overflow após ~45.000 chamadas recursivas
- Crash da aplicação
- Impossibilidade de setar user properties no Firebase Analytics

## Solution

Corrigido para chamar o método correto da instância do Firebase Analytics:

```dart
// ✅ CORRETO - Chama o método da instância
await instance.setUserProperty(name: name, value: value);
```

## Files Modified

- `Packages/base_core/lib/src/data/drivers/firebase/firebase_analytics_driver.dart` - Corrigido método `setUserProperty`

## Root Cause

Erro de implementação onde o método estava chamando a si mesmo recursivamente ao invés de delegar para a instância do Firebase Analytics (`instance.setUserProperty()`).

## Impact

- **Before**: Qualquer chamada a `setUserProperty` causava crash imediato
- **After**: User properties são setadas corretamente no Firebase Analytics

## Testing

### Manual Testing Steps

1. Chamar `firebaseAnalyticsService.setUserProperty(name: 'test', value: 'value')`
2. Verificar que não há Stack Overflow
3. Verificar que a propriedade aparece no Firebase Analytics dashboard
4. Testar com múltiplas propriedades em sequência (como no `onInstallConversionData`)

## Related Issues

- Afetava o `onInstallConversionData` do AppsFlyer que tenta setar múltiplas user properties
- Afetava o `onDeepLinking` do AppsFlyer
- Afetava qualquer código que tentasse setar user properties

## Notes

- Este é um bug crítico que impedia completamente o uso de user properties
- A correção é simples mas essencial para o funcionamento correto do Firebase Analytics
- Outros métodos como `login` e `logout` que chamam `setUserProperty` agora funcionam corretamente
