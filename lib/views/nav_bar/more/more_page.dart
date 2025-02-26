// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:store_redirect/store_redirect.dart';

import '../../../core/helper_methods.dart';
import '../../constant/logo_name.dart';
import '../../developer/developer_info.dart';
import '../../quran_font/quran_font.dart';
import 'theme_button.dart';

class MorePage extends StatefulWidget {
  const MorePage({
    super.key,
  });

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
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
        ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          leading: Icon(
            Icons.dark_mode,
            color: Theme.of(context).iconTheme.color,
          ),
          title: Text(
            'الوضع الداكن',
            style: TextStyle(
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          trailing: const ChangeThemeButton(),
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
