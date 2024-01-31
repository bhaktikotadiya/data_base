import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main()
async {

      WidgetsFlutterBinding.ensureInitialized();
      final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
      Hive.init(appDocumentsDir.path);
      var box = await Hive.openBox('testBox');

      runApp(MaterialApp(
        debugShowCheckedModeBanner: false,home: one(),
      ));
}
class one extends StatefulWidget {
  const one({super.key});

  @override
  State<one> createState() => _oneState();
}

class _oneState extends State<one> {
  int a=0;
  Box box = Hive.box('testBox');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    a = box.get('testBox') ?? 0;
    setState(() { });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HIVE DATABASE"),
      ),
      body: Column(children: [
        Center(child: Text("A : ${a}",style: TextStyle(fontSize: 35)),),
        Center(child: ElevatedButton(
            onPressed: () {
              a++;
              box.put('testBox', a);
              setState(() { });
            },
            child: Text("ADD VALUE")
        ),)
      ]),
    );
  }
}
