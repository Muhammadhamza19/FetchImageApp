import 'package:image_app/support/config/app_shared_pref.dart';

class BaseRepository {
  String get token => AppSharedPref.getAccessToken() ?? "";
}
