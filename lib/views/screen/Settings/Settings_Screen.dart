// ignore_for_file: unused_import, file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/helper_methods.dart';
import '../../../core/constant/logo_name.dart';
import '../../../provider/theme_provider.dart';
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
    return ListView(
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
        InkWell(
          onTap: () {
            ThemeProvider themeProvider =
                Provider.of<ThemeProvider>(context, listen: false);
            themeProvider.changeTheme();
            setState(() {});
          },
          child: ListTile(
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
        ),
        const SizedBox(
          height: 10,
        ),
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
    );
  }
}
