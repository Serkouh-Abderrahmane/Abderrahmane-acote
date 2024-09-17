import 'package:flutter/material.dart';
import 'package:serkouhacote/core/theme/Colors.dart';
import 'package:serkouhacote/core/theme/Paddings.dart';
import 'package:serkouhacote/core/theme/fontsize.dart';
import 'package:serkouhacote/core/theme/spacing.dart';
import 'package:serkouhacote/features/users/domain/entities/Repositorie.dart';

// CabinetProposalCard displays information about a repository in a card format
// CabinetProposalCard는 카드 형식으로 저장소에 대한 정보를 표시합니다
class CabinetProposalCard extends StatelessWidget {
  final Repository repository; // Repository data to be displayed

  // Constructor to initialize the repository
  // repository를 초기화하는 생성자
  const CabinetProposalCard({
    Key? key,
    required this.repository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior
          .translucent, // Allows for touch detection even if part of the widget is transparent
      onTap: () {
        // Action to be performed on tap can be added here
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Paddings.base, // Horizontal padding from theme
          vertical: Paddings.base, // Vertical padding from theme
        ),
        decoration: BoxDecoration(
          color: AppColors.primaryWhite
              .withOpacity(0.2), // Light background color with opacity
          borderRadius: BorderRadius.circular(8), // Rounded corners
          border: Border.all(
            color: AppColors.primaryGray, // Border color from theme
            width: 1, // Border width
          ),
        ),
        child: Column(
          children: [
            _cardHeader(), // Header section of the card
            SizedBox(
              height: Spacing.base, // Space between header and body
            ),
            _cardBody(), // Body section of the card
            SizedBox(
              height: Spacing.base, // Space after body
            ),
          ],
        ),
      ),
    );
  }

  // Builds the body of the card with repository description
  // 카드의 본문을 저장소 설명과 함께 구성합니다
  Widget _cardBody() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start, // Align text to start
      children: [
        Expanded(
          child: Text(
            repository.description, // Repository description
            style: TextStyle(
              fontSize: FontSizes.medium, // Font size from theme
              color: AppColors.secondarygrey, // Text color from theme
              fontWeight: FontWeight.bold, // Font weight for emphasis
            ),
            maxLines: 2, // Limit the text to 2 lines
            overflow: TextOverflow
                .ellipsis, // Truncate text with ellipsis if it's too long
          ),
        ),
      ],
    );
  }

  // Builds the header of the card with repository name, language, and stargazers count
  // 카드의 헤더를 저장소 이름, 언어 및 스타 수와 함께 구성합니다
  Widget _cardHeader() {
    return Row(
      children: [
        Container(
          width: 65, // Fixed width for the star count container
          padding: const EdgeInsets.only(
              top: 5,
              right: 7.5,
              bottom: 5,
              left: 7.5), // Padding around the star count
          decoration: BoxDecoration(
            color:
                AppColors.primaryBlack, // Background color for the star count
            borderRadius: BorderRadius.circular(999), // Circular border radius
          ),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.center, // Center align items in the row
            children: [
              Icon(
                Icons.star, // Star icon to represent stargazers
                size: FontSizes.medium, // Icon size from theme
                color: AppColors.primaryWhite, // Icon color from theme
              ),
              SizedBox(
                width: Spacing.xsmall, // Space between icon and text
              ),
              Text(
                repository.stargazersCount.toString(), // Number of stargazers
                style: TextStyle(
                    fontSize: FontSizes.medium, // Font size for stargazer count
                    color: AppColors.primaryWhite), // Font color
              ),
            ],
          ),
        ),
        SizedBox(
          width:
              Spacing.base, // Space between star count and repository details
        ),
        Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align column children to start
          children: [
            Text(
              repository.name, // Repository name
              style: TextStyle(
                fontSize: FontSizes.xLarge, // Font size for the repository name
                fontWeight: FontWeight.bold, // Bold font weight for emphasis
              ),
            ),
            Text(
              repository.language, // Repository language
              style: TextStyle(
                fontSize:
                    FontSizes.medium, // Font size for the repository language
                color: AppColors.secondaryblack, // Font color
              ),
            ),
          ],
        ),
      ],
    );
  }
}
