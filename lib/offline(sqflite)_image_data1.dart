import 'dart:io';

import 'package:data_base/offline(sqflitte)_image_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main()
{
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,home: img_view(),
  ));
}
class img_view extends StatefulWidget {
  const img_view({super.key});

  @override
  State<img_view> createState() => _img_viewState();
}

class _img_viewState extends State<img_view> {

  List<Map> l = [];
  List name=[];
  List t_name=[];
  bool s=false;

  get_data()
 {
    String qry = "select * from image_pic";
    // l = await device_img.database!.rawQuery(qry);
    device_img.database!.rawQuery(qry).then((value) {
      l=value;
      for(int i=0;i<l.length;i++)
      {
        name.add(l[i]['name']);
      }
      t_name=name;
      print("t_name=$t_name");
      print(l);
      setState(() { });
    });
    // setState(() { });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_data();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green.shade300,
            title: (s)?TextField(
              onChanged: (value) {
                name=t_name.where((element) => element.toString().startsWith(value)).toList();
                print("name length=${name}");
                setState(() { });
              },
              autofocus: true,
              cursorColor: Colors.black,
            ):Text("VIEW DETAILS",style: TextStyle(fontSize: 25,color: Colors.pink.shade300)),
            centerTitle: true,
            actions: [
              IconButton(onPressed: () {
                s=!s;
                setState(() { });
              }, icon: (s)?Icon(Icons.search_off):Icon(Icons.search))
            ],
          ),

          body: ListView.builder(
            itemCount: name.length,
            itemBuilder: (context, index) {

              int originalindex=t_name.indexOf(name[index]);
              // int originalindex=name.indexOf(name[index]);
              print("original=${originalindex}");
              print("t_name2=${t_name[index]}");
              print("name2=${name[index]}");
              String img_path ="${device_img.dir!.path}/${l[index]['img']}";
              File f=File(img_path);

              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: FileImage(f),
                  ),
                  // leading: Container(
                  //   height: 100,width: 50,
                  //   // color: Colors.grey,
                  //   decoration: BoxDecoration(
                  //     image: DecorationImage(fit: BoxFit.fill,image: FileImage(f),)
                  //   ),
                  //   // child: FileImage(f),
                  // ),
                  title: Text("${l[originalindex]['name']}"),
                  subtitle: Text("${l[originalindex]['contact']}"),
                  trailing: Wrap(children: [
                    IconButton(onPressed: (){
                      String qry = "delete from image_pic where id='${l[originalindex]['id']}'";
                      device_img.database!.rawDelete(qry);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                        return img_view();
                      },));
                      setState(() { });
                    }, icon: Icon(Icons.delete)),
                    IconButton(onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                        return device_img(l[originalindex]);
                      },));
                      setState(() { });
                    }, icon: Icon(Icons.edit))
                  ]),
                ),
              );
            },
          ),
      )
    );
  }
}
