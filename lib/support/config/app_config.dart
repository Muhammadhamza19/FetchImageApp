import 'package:image_app/support/config/asset_helper.dart';

class AppConfig {
  // Constants used to pass from --dart-define
  static const String baseUrlKey = 'baseUrl';
  static const String streamUrlKey = 'streamUrl';
  static const String realStateUrlKey = 'realStateUrl';
  static const String streamChatApiKeyKey = 'streamChatApiKey';
  static const String workforceUrlKey = 'workforceUrl';
  static const String googleMapKey = 'googleMapKey';

  // Static fallback (compile-time) values
  static const String _baseUrl =
      String.fromEnvironment(baseUrlKey, defaultValue: '');
  static const String _realEstateUrl =
      String.fromEnvironment(realStateUrlKey, defaultValue: '');

  static const String _googleAPI =
      String.fromEnvironment(googleMapKey, defaultValue: '');
  static const String _streamUrl =
      String.fromEnvironment(streamUrlKey, defaultValue: '');
  static const String _streamChatApiKey =
      String.fromEnvironment(streamChatApiKeyKey, defaultValue: '');
  static const String _workForceUrl =
      String.fromEnvironment(workforceUrlKey, defaultValue: '');

  // Parsed JSON from asset
  Map<String, dynamic>? instanceJson;

  /// Getter - resolves from asset JSON or fallback
  String get baseUrl => instanceJson?[baseUrlKey] ?? _baseUrl;
  String get realStateUrl => instanceJson?[realStateUrlKey] ?? _realEstateUrl;

  String get googleAPI => instanceJson?[googleMapKey] ?? _googleAPI;

  String get streamUrl => instanceJson?[streamUrlKey] ?? _streamUrl;
  String get streamChatApiKey =>
      instanceJson?[streamChatApiKeyKey] ?? _streamChatApiKey;
  String get workforceUrl => instanceJson?[workforceUrlKey] ?? _workForceUrl;

  /// One-time async initializer
  Future<void> initialise(String? instanceId) async {
    final assetPath = 'instance_settings/$instanceId.json';

    if (instanceId != null &&
        instanceId.isNotEmpty &&
        await doesAssetExist(assetPath)) {
      instanceJson = await getJsonFromAssets(assetPath);
    } else {
      instanceJson = null;
    }
  }
}
