import 'package:flutter/material.dart';
import 'package:serkouhacote/core/theme/Colors.dart';
import 'package:serkouhacote/core/theme/fontsize.dart';
import 'package:serkouhacote/features/users/domain/entities/Users.dart';

// CustomProfileHeader is a widget for displaying user profile information
// CustomProfileHeader는 사용자 프로필 정보를 표시하는 위젯입니다
class CustomProfileHeader extends StatelessWidget {
  final User user; // The user whose profile is being displayed

  // Constructor to initialize the CustomProfileHeader with a User
  // 사용자 프로필을 표시하기 위해 CustomProfileHeader를 User로 초기화하는 생성자
  const CustomProfileHeader({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Full width of the container
      padding: const EdgeInsets.only(bottom: 4), // Padding at the bottom
      decoration: const BoxDecoration(
        color: Colors.white, // Background color of the profile header
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.center, // Center align children horizontally
        mainAxisAlignment:
            MainAxisAlignment.center, // Center align children vertically
        children: [
          const SizedBox(height: 16), // Spacer for vertical spacing
          Stack(
            children: [
              CircleAvatar(
                radius: 45, // Radius of the profile picture
                backgroundImage:
                    NetworkImage(user.avatarUrl), // Display user avatar
              ),
              Positioned(
                top: 0, // Position the edit button at the top
                right: 0, // Position the edit button to the right
                child: GestureDetector(
                  onTap: () {
                    // TODO: Implement edit profile functionality
                  },
                  child: const CircleAvatar(
                    backgroundColor: AppColors
                        .primaryWhite, // Background color of the edit button
                    radius: 14, // Radius of the edit button
                    child: Icon(Icons.edit,
                        color: AppColors.primaryBlack), // Edit icon
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8), // Spacer for vertical spacing
          Text(
            user.name, // Display the user's name
            style: TextStyle(
              fontSize: FontSizes.x2Large, // Font size for the user's name
              fontWeight: FontWeight.bold, // Bold text for the user's name
              color: AppColors.secondarygrey, // Text color for the user's name
            ),
          ),
          const SizedBox(height: 16), // Spacer for vertical spacing
        ],
      ),
    );
  }
}
