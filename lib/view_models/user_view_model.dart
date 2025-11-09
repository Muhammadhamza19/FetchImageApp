import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:image_app/model/image.dart';
import 'package:image_app/repository/image_repository.dart';
import 'package:image_app/support/helper/device_info_helper.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_app/support/config/app_shared_pref.dart';
import 'package:image_app/view_models/base_view_model.dart';
import 'dart:async';

import 'package:palette_generator_master/palette_generator_master.dart';

class UserViewModel extends BaseViewModel {
  /// Repository
  final _repository = ImageRepository();
  Map<String, dynamic> deviceDetails = {};
  RxBool isDarkTheme = false.obs;
  ImageResposnse? imageResponse;
  Color? dominantColor;

  UserViewModel() {
    fetchData();
  }

  /// Constructor
  static UserViewModel instance() {
    if (!Get.isRegistered<UserViewModel>()) {
      return Get.put(UserViewModel());
    } else {
      final viewModel = Get.find<UserViewModel>();
      return viewModel;
    }
  }

  // This method retrieves the device info

  /// Common methods
  Future<void> fetchData() async {
    try {
      setLoading();
      final resp = await getDeviceInfo();
      deviceDetails = resp;
      final imageResp = await _repository.getImage();
      if (imageResp.isSuccess) {
        imageResponse = imageResp.data;
        final PaletteGeneratorMaster paletteGenerator =
            await PaletteGeneratorMaster.fromImageProvider(
          FastCachedImageProvider(imageResp.data?.url ?? ''),
          // Image.network(imageResp.data?.url ?? '').image,
          maximumColorCount: 16,
          colorSpace: ColorSpace.lab, // Use LAB color space for better accuracy
          generateHarmony: true, // Generate color harmony
        );

        dominantColor = paletteGenerator.mutedColor?.color;
        setComplete();
      } else {
        errorMessage.value = imageResp.message ?? 'Something went wrong';
        setError();
      }
    } catch (e) {
      errorMessage.value = e.toString();
      setError();
    }
  }

  /// getters
  bool get isLogin {
    return AppSharedPref.getAccessToken() != null;
  }

  /// methods
  void toggleTheme() {
    isDarkTheme.toggle();
    notify();
  }

  void updateLanguage(String languageCode) {
    Get.updateLocale(Locale(languageCode));
  }
}

UserViewModel get userViewModel => UserViewModel.instance();
