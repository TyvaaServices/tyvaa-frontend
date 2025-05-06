import 'package:flutter/material.dart';

class ChatBotCard extends StatelessWidget {
  const ChatBotCard({
    super.key,
    required this.context,
    required this.name,
    required this.description,
    required this.personality,
    required this.imagePath,
    required this.isSelected,
    required this.onPressed,
    required this.primaryColor,
    required this.secondaryColor,
    required this.cardColor,
    required this.textColor,
  });

  final BuildContext context;
  final String name;
  final String description;
  final String personality;
  final String imagePath;
  final bool isSelected;
  final VoidCallback onPressed;
  final Color primaryColor;
  final Color secondaryColor;
  final Color cardColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOutQuint,
        width: double.infinity,
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isSelected ? secondaryColor : cardColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color:
                  isSelected
                      ? primaryColor.withOpacity(0.2)
                      : Colors.black.withOpacity(0.05),
              spreadRadius: 0,
              blurRadius: isSelected ? 20 : 10,
              offset: Offset(0, 5),
            ),
          ],
          border: Border.all(
            color: isSelected ? primaryColor : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Avatar container
            Hero(
              tag: 'avatar_$name',
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? primaryColor : secondaryColor,
                  boxShadow:
                      isSelected
                          ? [
                            BoxShadow(
                              color: primaryColor.withOpacity(0.4),
                              blurRadius: 20,
                              spreadRadius: 0,
                            ),
                          ]
                          : [],
                ),
                padding: EdgeInsets.all(isSelected ? 0 : 12),
                child: Image.asset(imagePath, fit: BoxFit.contain),
              ),
            ),
            SizedBox(width: 24),
            // Info container
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name & Check
                  Row(
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: isSelected ? primaryColor : textColor,
                        ),
                      ),
                      SizedBox(width: 10),
                      if (isSelected)
                        Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 8),
                  // Description
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: textColor.withOpacity(0.7),
                      height: 1.4,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 12),
                  // Personality tags
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color:
                          isSelected
                              ? primaryColor.withOpacity(0.2)
                              : secondaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      personality,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
