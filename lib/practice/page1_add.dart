import 'package:data_base/practice/page2_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main()
{
    runApp(MaterialApp(
      home: add_data(),debugShowCheckedModeBanner: false,
    ));
}
class add_data extends StatefulWidget {
  // const add_data({super.key});
  static Database? database;

  Map? l;
  add_data([this.l]);

  @override
  State<add_data> createState() => _add_dataState();
}

class _add_dataState extends State<add_data> {

  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
      if(widget.l!=null)
      {
          t1.text=widget.l!['name'];
          t2.text=widget.l!['contact'];
          setState(() { });
      }
  }

  get()
  async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demox.db');

// open the database
    add_data.database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE student (id INTEGER PRIMARY KEY, name TEXT, contact TEXT)');
        });

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Column(children: [
          TextField(
            controller: t1,
          ),
          TextField(
            controller: t2,
          ),
          ElevatedButton(onPressed: () {
            String name,contact;
            name = t1.text;
            contact = t2.text;

              if(widget.l!=null)
              {
                String qry = "UPDATE student set name='$name',contact='$contact' where id=${widget.l!['id']}";
                add_data.database!.rawUpdate(qry);
              }
              else
              {
                String qry = "insert into student values(null, '$name', '$contact')";
                add_data.database!.rawInsert(qry);
              }

            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return view_page();
            },));

          }, child: Text("ADD DATA")),
          ElevatedButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return view_page();
            },));
          }, child: Text("VIEW"))
        ]),
      ),
    );
  }
}
