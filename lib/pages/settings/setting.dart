import 'package:flutter/material.dart';
import 'package:moneyflow/app.dart';
import 'package:moneyflow/provider/theme_provider.dart';
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            color: Colors.red,
            child: Row(
              children: [
                CircleAvatar(),
                Column(children: [Text("Kalix"), Text("Personal Finance")]),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_forward_ios_rounded),
                ),
              ],
            ),
          ),

          Text("Preferences"),
          ListTile(
            title: Text("Dark Mode"),
            // trailing: Switch(
            //   value: Provider.of<ThemeProvider>(context).isDarkMode,
            //   onChanged: (value) {
            //     Provider.of<ThemeProvider>(context, listen: false).triger();
            //   },
            // ),
          ),
          ElevatedButton(
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).triger();
            },
            child: Text("Switch"),
          ),
          // ListView.builder(itemBuilder: (context,index){})
        ],
      ),
    );
  }
}
