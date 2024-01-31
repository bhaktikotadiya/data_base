import 'dart:io';

import 'package:data_base/hive_data_store/data_store2.dart';
import 'package:data_base/hive_data_store/data_store3.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main()
async {

    WidgetsFlutterBinding.ensureInitialized();
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentsDir.path);
    Hive.registerAdapter(adapterAdapter());
    var box = await Hive.openBox('cdmi');

    runApp(MaterialApp(
       debugShowCheckedModeBanner: false,home: first(),
    ));
}
class first extends StatefulWidget {
  adapter ?a;
  first([this.a]);

  // const first({super.key});


  @override
  State<first> createState() => _firstState();
}

class _firstState extends State<first> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.a != null)
      {
          t1.text = widget.a!.name;
          t2.text = widget.a!.contact;
      }
  }

  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();

  Box box = Hive.box('cdmi');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DATA STORE"),
      ),
      body: Column(children: [
        TextField(
          controller: t1,
        ),
        TextField(
          controller: t2,
        ),
        SizedBox(height: 30,),
        Center(child: ElevatedButton(
            onPressed: () {
                String name = t1.text;
                String contact = t2.text;

                if(widget.a!=null)
                {
                    widget.a!.name = name;
                    widget.a!.contact = contact;
                    widget.a!.save();
                }
                else
                {
                    adapter d = adapter(name, contact);
                    box.add(d);
                    print(d);
                }
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return second();
                },));

                setState(() { });
            },
            child: Text("ADD")
        ),),
        SizedBox(height: 30,),
        Center(child: ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return second();
              },));
            },
            child: Text("VIEW")
        ),),
      ]),
    );
  }
}
