import 'package:image_app/model/image.dart';
import 'package:image_app/providers/image_provider.dart';
import 'package:image_app/repository/base_repository.dart';
import 'package:image_app/support/network/api_response.dart';

class ImageRepository extends BaseRepository {
  final _provider = ImageProvider();

  Future<ApiResponse<ImageResposnse>> getImage() async => _provider.getImage();
}
