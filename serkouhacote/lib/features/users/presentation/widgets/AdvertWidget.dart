import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// Clickable_AD_Image widget displays an image that, when tapped, opens a URL
// Clickable_AD_Image 위젯은 탭하면 URL을 여는 이미지를 표시합니다
class Clickable_AD_Image extends StatelessWidget {
  final String imageUrl; // URL of the image to display
  final String link; // URL to open when the image is tapped

  // Constructor to initialize imageUrl and link
  // imageUrl과 link를 초기화하는 생성자
  const Clickable_AD_Image({
    required this.imageUrl,
    required this.link,
  });

  // Method to launch the URL in a web browser
  // 웹 브라우저에서 URL을 여는 메소드
  Future<void> _launchURL() async {
    try {
      final Uri uri = Uri.parse(link); // Parse the URL
      await launchUrl(uri); // Open the URL
    } catch (e) {
      _showError(
          "An error occurred while launching the URL."); // Show error if URL launch fails
    }
  }

  // Method to show an error message
  // 오류 메시지를 표시하는 메소드
  void _showError(String message) {
    // You can use a SnackBar, AlertDialog, or any other method to show the error message
    // SnackBar, AlertDialog 또는 다른 방법을 사용하여 오류 메시지를 표시할 수 있습니다
    print(message); // This is just for debugging purposes
    // 디버깅 목적으로만 사용됩니다
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _launchURL(); // Launch the URL when the image is tapped
      },
      child: Container(
        width: double.infinity, // Full width of the parent container
        height: 150, // Fixed height for the image container
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imageUrl), // Load the image from the network
            fit: BoxFit.cover, // Ensure the image covers the entire container
          ),
        ),
      ),
    );
  }
}
