import 'package:event_app/core/providers/app_configprovider.dart';
import 'package:event_app/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SwitchButtonui extends StatelessWidget {
  final Widget switchType;
  final String title;
  final IconData icon;
  const SwitchButtonui({
    super.key,
    required this.switchType,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    var appConfigProvider = Provider.of<AppConfigprovider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: appConfigProvider.isDark()
              ? AppColors.darkPurple.withOpacity(0.4)
              : AppColors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.purple.withOpacity(0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.purple.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.purple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppColors.purple, size: 24),
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            switchType,
          ],
        ),
      ),
    );
  }
}
