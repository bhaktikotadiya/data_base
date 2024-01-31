import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'data_store1.dart';
import 'data_store2.dart';

void main()
{
      runApp(MaterialApp(
        debugShowCheckedModeBanner: false,home: second(),
      ));
}
class second extends StatefulWidget {
  const second({super.key});

  @override
  State<second> createState() => _secondState();
}

class _secondState extends State<second> {

  Box box = Hive.box('cdmi');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
          itemCount: box.length,
          itemBuilder: (context, index) {
            adapter a = box.getAt(index);
            print(a);
            return Card(
              child: ListTile(
                title: Text("${a.name}"),
                subtitle: Text("${a.contact}"),
                trailing: Wrap(children: [
                  IconButton(onPressed: () {
                    box.deleteAt(index);
                    setState(() { });
                  }, icon: Icon(Icons.delete)),
                  IconButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return first(a);
                    },));
                    setState(() { });
                  }, icon: Icon(Icons.edit))
                ]),
              ),
            );
        },),
      ),
    );
  }
}
