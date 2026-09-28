import 'package:flutter/material.dart';
import 'package:moneyflow/pages/local_storage.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? username;
  

  void user() {
    final name = LocalStorage.prefs.getString('userName');

    setState(() {
      username = name ?? 'user';
    });
  }

  @override
  void initState() {
    super.initState();
    user();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Theme.of(context).colorScheme.secondary,
        title: ListTile(
          title: Text(
            "Good Morning, ${username ?? '...'}",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
          // subtitle: Text("day with date"),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: IconButton(
              icon: Icon(Icons.notifications, color: Colors.white),
              onPressed: () {
                // Handle notification press
              },
            ),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green.shade400, Colors.green.shade200],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                // color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Balance",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.refresh_rounded, color: Colors.white),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Text(
                    " - -",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(15),

                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          Text(
                            "Income",
                            style: TextStyle(fontSize: 17, fontWeight: .bold),
                          ),
                          Text("\$ - -"),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          Text(
                            "Expense",
                            style: TextStyle(fontSize: 17, fontWeight: .bold),
                          ),
                          Text("\$ - -"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            Center(
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    Colors.green.shade400,
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/addtransaction');
                },
                child: Text(
                  "Add Transaction",
                  style: TextStyle(color: Colors.white, fontWeight: .bold),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                "Recent Transaction",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 15,
                itemBuilder: (context, index) {
                  return ListTile(title: Text("data"));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
