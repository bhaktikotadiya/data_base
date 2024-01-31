import 'package:data_base/offline_contact_list/view_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main()
{
      runApp(MaterialApp(
        debugShowCheckedModeBanner: false,home: adding(),
      ));
}
class adding extends StatefulWidget {
  // const adding({super.key});
  static Database? database;
  Map ?l;
  adding([this.l]);

  @override
  State<adding> createState() => _addingState();
}

class _addingState extends State<adding> {

      TextEditingController t1 = TextEditingController();
      TextEditingController t2 = TextEditingController();
      TextEditingController t3 = TextEditingController();
      // Database? database;

      Widget txt_fun(String str,TextEditingController t) {
            return TextField(
              controller: t,
              decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: str,
              ),
            );
      }

      @override
      void initState() {
        // TODO: implement initState
        super.initState();
        get();
        if(widget.l != null)
          {
            t1.text = widget.l!['name'];
            t2.text = widget.l!['contact'];
            t3.text = widget.l!['city'];
            setState(() { });
          }
      }

  get()
  async {

    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');

    // open the database
    adding.database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE contact_book1 (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, contact TEXT, city TEXT)');
        });
    // setState(() { });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
        Scaffold(
              appBar: AppBar(
                    backgroundColor: Colors.red.shade300,
                    title: (widget.l != null)?Text("UPDATE CONTACT LIST",style: TextStyle(fontSize: 25,color: Colors.lightGreen.shade500)):
                           Text("CONTACT LIST",style: TextStyle(fontSize: 25,color: Colors.lightGreen.shade500)),
                    centerTitle: true,
              ),
              body: Column(children: [
                    txt_fun("Enter Name",t1),
                    txt_fun("Enter Contact",t2),
                    txt_fun("Enter City",t3),
                    SizedBox(height: 50,),
                    ElevatedButton(onPressed: () {
                      String name,contact,city;
                       name = t1.text;
                       contact = t2.text;
                       city = t3.text;

                        if(widget.l != null)
                        {
                          String qry = "UPDATE contact_book1 set name='$name',contact='$contact',city='$city' where id=${widget.l!['id']}";
                          adding.database!.rawUpdate(qry);
                        }
                        else
                        {
                          String qry = "insert into contact_book1 values(null, '$name', '$contact', '$city')";
                          adding.database!.rawInsert(qry);
                        }

                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return view_data();
                      },));

                      print("name:$name");
                      print("contact:$contact");
                      print("city:$city");
                    }, child: Text("ADD CONTACT")),
                    ElevatedButton(onPressed: () {
                      // t1.text = "";
                      // t2.text = "";
                      // t3.text = "";
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return view_data();
                      },));
                    }, child: Text("VIEW CONTACT"))
              ]),
        ),
    );
  }
}
