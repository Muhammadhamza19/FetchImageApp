import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_app/support/config/app_theme.dart';
import 'package:image_app/ui/base_screen.dart';
import 'package:image_app/ui/shared/components/my_error_view.dart';
import 'package:image_app/ui/shared/components/progression_button_view.dart';
import 'package:image_app/ui/shared/components/shimmer_components/loading_card.dart';
import 'package:image_app/ui/shared/components/shimmer_components/shimmer_widget.dart';
import 'package:image_app/view_models/user_view_model.dart';

class ActivationMainPage extends StatelessWidget {
  const ActivationMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserViewModel>(
      init: UserViewModel(),
      dispose: (_) => Get.find<UserViewModel>().onClose(),
      builder: (model) {
        return Obx(
          () {
            /// Show loader during page load

            return model.shouldNotify.value
                ? BaseScreen(
                    title: "Image Activation",
                    automaticallyImplyLeading: false,
                    backgroundColor: model.dominantColor,
                    actions: [
                      Switch(
                          value: isDark,
                          onChanged: (val) {
                            model.toggleTheme();
                          })
                    ],
                    body: Obx(() {
                      if (model.isLoading) {
                        return _loadingContent();
                      }

                      /// Show error state
                      if (model.isError) {
                        return MyErrorView(
                          model.errorMessage.value,
                          refreshFunction: model.fetchData,
                        );
                      }
                      return RefreshIndicator(
                        onRefresh: model.fetchData,
                        child: _pageContent(context, model),
                      );
                    }))
                : const SizedBox();
          },
        );
      },
    );
  }

  Widget _pageContent(BuildContext context, UserViewModel model) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: model.imageResponse == null
                ? const CircularProgressIndicator()
                : AspectRatio(
                    aspectRatio: 1, // square image
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: FastCachedImage(
                        url: model.imageResponse!.url!,
                        // fit: BoxFit.cover,
                        fadeInDuration: const Duration(milliseconds: 500),
                        loadingBuilder: (context, progress) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.error,
                                size: 50, color: Colors.red),
                      ),
                    ),
                  ),
          ),
          ProgressionButtonView(
              dominantColor: model.dominantColor,
              progressionButtons: [
                ProgressionButton(
                  text: 'Another',
                  onPressed: () {
                    model.fetchData();
                  },
                )
              ]),
        ],
      ),
    );
  }

  Widget _loadingContent() {
    return Column(
      children: [
        const Center(
          child: ShimmerWidget(child: SizedBox(child: LoadingCard())),
        ),
        ProgressionButtonView(
            loading: true,
            progressionButtons: [ProgressionButton(text: 'Loading...')]),
      ],
    );
  }
}
