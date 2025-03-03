// ignore_for_file: unused_import, file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/helper_methods.dart';
import '../../../core/constant/logo_name.dart';
import '../../../model/AzkarModel.dart';
import '../../../provider/theme_provider.dart';
import 'Azkar/AzkarScreen.dart';
import 'developer/developer_info.dart';
import '../../widget/quran_font/quran_font.dart';
import 'theme_button.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            const SizedBox(
              height: 60,
            ),
            const LogoName(),
            const SizedBox(
              height: 40,
            ),
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              leading: Icon(
                Icons.format_size,
                color: Theme.of(context).iconTheme.color,
              ),
              title: Text(
                'حجم الخط',
                style: TextStyle(
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
              onTap: () {
                navigateTo(
                  page: const QuranFont(),
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              leading: Icon(
                Icons.dark_mode,
                color: Theme.of(context).iconTheme.color,
              ),
              title: Text(
                'الوضع الليلي',
                style: TextStyle(
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
              trailing: const ChangeThemeButton(),
            ),
            const SizedBox(height: 10),
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              leading: Icon(
                Icons.wb_sunny,
                color: Theme.of(context).iconTheme.color,
              ),
              title: Text(
                'أذكار الصباح',
                style: TextStyle(
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
              onTap: () async {
                AzkarModel azkarSabah =
                    await loadAzkarData(jsonFile: 'azkar_sabah');
                navigateTo(
                  page: AzkarScreen(azkarData: azkarSabah),
                );
              },
            ),
            const SizedBox(height: 10),
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              leading: Icon(
                Icons.nightlight_round,
                color: Theme.of(context).iconTheme.color,
              ),
              title: Text(
                'أذكار المساء',
                style: TextStyle(
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
              onTap: () async {
                AzkarModel azkarMassa =
                    await loadAzkarData(jsonFile: 'azkar_massa');
                navigateTo(
                  page: AzkarScreen(azkarData: azkarMassa),
                );
              },
            ),
            const SizedBox(height: 10),
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              leading: Icon(
                Icons.access_time,
                color: Theme.of(context).iconTheme.color,
              ),
              title: Text(
                'أذكار بعد الصلاة',
                style: TextStyle(
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
              onTap: () async {
                AzkarModel azkarPostPrayer =
                    await loadAzkarData(jsonFile: 'PostPrayer_azkar');
                navigateTo(
                  page: AzkarScreen(azkarData: azkarPostPrayer),
                );
              },
            ),
            const SizedBox(height: 10),
            // ListTile(
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(12),
            //   ),
            //   leading: Icon(
            //     Icons.share_outlined,
            //     color: Theme.of(context).iconTheme.color,
            //   ),
            //   title: Text(
            //     'شارك التطبيق',
            //     style: TextStyle(
            //       color: Theme.of(context).iconTheme.color,
            //     ),
            //   ),
            //   onTap: () {
            //     StoreRedirect.redirect(
            //       // androidAppId: "com.quran_karim.quran_karim",
            //       iOSAppId: "",
            //     );
            //   },
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              leading: Icon(
                Icons.developer_mode_outlined,
                color: Theme.of(context).iconTheme.color,
              ),
              title: Text(
                'مطور التطبيق',
                style: TextStyle(
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
              onTap: () {
                navigateTo(
                  page: const DeveloperInfo(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
