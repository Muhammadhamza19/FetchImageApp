🖼️ Image App

A Flutter application that fetches random images from an API and dynamically updates the background color based on the image’s vibrant color.
This project follows the MVVM (Model–View–ViewModel) architecture pattern and uses Provider for state management, Repository for API handling, and Palette Generator for color extraction.

🚀 Features

🎨 Fetches random images from a REST API

🌈 Extracts dominant/vibrant color from the image using palette_generator

⚙️ Uses MVVM architecture for clean separation of concerns

🧩 Includes Provider for reactive state management

📡 Implements Repository pattern for API integration

⚡ Uses fast_cached_network_image for efficient image caching and fast loading


Example code
        final PaletteGeneratorMaster paletteGenerator =
            await PaletteGeneratorMaster.fromImageProvider(
          FastCachedImageProvider(imageResp.data?.url ?? ''),
          // Image.network(imageResp.data?.url ?? '').image,
          maximumColorCount: 16,
          colorSpace: ColorSpace.lab, // Use LAB color space for better accuracy
          generateHarmony: true, // Generate color harmony
        );

        dominantColor = paletteGenerator.mutedColor?.color;

        💡 How It Works

When the user taps the “New Image” button, the ViewModel calls the repository.

The repository fetches a new random image from the API.

The ViewModel updates the image URL and triggers PaletteGenerator to extract the color.

The UI reacts automatically via Provider, updating the background color smoothly.
