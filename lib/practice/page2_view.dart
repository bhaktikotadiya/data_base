import 'package:data_base/practice/page1_add.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main()
{
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,home: view_page(),
    ));
}
class view_page extends StatefulWidget {
  const view_page({super.key});

  @override
  State<view_page> createState() => _view_pageState();
}

class _view_pageState extends State<view_page> {

  List<Map> l = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get1();
  }

  get1()
  {
    String qry = "select * from student";
    add_data.database!.rawQuery(qry).then((value) {
      l=value;
      setState(() { });
    });

    // String qry = "select * from student";      //future builder and not use setstate and list_view.builder show in future builder
    // l=await add_data.database!.rawQuery(qry);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("view"),
        ),
        body: ListView.builder(
          itemCount: l.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text("${l[index]['name']}"),
              subtitle: Text("${l[index]['contact']}"),
              trailing: Wrap(children: [
                IconButton(onPressed: (){
                  String qry = "delete from student where id=${l[index]['id']}";
                  add_data.database!.rawDelete(qry);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                    return view_page();
                  },));
                  setState(() { });
                }, icon: Icon(Icons.delete)),
                IconButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return add_data(l[index]);
                  },));
                }, icon: Icon(Icons.edit))
              ]),
            );
          },
        ),
      ),
    );
  }
}
