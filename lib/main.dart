import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pure_match_coding_assessment/Admin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF171717)),
      home: const MyHomePage(title: 'Add an Admin'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // text editing controller to edit the text in the text field
  TextEditingController controller = TextEditingController();

  // dummy data to test out the search bar that initializes 4 instances of the Admin object from Admin.dart
  List<Admin> adminList = [
    Admin("Joanne Johnson", "03/21/2019", true,
        const AssetImage('lib/assets/joanne.jpg')),
    Admin("Joe Schwartz", "10/26/2021", true,
        const AssetImage('lib/assets/joe.jpg')),
    Admin("John Walter", "04/09/2019", false,
        const AssetImage('lib/assets/john.jpg')),
    Admin("Jenny White", "06/08/2019", true,
        const AssetImage('lib/assets/jenny.jpg')),
  ];

  List<Admin> displayList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55.0),
        child: AppBar(
          // app bar that holds logo and back arrow (latter not functional but would be if actually needed)
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(widget.title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontFamily: 'Avenir', fontSize: 28)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            color: Colors.white,
            iconSize: 30,
            onPressed: () {
              // would lead back to Manage Admins Screen, but for purposes of demo, does nothing
            },
          ),
          actions: const [
            Padding(
                padding: EdgeInsets.all(10),
                child: Icon(Icons.handshake_outlined,
                    color: Colors.white, size: 30)),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Row(
              children: [
                Expanded(
                  child: CupertinoSearchTextField(
                    style: (const TextStyle(color: Colors.white)),
                    // sets controller to the text editing controller we had initialized earlier
                    controller: controller,
                    // when user types, the text displayed in the text input is now changed
                    onChanged: (value) {
                      setState(() {
                        // here we will update the display based on what the user is typing into the text field
                        displayList = adminList
                            .where((element) => element.name.contains(value))
                            .toList();
                      });
                    },
                    onSubmitted: (value) {},
                    // enables autocorrection to true to help find admins easier
                    // autocorrect: true,
                  ),
                ),
                TextButton(
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                        fontFamily: 'Avenir',
                        fontSize: 20,
                        color: Colors.blue.shade700),
                  ),
                  onPressed: () {
                    // clears the search bar and cancel the search operation
                    controller.clear();
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: controller.text.isNotEmpty
                  ? displayList.length
                  : adminList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(15, 5, 10, 10),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 3,
                                color: adminList.elementAt(index).getStatus()
                                    ? const Color(0xFF00BA84)
                                    : const Color(0xFFFF004A)),
                            borderRadius: BorderRadius.circular(100)),
                        child: ClipOval(
                          child: SizedBox.fromSize(
                            size: const Size.fromRadius(30),
                            child: Image(
                              image: controller.text.isNotEmpty
                                  ? displayList.elementAt(index).getPhoto()
                                  : adminList.elementAt(index).getPhoto(),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
                              child: Text(
                                controller.text.isNotEmpty
                                    ? displayList.elementAt(index).getName()
                                    : adminList.elementAt(index).getName(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 5, 0, 0),
                              child: Text(
                                controller.text.isNotEmpty
                                    ? "Member Since ${displayList.elementAt(index).getDate()}"
                                    : "Member Since ${adminList.elementAt(index).getDate()}",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            )
                          ]),
                      Container(
                        padding: const EdgeInsets.fromLTRB(70, 0, 0, 0),
                        child: IconButton(
                          icon: const Icon(
                            Icons.more_horiz,
                            color: Colors.white,
                            size: 40,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
