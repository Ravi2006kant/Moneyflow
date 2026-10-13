import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneyflow/pages/local_storage.dart';
import 'package:moneyflow/provider/theme_provider.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Settings", style: TextStyle(fontWeight: .bold)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(25),
              ),
              height: 100,

              child: Row(
                mainAxisAlignment: .start,

                children: [
                  CircleAvatar(radius: 45, backgroundColor: Colors.red),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 15,
                    ),
                    child: Column(
                      crossAxisAlignment: .start,
                      mainAxisAlignment: .start,
                      children: [
                        Text(
                          "Kalix",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "Personal Finance",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 100),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "Preferences",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: Icon(Icons.dark_mode_rounded),
              title: Text("Dark Mode"),
              trailing: CupertinoSwitch(
                value: Provider.of<ThemeProvider>(context).isDarkMode,
                onChanged: (value) {
                  setState(() {
                    // LocalStorage.setDarkMode(value);
                    Provider.of<ThemeProvider>(context, listen: false).triger();
                  });
                },
              ),
              // trailing: Switch(
              //   value: Provider.of<ThemeProvider>(context).isDarkMode,
              //   onChanged: (value) {
              //     Provider.of<ThemeProvider>(context, listen: false).triger();
              //   },
              // ),
            ),
            ListTile(
              leading: Icon(Icons.language_rounded),
              title: Text("Language"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              leading: Icon(Icons.currency_exchange_rounded),
              title: Text("Currency"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "Data Management",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: Icon(Icons.share_rounded),
              title: Text("Export Data"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              leading: Icon(Icons.cleaning_services_outlined),
              title: Text("Clear Data"),
              trailing: IconButton(
                onPressed: () {
                  setState(() {
                    LocalStorage.prefs.clear();
                  });
                },
                icon: Icon(Icons.delete, color: Colors.red),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text("App", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            ListTile(
              leading: Icon(Icons.notifications_active),
              title: Text("Notifications"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text("About Moneyflow "),
            ),
          ],
        ),
      ),
    );
  }
}
