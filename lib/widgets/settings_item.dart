import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  final IconData? icon;
  final String title;
  final VoidCallback onTap;
  final bool showDivider;
  final Color? textColor;
  final Color? iconColor;

  const SettingsItem({
    super.key,
    this.icon,
    required this.title,
    required this.onTap,
    this.showDivider = true,
    this.textColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 4.0),
            child: Row(
              children: [
                if (icon != null)
                  Icon(
                    icon,
                    size: 24,
                    color: iconColor ?? Colors.black87,
                  )
                else
                  const SizedBox(width: 24), // Keep alignment with icon items

                const SizedBox(width: 18),

                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: textColor ?? Colors.black87,
                    ),
                  ),
                ),

                const Icon(
                  Icons.chevron_right,
                  size: 24,
                  color: Colors.black87,
                ),
              ],
            ),
          ),
        ),
        if (showDivider)
          const Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFFEEEEEE),
          ),
      ],
    );
  }
}
