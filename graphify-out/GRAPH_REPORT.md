# Graph Report - base_core  (2026-10-26)

## Corpus Check
- 168 files · ~29,761 words
- Verdict: corpus is large enough that graph structure adds value.
- Unclassified: 60 file(s) not represented in the graph (top: (none) 13, .xcconfig 8, .xml 7)

## Summary
- 1770 nodes · 2052 edges · 103 communities (84 shown, 19 thin omitted)
- Extraction: 99% EXTRACTED · 1% INFERRED · 0% AMBIGUOUS · INFERRED: 17 edges (avg confidence: 0.85)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `6ea9b0d9`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- CHANGELOG.md
- win32_window.cpp
- GeneratedPluginRegistrant.swift
- local_notifications_driver.dart
- firebase_crashlytics_service.dart
- dependencies
- share_driver.dart
- received_notifications_entity.dart
- firebase_database_driver.dart
- firebase_auth_driver.dart
- local_auth_driver.dart
- i_http_driver.dart
- preferences_storage_service.dart
- custom_dio_logger.dart
- query_snapshot_filters_entity.dart
- rules
- Firebase Analytics Entities and Models Refactor
- firebase_analytics_item_entity.dart
- either.dart
- firebase_remote_config_service.dart
- my_application.cc
- CancelToken Support for HTTP Requests - Automatic Context-Based Cancellation
- firebase_analytics_driver.dart
- Firebase Analytics Session ID and App Instance ID Getters
- custom_controller.dart
- firebase_notifications_driver.dart
- i_location_failure.dart
- with
- i_navigation_driver.dart
- Contratos principais
- example/pubspec.yaml
- windows/flutter/generated_plugin_registrant.cc
- firebase_analytics_service.dart
- dio_client_driver.dart
- location_driver.dart
- i_firebase_analytics_service.dart
- date_formats.dart
- query_params_model.dart
- i_firebase_analytics_driver.dart
- package_info_entity.dart
- utils.cpp
- position_model.dart
- package:flutter/foundation.dart
- Firebase Analytics Stack Overflow Fix
- cancel_token_mixin.dart
- manifest.json
- i_firebase_crashlytics_service.dart
- firebase_remote_config_driver.dart
- received_notifications_model.dart
- dart:async
- firebase_storage_service.dart
- Equatable
- i_firebase_storage_driver.dart
- device_info_entity.dart
- firebase_purchase_entity.dart
- i_crash_log_failure.dart
- log_event_model.dart
- firebase_storage_driver.dart
- permission_service.dart
- ../../domain/interfaces/either.dart
- secure_storage_service.dart
- i_navigation_arguments_driver.dart
- secure_storage_driver.dart
- firebase_begin_checkout_entity.dart
- i_firebase_storage_service.dart
- connectivity_driver.dart
- List
- connectivity_service.dart
- i_local_notifications_service.dart
- string
- firebase_add_to_cart_entity.dart
- base_path.dart
- i_secure_storage_driver.dart
- i_firebase_notifications_service.dart
- i_secure_storage_service.dart
- base_core
- ../../../domain/entities/firebase_add_to_cart_entity.dart
- custom_router_observer.dart
- i_app_tracking_service.dart
- ../interfaces/either.dart
- Map
- ../../../domain/entities/log_event_entity.dart
- i_permission_service.dart
- ../../../domain/entities/firebase_purchase_entity.dart
- analysis_options.yaml
- permission_status_type_enum.dart
- MainActivity.kt
- example
- biometric_type.dart
- i_dependency_manager_driver.dart
- .claude/CLAUDE.md
- LaunchImage.imageset/README.md
- connectivity_status.dart
- permission_type_enum.dart
- sonar.sh

## God Nodes (most connected - your core abstractions)
1. `dependencies` - 29 edges
2. `Win32Window` - 21 edges
3. `rules` - 18 edges
4. `CancelToken Support for HTTP Requests - Automatic Context-Based Cancellation` - 14 edges
5. `Firebase Analytics Session ID and App Instance ID Getters` - 13 edges
6. `Firebase Analytics Entities and Models Refactor` - 12 edges
7. `Contratos principais` - 12 edges
8. `FlutterWindow` - 10 edges
9. `Firebase Analytics Stack Overflow Fix` - 10 edges
10. `errors` - 8 edges

## Surprising Connections (you probably didn't know these)
- `wWinMain()` --calls--> `CreateAndAttachConsole()`  [INFERRED]
  example/windows/runner/main.cpp → example/windows/runner/utils.cpp
- `my_application_activate()` --calls--> `fl_register_plugins()`  [INFERRED]
  example/linux/my_application.cc → example/linux/flutter/generated_plugin_registrant.cc
- `main()` --calls--> `my_application_new()`  [INFERRED]
  example/linux/main.cc → example/linux/my_application.cc
- `wWinMain()` --calls--> `GetCommandLineArguments()`  [INFERRED]
  example/windows/runner/main.cpp → example/windows/runner/utils.cpp
- `FlutterWindow` --inherits--> `Win32Window`  [EXTRACTED]
  example/windows/runner/flutter_window.h → example/windows/runner/win32_window.h

## Import Cycles
- None detected.

## Communities (103 total, 19 thin omitted)

### Community 1 - "CHANGELOG.md"
Cohesion: 0.03
Nodes (67): 1.0.0, 1.0.1, 1.0.10, 1.0.11, 1.0.12, 1.0.2, 1.0.3, 1.0.4 (+59 more)

### Community 2 - "win32_window.cpp"
Cohesion: 0.05
Nodes (21): FlutterWindow, flutter_controller_, FlutterWindow::FlutterWindow(), project_, EnableFullDpiSupportIfAvailable(), EnableNonClientDpiScaling, Point, x (+13 more)

### Community 3 - "GeneratedPluginRegistrant.swift"
Cohesion: 0.05
Nodes (29): cloud_firestore, Cocoa, connectivity_plus, AppDelegate, RunnerTests, RegisterGeneratedPlugins(), AppDelegate, MainFlutterWindow (+21 more)

### Community 4 - "local_notifications_driver.dart"
Cohesion: 0.04
Nodes (35): FirebaseNotificationsDriver, init, LocalNotificationsDriver, _localNotificationsPlugin, requestPermissions, scheduleNotification, showNotification, IFirebaseNotificationsService (+27 more)

### Community 5 - "firebase_crashlytics_service.dart"
Cohesion: 0.04
Nodes (37): checkForUnsentReports, _convertToMapStringObject, deleteUnsentReports, FirebaseCrashlyticsDriver, isCrashlyticsCollectionEnabled, log, sendUnsentReports, setCrashlyticsCollectionEnabled (+29 more)

### Community 6 - "dependencies"
Cohesion: 0.04
Nodes (44): dependencies, cloud_firestore, connectivity_plus, dio, equatable, firebase_analytics, firebase_auth, firebase_core (+36 more)

### Community 7 - "share_driver.dart"
Cohesion: 0.06
Nodes (20): main, instance, ShareDriver, shareFiles, shareText, shareWidgets, IShareService, shareFiles (+12 more)

### Community 8 - "received_notifications_entity.dart"
Cohesion: 0.05
Nodes (37): android, AndroidNotificationData, apple, AppleNotificationData, badge, body, category, channelId (+29 more)

### Community 9 - "firebase_database_driver.dart"
Cohesion: 0.06
Nodes (30): crashLog, docDelete, docGet, docSet, docUpdate, FirebaseDatabaseDriver, getDocument, getDocumentStream (+22 more)

### Community 10 - "firebase_auth_driver.dart"
Cohesion: 0.06
Nodes (30): crashLog, FirebaseAuthDriver, getCurrentUser, logout, signInAnonymously, signInWithCustomToken, signInWithEmailAndPassword, signInWithPhoneNumber (+22 more)

### Community 11 - "local_auth_driver.dart"
Cohesion: 0.06
Nodes (26): _auth, authenticate, availableBiometrics, canCheckBiometrics, isDeviceSupported, LocalAuthDriver, stopAuthentication, authenticate (+18 more)

### Community 12 - "i_http_driver.dart"
Cohesion: 0.05
Nodes (34): DioClientDriver, Disposable, dispose, accessToken, accessTokenType, apiKey, apiMapKey, baseUrl (+26 more)

### Community 13 - "preferences_storage_service.dart"
Cohesion: 0.05
Nodes (29): getStringByKey, getStringListByKey, PreferencesStorageDriver, removeStringByKey, setBoolByKey, setStringByKey, setStringListByKey, getStringByKey (+21 more)

### Community 14 - "custom_dio_logger.dart"
Cohesion: 0.06
Nodes (29): _canFlattenList, _canFlattenMap, chunkSize, compact, CustomDioLogger, error, _indent, kInitialTab (+21 more)

### Community 15 - "query_snapshot_filters_entity.dart"
Cohesion: 0.06
Nodes (27): copyWith, limit, offset, pageNumber, PaginationEntity, sortingBy, sortingOrder, collection (+19 more)

### Community 16 - "rules"
Cohesion: 0.06
Nodes (33): analyzer, errors, exclude, strong-mode, always_declare_return_types, dead_code, missing_required_param, missing_return (+25 more)

### Community 17 - "Firebase Analytics Entities and Models Refactor"
Cohesion: 0.06
Nodes (31): Architecture Impact, Benefits, Breaking Changes, Consistência, Data Layer, Developer Experience, Domain Layer, Domain Layer - Entities (+23 more)

### Community 18 - "firebase_analytics_item_entity.dart"
Cohesion: 0.06
Nodes (28): affiliation, copyWith, coupon, creativeName, creativeSlot, currency, discount, FirebaseAnalyticsItemEntity (+20 more)

### Community 19 - "either.dart"
Cohesion: 0.08
Nodes (21): build, _counter, createState, _incrementCounter, main, MyApp, MyHomePage, _MyHomePageState (+13 more)

### Community 20 - "firebase_remote_config_service.dart"
Cohesion: 0.06
Nodes (26): FirebaseRemoteConfigDriver, getAll, getBool, getDouble, getInt, getString, getValue, IFirebaseRemoteConfigService (+18 more)

### Community 21 - "my_application.cc"
Cohesion: 0.09
Nodes (13): fl_register_plugins(), main(), my_application_activate(), my_application_class_init(), my_application_dispose(), my_application_init(), my_application_local_command_line(), my_application_new() (+5 more)

### Community 22 - "CancelToken Support for HTTP Requests - Automatic Context-Based Cancellation"
Cohesion: 0.07
Nodes (29): 1. Automatic Cancellation (Zero Configuration), 2. Manual Cancellation (Optional), 3. Explicit CancelToken (Advanced), 4. How RequestContext Works, 5. DioClientDriver Implementation, After (With Automatic Cancellation), Architecture Impact, Before (No Cancellation) (+21 more)

### Community 23 - "firebase_analytics_driver.dart"
Cohesion: 0.09
Nodes (17): addToCart, _analyticsEventItemFromMap, beginCheckout, _convertToMapStringObject, crashLog, createEvent, init, logAddPaymentInfo (+9 more)

### Community 24 - "Firebase Analytics Session ID and App Instance ID Getters"
Cohesion: 0.09
Nodes (22): 1. getSessionId, 2. appInstanceId, App Instance ID, Architecture Impact, Benefits, Example 1: Get Both Identifiers, Example 2: Sync with AppsFlyer, Example 3: Sync with Facebook (+14 more)

### Community 25 - "custom_controller.dart"
Cohesion: 0.10
Nodes (15): cancelRequests, _cancelToken, clearError, CustomController, dispose, _error, execute, hasError (+7 more)

### Community 26 - "firebase_notifications_driver.dart"
Cohesion: 0.09
Nodes (16): configure, crashLog, getInitialNotification, getInstallationId, getToken, _installationId, _listeningRegistration, _listenRegistration (+8 more)

### Community 27 - "i_location_failure.dart"
Cohesion: 0.13
Nodes (17): detailError, ICustomFailure, message, stackTrace, toString, CurrentLocationFailure, detailError, detailsMessage (+9 more)

### Community 28 - "with"
Cohesion: 0.10
Nodes (19): runs-on, steps, jobs, checking-push, name, branches, branches, name (+11 more)

### Community 29 - "i_navigation_driver.dart"
Cohesion: 0.11
Nodes (13): addListener, args, basePath, canPop, context, hasContext, history, INavigationDriver (+5 more)

### Community 30 - "Contratos principais"
Cohesion: 0.11
Nodes (17): Adicionando um novo driver/serviço, BasePath, CancelTokenMixin, Contratos principais, CrashLog, CustomController, Disposable mixin, Either (+9 more)

### Community 31 - "example/pubspec.yaml"
Cohesion: 0.11
Nodes (18): path, dependencies, base_core, cupertino_icons, flutter, description, dev_dependencies, flutter_lints (+10 more)

### Community 33 - "firebase_analytics_service.dart"
Cohesion: 0.11
Nodes (15): addToCart, appInstanceId, beginCheckout, createEvent, firebaseAnalyticsDriver, getSessionId, init, logAddPaymentInfo (+7 more)

### Community 34 - "dio_client_driver.dart"
Cohesion: 0.12
Nodes (13): _cancelToken, client, copyWith, crashLog, dispose, getHeaders, interceptRequests, _options (+5 more)

### Community 35 - "location_driver.dart"
Cohesion: 0.15
Nodes (7): getCurrentPosition, LocationDriver, permissionService, getCurrentPosition, ILocationDriver, getCurrentPosition, locationDriver

### Community 36 - "i_firebase_analytics_service.dart"
Cohesion: 0.12
Nodes (12): addToCart, appInstanceId, beginCheckout, getSessionId, logAddPaymentInfo, logAddShippingInfo, login, logout (+4 more)

### Community 37 - "date_formats.dart"
Cohesion: 0.12
Nodes (13): DateFormat, dateIsToday, fromString, isSameDate, timestampToDate, toDate, toDateTime, toTime (+5 more)

### Community 38 - "query_params_model.dart"
Cohesion: 0.13
Nodes (9): fromAsset, LoadMock, fromEntity, fromJson, fromMap, props, stringify, toEntity (+1 more)

### Community 39 - "i_firebase_analytics_driver.dart"
Cohesion: 0.13
Nodes (13): addToCart, appInstanceId, beginCheckout, getSessionId, init, logAddPaymentInfo, logAddShippingInfo, login (+5 more)

### Community 40 - "package_info_entity.dart"
Cohesion: 0.14
Nodes (11): appName, buildNumber, buildSignature, forceUpdate, getExtendedVersionNumber, name, PackageInfoEntity, version (+3 more)

### Community 41 - "utils.cpp"
Cohesion: 0.19
Nodes (4): wWinMain(), CreateAndAttachConsole(), GetCommandLineArguments(), Utf8FromUtf16()

### Community 42 - "position_model.dart"
Cohesion: 0.15
Nodes (9): latitude, longitude, PositionEntity, fromEntity, fromMap, PositionModel, props, stringify (+1 more)

### Community 43 - "package:flutter/foundation.dart"
Cohesion: 0.17
Nodes (6): capture, CrashLog, logs, FirebaseDriver, init, IFirebaseDriver

### Community 44 - "Firebase Analytics Stack Overflow Fix"
Cohesion: 0.17
Nodes (11): Files Modified, Firebase Analytics Stack Overflow Fix, Impact, Manual Testing Steps, Notes, Problem, Related Issues, Root Cause (+3 more)

### Community 45 - "cancel_token_mixin.dart"
Cohesion: 0.18
Nodes (5): _cancelTokenKey, RequestContext, cancelRequests, _cancelToken, dispose

### Community 46 - "manifest.json"
Cohesion: 0.18
Nodes (10): background_color, description, display, icons, name, orientation, prefer_related_applications, short_name (+2 more)

### Community 47 - "i_firebase_crashlytics_service.dart"
Cohesion: 0.18
Nodes (9): checkForUnsentReports, clearUserInfo, logApiCall, logBreadcrumb, logNavigation, logUserAction, sendUnsentReports, setSessionContext (+1 more)

### Community 48 - "firebase_remote_config_driver.dart"
Cohesion: 0.18
Nodes (8): crashLog, getAll, getBool, getDouble, getInt, getString, getValue, init

### Community 49 - "received_notifications_model.dart"
Cohesion: 0.20
Nodes (7): fromEntity, fromMap, props, ReceivedNotificationEntity, stringify, toEntity, toJson

### Community 50 - "dart:async"
Cohesion: 0.22
Nodes (4): haveNetworkConnection, onConnectivityChanged, haveNetworkConnection, onConnectivityChanged

### Community 51 - "firebase_storage_service.dart"
Cohesion: 0.20
Nodes (7): docDelete, docGet, docSet, docUpdate, firebaseStorageDriver, getCollection, getCollectionStream

### Community 52 - "Equatable"
Cohesion: 0.20
Nodes (7): BasePath, copyWith, pageNumber, pageSize, QueryParamsEntity, QueryParamsModel, ReceivedNotificationModel

### Community 53 - "i_firebase_storage_driver.dart"
Cohesion: 0.20
Nodes (8): FirebaseStorageDriver, docDelete, docGet, docSet, docUpdate, getCollection, getCollectionStream, IFirebaseStorageDriver

### Community 54 - "device_info_entity.dart"
Cohesion: 0.20
Nodes (9): data, DeviceInfoEntity, id, isPhysicalDevice, localizedModel, model, name, serialNumber (+1 more)

### Community 55 - "firebase_purchase_entity.dart"
Cohesion: 0.20
Nodes (9): affiliation, copyWith, coupon, currency, items, shipping, tax, transactionId (+1 more)

### Community 56 - "i_crash_log_failure.dart"
Cohesion: 0.20
Nodes (9): exception, ICrashLogFailure, params, path, props, stackTrace, stringify, toString (+1 more)

### Community 57 - "log_event_model.dart"
Cohesion: 0.22
Nodes (7): LogEventEntity, fromEntity, fromMap, LogEventModel, props, stringify, toEntity

### Community 58 - "firebase_storage_driver.dart"
Cohesion: 0.22
Nodes (7): crashLog, docDelete, docGet, docSet, docUpdate, getCollection, getCollectionStream

### Community 59 - "permission_service.dart"
Cohesion: 0.22
Nodes (5): IPermissionService, getPermissionStatus, openAppPermissionSettings, PermissionService, requestPermission

### Community 60 - "../../domain/interfaces/either.dart"
Cohesion: 0.22
Nodes (6): IFirebaseCrashlyticsService, ICrashLogService, init, setError, init, FirebaseCrashlyticsService

### Community 61 - "secure_storage_service.dart"
Cohesion: 0.22
Nodes (6): deleteAll, getAllValues, getStringByKey, removeStringByKey, setStringByKey, storageDriver

### Community 62 - "i_navigation_arguments_driver.dart"
Cohesion: 0.22
Nodes (6): data, INavigationArgumentsDriver, params, queryParams, queryParamsAll, uri

### Community 63 - "secure_storage_driver.dart"
Cohesion: 0.22
Nodes (6): deleteAll, getAllValues, getStringByKey, removeStringByKey, setStringByKey, _storage

### Community 64 - "firebase_begin_checkout_entity.dart"
Cohesion: 0.22
Nodes (7): copyWith, coupon, currency, FirebaseBeginCheckoutEntity, items, value, FirebaseBeginCheckoutModel

### Community 65 - "i_firebase_storage_service.dart"
Cohesion: 0.22
Nodes (8): docDelete, docGet, docSet, docUpdate, getCollection, getCollectionStream, IFirebaseStorageService, FirebaseStorageService

### Community 66 - "connectivity_driver.dart"
Cohesion: 0.25
Nodes (3): connectivity, ConnectivityDriver, IConnectivityDriver

### Community 67 - "List"
Cohesion: 0.25
Nodes (5): didPop, didPush, didRemove, didReplace, _routeStack

### Community 69 - "connectivity_service.dart"
Cohesion: 0.25
Nodes (5): IConnectivityService, ConnectivityService, driver, haveNetworkConnection, onConnectivityChanged

### Community 70 - "i_local_notifications_service.dart"
Cohesion: 0.25
Nodes (6): ILocalNotificationsService, init, requestPermissions, scheduleNotification, showNotification, LocalNotificationsService

### Community 71 - "string"
Cohesion: 0.25
Nodes (3): capitalize, StringExt, tryParseToInt

### Community 72 - "firebase_add_to_cart_entity.dart"
Cohesion: 0.25
Nodes (6): copyWith, currency, FirebaseAddToCartEntity, items, value, FirebaseAddToCartModel

### Community 73 - "base_path.dart"
Cohesion: 0.25
Nodes (6): path, prevPath, props, relativePath, rootPath, toString

### Community 74 - "i_secure_storage_driver.dart"
Cohesion: 0.25
Nodes (7): SecureStorageDriver, deleteAll, getAllValues, getStringByKey, ISecureStorageDriver, removeStringByKey, setStringByKey

### Community 75 - "i_firebase_notifications_service.dart"
Cohesion: 0.25
Nodes (7): configure, getInitialNotification, getInstallationId, getToken, saveToken, subscribeToTopic, unsubscribeFromTopic

### Community 76 - "i_secure_storage_service.dart"
Cohesion: 0.25
Nodes (7): deleteAll, getAllValues, getStringByKey, ISecureStorageService, removeStringByKey, setStringByKey, SecureStorageService

### Community 77 - "base_core"
Cohesion: 0.25
Nodes (7): base_core, 👉 Como Usar, 👉 Contribuição, Exemplo Básico de Uso, 👉 Instalação, 👉 Licença, 👉 Recursos

### Community 79 - "custom_router_observer.dart"
Cohesion: 0.29
Nodes (3): RouterObserver, CustomRouterObserver, _instance

### Community 80 - "i_app_tracking_service.dart"
Cohesion: 0.29
Nodes (5): IFirebaseAnalyticsService, createEvent, IAppTrackingService, init, FirebaseAnalyticsService

### Community 81 - "../interfaces/either.dart"
Cohesion: 0.29
Nodes (3): getCurrentPosition, ILocationService, LocationService

### Community 82 - "Map"
Cohesion: 0.29
Nodes (4): copyWith, name, parameters, sanitized

### Community 83 - "../../../domain/entities/log_event_entity.dart"
Cohesion: 0.33
Nodes (4): FirebaseAnalyticsDriver, IFirebaseAnalyticsDriver, createEvent, IAppTrackingDriver

### Community 84 - "i_permission_service.dart"
Cohesion: 0.33
Nodes (3): getPermissionStatus, openAppPermissionSettings, requestPermission

### Community 85 - "../../../domain/entities/firebase_purchase_entity.dart"
Cohesion: 0.40
Nodes (3): FirebasePurchaseEntity, FirebasePurchaseModel, fromEntity

### Community 86 - "analysis_options.yaml"
Cohesion: 0.50
Nodes (3): analyzer, exclude, include

### Community 87 - "permission_status_type_enum.dart"
Cohesion: 0.67
Nodes (3): permissionStatusFromType, PermissionStatusType, PermissionStatusTypeExt

## Knowledge Gaps
- **741 isolated node(s):** `title`, `_counter`, `main`, `build`, `createState` (+736 more)
  These have ≤1 connection - possible missing edges or undocumented components. (Counts symbols only; 1317 node(s) total have ≤1 connection when file, concept and rationale nodes are included.)
- **19 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `Win32Window` connect `win32_window.cpp` to `flutter_window.h`?**
  _High betweenness centrality (0.024) - this node is a cross-community bridge._
- **What connects `title`, `_counter`, `main` to the rest of the system?**
  _741 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `base_core.dart` be split into smaller, more focused modules?**
  _Cohesion score 0.017241379310344827 - nodes in this community are weakly interconnected._
- **Why does `QueryParamsModel` connect `Equatable` to `query_params_model.dart`?**
  _High betweenness centrality (0.017) - this node is a cross-community bridge._
- **Should `CHANGELOG.md` be split into smaller, more focused modules?**
  _Cohesion score 0.029411764705882353 - nodes in this community are weakly interconnected._
- **Why does `FlutterWindow` connect `win32_window.cpp` to `flutter_window.h`?**
  _High betweenness centrality (0.009) - this node is a cross-community bridge._
- **Should `win32_window.cpp` be split into smaller, more focused modules?**
  _Cohesion score 0.05268065268065268 - nodes in this community are weakly interconnected._