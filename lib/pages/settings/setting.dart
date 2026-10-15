import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneyflow/pages/local_storage.dart';
import 'package:moneyflow/provider/theme_provider.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import '../../database/dbHelper.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {

  void deletedb() async {
    final records = await Dbhelper.getInstance().getallNotes();
    for (final record in records) {
      debugPrint(record.toString());
    }
  }
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
              width: double.infinity,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color:Theme.of(context).colorScheme.inversePrimary,
                borderRadius: BorderRadius.circular(25),
              ),
              height: 100,

              child: Row(
                mainAxisAlignment: .start,

                children: [
                  CircleAvatar(radius: 45, backgroundColor: Colors.red),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
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
                  Spacer(),
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
                value: context.watch<ThemeProvider>().isDarkMode,
                onChanged: (value) {
                  setState(() {
                    // LocalStorage.setDarkMode(value);
                    // Provider.of<ThemeProvider>(context, listen: false).trigger();
                    context.read<ThemeProvider>().trigger();
                  });
                },
              ),


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
            ListTile(contentPadding: EdgeInsets.symmetric(horizontal: 15),
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
              trailing: IconButton(onPressed: (){
Dbhelper.getInstance().allDeleteNote();
                }, icon: Icon(Icons.delete_forever)),
            ),
          ],
        ),
      ),
    );
  }
}


/*
You already have a habit of “let me picture how this should work in my head first” — that’s actually a strength (you did it with your carousel tool, your investment blueprint). But for brand new syntax, your brain has nothing to picture yet. So it stalls. That’s not you being slow — that’s a mismatch between your learning style and how the topic was presented.
The actual method for you (do this from now on)
Step 1: Copy-paste it. Make it run. See it work on screen.
Don’t try to understand yet. Just get the toggle button flipping dark/light on your phone.
Step 2: Break ONE thing at a time.
Delete notifyListeners() → run app → tap button → nothing happens. Now you FEEL what it does.
Put it back → works again.
Change context.read to context.watch in the onPressed → run app → see the red error. Now you know why read/watch matters — because you broke it and saw the crash, not because someone explained it.
Step 3: Only after it’s broken and fixed once, ask “why did that happen.”
Now the explanation actually sticks, because you have a real memory to attach it to.
This is called break-first learning. Reading theory first, for you, is backwards. You need eyes-on-broken-app first.
Answer to your exact question
“should I just copy paste and make it work then try to understand”
Yes. Always. For every new concept in Flutter.
Order for you, every time:
Copy-paste → run → see it work
Break it on purpose → see it fail
Fix it → now ask “why”
Write ONE line in your copy about what you just learned
*/
