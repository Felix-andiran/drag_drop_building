import 'package:flutter/material.dart';


class CustomerCard extends StatelessWidget {
  final double width;
  final double height;
  final String title;
  final String value;
  final String subtitle;
  final double titleFontSize;
  final double valueFontSize;
  final double subtitleFontSize;
  final int titleColor;
  final int valueColor;
  final int subtitleColor;
  final int backgroundColor;
  final int iconColor;

  const CustomerCard({
    super.key,
    required this.width,
    required this.height,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.titleFontSize,
    required this.valueFontSize,
    required this.subtitleFontSize,
    required this.titleColor,
    required this.valueColor,
    required this.subtitleColor,
    required this.backgroundColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        width: width,
        height: height,
        color: Color(backgroundColor),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.w500,
                    color: Color(titleColor),
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.more_vert,
                  color: Color(iconColor),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              value,
              style: TextStyle(
                fontSize: valueFontSize,
                fontWeight: FontWeight.bold,
                color: Color(valueColor),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: TextStyle(
                color: Color(subtitleColor),
                fontSize: subtitleFontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
