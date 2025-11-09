import 'package:image_app/model/image.dart';
import 'package:image_app/providers/base_provider.dart';
import 'package:image_app/support/enums/e_http_method.dart';
import 'package:image_app/support/network/api_response.dart';

class ImageProvider extends BaseProvider {
  Future<ApiResponse<ImageResposnse>> getImage() async {
    return execute(
      endpoint: 'image/',
      method: HttpMethod.get,
      parser: (json) => ImageResposnse.fromJson(json),
      toCache: (json) => ImageResposnse.fromJson(json),
    );
  }
}
