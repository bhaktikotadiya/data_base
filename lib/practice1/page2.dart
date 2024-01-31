import 'dart:io';

import 'package:data_base/practice1/page1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: view(),
  ));
}

class view extends StatefulWidget {
  const view({super.key});

  @override
  State<view> createState() => _viewState();
}

class _viewState extends State<view> {
  List<Map> l = [];
  List name = [];
  List t_name = [];
  bool s=false;

  get_data() async {
    String qry = "select * from user";
    l = await first_enter.database!.rawQuery(qry);
    print(l);

      for(int i=0;i<l.length;i++)
      {
        name.add(l[i]['name']);
      }
      t_name=name;

    setState(() { });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_data();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: (s)?TextField(
              autofocus: true,
              cursorColor: Colors.black,
              onChanged: (value) {
                name=t_name.where((element) => element.toString().startsWith(value)).toList();
                setState(() { });
              },
            ):Text("SECOND PAGE",
                style: TextStyle(
                    color: Colors.black45, fontSize: 30, letterSpacing: 3)),
            centerTitle: true,
            flexibleSpace: Container(
              // decoration: BoxDecoration(
              //   // color: Colors.transparent,
              //     image: DecorationImage(
              //         image: AssetImage("images/background1.jpg"), fit: BoxFit.cover)),
            ),
          actions: [
            IconButton(onPressed: (){
              s=!s;
              setState(() { });
            }, icon: (s)?Icon(Icons.search_off):Icon(Icons.search)),
          ],
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //       image: AssetImage("images/background1.jpg"), fit: BoxFit.fill),
          // ),
          child: ListView.builder(
            itemCount: name.length,
            itemBuilder: (context, index) {
              int originalindex = t_name.indexOf(name[index]);
              // FileImage f=FileImage(File(l[index]['image']));
              return ListTile(
                leading: CircleAvatar(backgroundImage: FileImage(File(l[originalindex]['image']))),
                trailing: Wrap(children: [
                  IconButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return first_enter(l[index]);
                    },));
                    setState(() { });
                  }, icon: Icon(Icons.edit)),
                  IconButton(onPressed: () {
                    String sql="delete from user where id=${l[originalindex]['id']}";
                    first_enter.database!.rawDelete(sql);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                      return view();
                    },));

                  }, icon: Icon(Icons.delete))
                ],),

                title: Text("${l[originalindex]['name']}"),
                subtitle: Text("${l[originalindex]['contact']}"),
              );
            },
          ),
        ));
  }
}