import 'package:data_base/offline_contact_list/add_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main()
{
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,home: view_data(),
    ));
}
class view_data extends StatefulWidget {
  const view_data({super.key});

  @override
  State<view_data> createState() => _view_dataState();
}

class _view_dataState extends State<view_data> {

  List<Map> l = [];

  get_data()
  async {
      String qry = "select * from contact_book1";
      l = await adding.database!.rawQuery(qry);
      print(l);
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green.shade300,
            title: Text("VIEW CONTACT",style: TextStyle(fontSize: 25,color: Colors.pink.shade300)),
            centerTitle: true,
          ),
          body: FutureBuilder(future: get_data(), builder: (context, snapshot) {

              if(snapshot.connectionState == ConnectionState.done)
              {
                  return ListView.builder(
                      itemCount: l.length,
                      itemBuilder: (context, index) {
                          return ListTile(
                            title: Text("${l[index]['name']}"),
                            subtitle: Text("${l[index]['contact']}"),
                            trailing: Wrap(children: [
                              IconButton(onPressed: (){
                                String qry = "delete from contact_book1 where id=${l[index]['id']}";
                                adding.database!.rawDelete(qry);
                                setState(() { });
                              }, icon: Icon(Icons.delete)),
                              IconButton(onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return adding(l[index]);
                                },));
                                setState(() { });
                              }, icon: Icon(Icons.edit))
                            ]),
                          );
                      },
                  );
              }
              else
              {
                return CircularProgressIndicator();
              }
          },),
        )
    );
  }
}
