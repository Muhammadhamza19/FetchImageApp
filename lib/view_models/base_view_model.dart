import 'package:image_app/support/network/api_response.dart';
import 'package:get/get.dart';
import 'package:image_app/support/enums/e_view_state.dart';

class BaseViewModel extends GetxController {
  RxBool shouldNotify = true.obs;
  RxString errorMessage = "".obs;
  final Rx<EViewState> _state = EViewState.complete.obs;

  EViewState get state => _state.value;

  bool get loadingOrError => state != EViewState.complete;
  bool get isLoading => state == EViewState.loading;
  bool get isComplete => state == EViewState.complete;
  bool get isError => state == EViewState.error;

  void setState(EViewState viewState) {
    _state.value = viewState;
    notify();
  }

  void setLoading() => setState(EViewState.loading);
  void setComplete() => setState(EViewState.complete);
  void setError() => setState(EViewState.error);

  void notify() {
    shouldNotify.value = false;
    shouldNotify.value = true;
  }

  bool checkErrorAndSetState(ApiResponse response) {
    if (response.statusCode != 200) {
      setState(EViewState.error);
      return true;
    }
    return false;
  }

  @override
  void onClose() {
    // shouldNotify.value = false;
    super.onClose();
  }

  void redirectToServerError() async {}
}
