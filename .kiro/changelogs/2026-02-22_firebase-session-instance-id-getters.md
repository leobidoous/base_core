# Firebase Analytics Session ID and App Instance ID Getters

**Date**: 2026-02-22
**Type**: Feature
**Status**: Completed

## Summary

Added getter methods to retrieve Firebase Analytics Session ID and App Instance ID. These identifiers are essential for cross-platform tracking integration, allowing correlation of events between Firebase Analytics and other analytics platforms like AppsFlyer and Facebook.

## Files Modified

- `Packages/base_core/lib/src/data/drivers/firebase/firebase_analytics_driver.dart` - Added getter implementations
- `Packages/base_core/lib/src/infra/drivers/firebase/i_firebase_analytics_driver.dart` - Added abstract getter signatures
- `Packages/base_core/lib/src/domain/services/firebase/i_firebase_analytics_service.dart` - Added service interface getters
- `Packages/base_core/lib/src/infra/services/firebase/firebase_analytics_service.dart` - Added service getter implementations

## Files Created

None

## Files Deleted

None

## Architecture Impact

- **Layers affected**: Domain, Infrastructure, Data
- **New dependencies**: None
- **Breaking changes**: None (backward compatible)

### New Getters

#### 1. getSessionId

Returns the current Firebase Analytics session ID.

**Signature**:

```dart
Future<int?> get getSessionId;
```

**Returns**:

- `int?` - The current session ID, or `null` if unavailable or error occurs

**Usage**:

```dart
final sessionId = await firebaseAnalyticsService.getSessionId;
debugPrint('Current Session ID: $sessionId');
```

#### 2. appInstanceId

Returns the Firebase Analytics App Instance ID (32-character hex string).

**Signature**:

```dart
Future<String?> get appInstanceId;
```

**Returns**:

- `String?` - The app instance ID (e.g., `a12bc3d456789efabc123456a8a5de56`), or `null` if unavailable or error occurs

**Usage**:

```dart
final instanceId = await firebaseAnalyticsService.appInstanceId;
debugPrint('App Instance ID: $instanceId');
```

## Usage Examples

### Example 1: Get Both Identifiers

```dart
final sessionId = await firebaseAnalyticsService.getSessionId;
final instanceId = await firebaseAnalyticsService.appInstanceId;

debugPrint('Session ID: $sessionId');
debugPrint('App Instance ID: $instanceId');
```

### Example 2: Sync with AppsFlyer

```dart
// Get Firebase identifiers
final firebaseInstanceId = await firebaseAnalyticsService.appInstanceId;

if (firebaseInstanceId != null) {
  // Set in AppsFlyer for cross-platform tracking
  await appsFlyerService.setAdditionalData(
    data: {
      'firebase_app_instance_id': firebaseInstanceId,
      'integration_timestamp': DateTime.now().millisecondsSinceEpoch,
    },
  );
}
```

### Example 3: Sync with Facebook

```dart
// Get Firebase identifiers
final firebaseInstanceId = await firebaseAnalyticsService.appInstanceId;
final sessionId = await firebaseAnalyticsService.getSessionId;

// Log custom event with Firebase identifiers
await facebookService.createEvent(
  event: LogEventEntity(
    name: 'firebase_sync',
    parameters: {
      'firebase_instance_id': firebaseInstanceId,
      'firebase_session_id': sessionId,
    },
  ),
);
```

### Example 4: Error Handling

```dart
try {
  final instanceId = await firebaseAnalyticsService.appInstanceId;

  if (instanceId == null) {
    debugPrint('Firebase App Instance ID not available');
    return;
  }

  // Use instanceId
  await syncWithOtherPlatforms(instanceId);
} catch (e) {
  debugPrint('Error getting Firebase identifiers: $e');
}
```

## Testing

- Manual testing required to verify identifiers are retrieved correctly
- Test on both iOS and Android platforms
- Verify identifiers persist across app sessions
- Test error handling when Firebase is not initialized
- Validate identifier format (Session ID: int, App Instance ID: 32-char hex string)

## Related Documentation

- Firebase Analytics App Instance ID: https://firebase.google.com/docs/reference/android/com/google/firebase/analytics/FirebaseAnalytics#getAppInstanceId()
- Firebase Analytics Session ID: https://firebase.google.com/docs/reference/android/com/google/firebase/analytics/FirebaseAnalytics#getSessionId()
- Reference: `Docs/data/drivers.md` for driver implementation patterns
- Reference: `Docs/infra/usecases.md` for service implementation patterns

## Benefits

1. **Cross-Platform Tracking**: Enable correlation of events between Firebase and other platforms
2. **User Journey Analysis**: Track the same user across multiple analytics platforms
3. **Attribution Integration**: Link Firebase attribution data with AppsFlyer/Facebook
4. **Debugging**: Easier troubleshooting by matching events across platforms
5. **Data Consolidation**: Export and join data from multiple platforms using these identifiers

## Implementation Notes

- Both getters return `Future` types as they are async operations
- Returns `null` instead of throwing exceptions for better error handling
- Debug logging included for troubleshooting
- Crash logging integrated for production error tracking
- Session ID changes with each new session (typically every 30 minutes of inactivity)
- App Instance ID persists for the lifetime of the app installation
- App Instance ID is a 32-character hexadecimal string
- Session ID is an integer value

## Important Considerations

### Session ID

- Changes with each new session
- Session timeout is typically 30 minutes of inactivity
- Useful for tracking events within the same session
- May be `null` if session hasn't started yet

### App Instance ID

- Unique identifier for each app installation
- Persists across app sessions
- Resets only when app is uninstalled and reinstalled
- This is the **primary identifier** for Firebase ↔ AppsFlyer integration
- Format: 32-character hexadecimal string (e.g., `a12bc3d456789efabc123456a8a5de56`)

## Integration with AppsFlyer

The App Instance ID is the official identifier used by AppsFlyer's Firebase/GA4 integration:

```dart
// Recommended integration pattern
final firebaseInstanceId = await firebaseAnalyticsService.appInstanceId;

if (firebaseInstanceId != null) {
  // Set in AppsFlyer
  await appsFlyerService.setAdditionalData(
    data: {'firebase_app_instance_id': firebaseInstanceId},
  );

  // Set AppsFlyer ID in Firebase for reverse correlation
  final appsFlyerId = appsFlyerService.instance.getAppsFlyerUID();
  if (appsFlyerId != null) {
    await firebaseAnalyticsService.setUserProperty(
      name: 'appsflyer_id',
      value: appsFlyerId,
    );
  }
}
```

This enables bidirectional event correlation between Firebase and AppsFlyer dashboards.
