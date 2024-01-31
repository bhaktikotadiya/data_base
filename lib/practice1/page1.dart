import 'dart:io';

import 'package:data_base/practice1/page2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/radio/gf_radio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(MaterialApp(
    home: first_enter(),
  ));
}

class first_enter extends StatefulWidget {
  Map? l;

  first_enter([this.l]);

  static Database? database;

  @override
  State<first_enter> createState() => _first_enterState();
}

class _first_enterState extends State<first_enter> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  TextEditingController t3 = TextEditingController();
  TextEditingController t4 = TextEditingController();
  bool pass = true;
  String gender = "";
  String new_image = "";
  String city = "surat";
  final ImagePicker picker = ImagePicker();
  XFile? image;
  bool t = false;

  bool er_name=false;
  bool er_contact=false;
  bool er_email=false;
  bool er_password=false;

  get() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'pic11.db');

// Delete the database
//     await deleteDatabase(path);

// open the database
    first_enter.database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE user (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, contact TEXT, email TEXT,password TEXT,gender TEXT,city TEXT,image TEXT)');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
    if (widget.l != null)
    {
      t1.text=widget.l!['name'];
      t2.text=widget.l!['contact'];
      t3.text=widget.l!['email'];
      t4.text=widget.l!['password'];
      gender=widget.l!['gender'];
      city=widget.l!['city'];
      new_image=widget.l!['image'];
      setState(() { });
    }
  }

  OutlineInputBorder myinputborder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(color: Colors.blue.shade200, width: 3));
  }

  OutlineInputBorder myfocusborder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(color: Colors.blueAccent.shade100, width: 3));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: Text("FIRST PAGE",
              style: TextStyle(
                  color: Colors.black45, fontSize: 30, letterSpacing: 5)),
          centerTitle: true,
          flexibleSpace: Container(
            color: Colors.teal.shade900,
            // decoration: BoxDecoration(
            //   // color: Colors.transparent,
            //     image: DecorationImage(
            //         image: AssetImage("images/background1.jpg"), fit: BoxFit.cover)
            // ),
          )),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.teal.shade300,
        // decoration: BoxDecoration(
        //     image: DecorationImage(
        //         image: AssetImage("images/background1.jpg"), fit: BoxFit.fill)),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          margin: EdgeInsets.all(40),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black45,
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: Offset(0, 2))
            ],
            // image: DecorationImage(
            //     image: AssetImage("images/background1.jpg"), fit: BoxFit.fill)
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(""),
                TextField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.account_circle),
                      // hintText: "Enter Name",
                      labelText: "Enter Name",
                      labelStyle: TextStyle(color: Colors.black45),
                      border: myinputborder(),
                      enabledBorder: myinputborder(),
                      focusedBorder: myfocusborder()),
                  controller: t1,
                ),
                Text(""),
                TextField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.call),
                      labelText: "Enter Contact",
                      labelStyle: TextStyle(color: Colors.black45),
                      border: myinputborder(),
                      enabledBorder: myinputborder(),
                      focusedBorder: myfocusborder()),
                  controller: t2,
                ),
                Text(""),
                TextField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.mail),
                      labelText: "Enter gmail",
                      labelStyle: TextStyle(color: Colors.black45),
                      border: myinputborder(),
                      enabledBorder: myinputborder(),
                      focusedBorder: myfocusborder()),
                  controller: t3,
                ),
                Text(""),
                TextField(
                  obscureText: pass,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      labelText: "Enter password",
                      suffix: IconButton(
                        onPressed: () {
                          if (pass) {
                            pass = false;
                          } else {
                            pass = true;
                          }
                          setState(() {});
                        },
                        icon: Icon(pass == true
                            ? Icons.remove_red_eye
                            : Icons.password),
                      ),
                      labelStyle: TextStyle(color: Colors.black45),
                      border: myinputborder(),
                      enabledBorder: myinputborder(),
                      focusedBorder: myfocusborder()),
                  controller: t4,
                ),
                Text(""),
                Text(""),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "GENDER:",
                      style: TextStyle(fontSize: 15),
                    ),
                    Text("MALE"),
                    GFRadio(
                      activeBgColor: Colors.black45,
                      // activeBorderColor: Colors.white,
                      radioColor: Colors.red,
                      inactiveBgColor: Colors.white10,
                      // inactiveBorderColor: Colors.transparent,
                      autofocus: false,

                      // type: Icon(Icons.account_circle),
                      inactiveIcon: Icon(Icons.male),

                      value: "male",
                      groupValue: gender,
                      onChanged: (value) {
                        gender = value!;
                        setState(() {});
                      },
                    ),
                    Text("FEMALE"),
                    GFRadio(
                      activeBgColor: Colors.black45,
                      inactiveIcon: Icon(Icons.female),
                      inactiveBgColor: Colors.white10,
                      radioColor: Colors.red,
                      value: "female",
                      groupValue: gender,
                      onChanged: (value) {
                        gender = value!;
                        setState(() {});
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "CITY:",
                      style: TextStyle(fontSize: 15),
                    ),
                    DropdownButton(
                      dropdownColor: Colors.black,
                      style: TextStyle(color: Colors.white),
                      value: city,
                      items: [
                        DropdownMenuItem(child: Text("surat",),value: "surat",),
                        DropdownMenuItem(child: Text("rajkot"),value: "rajkot",),
                        DropdownMenuItem(child: Text("junagadh"),value: "junagadh",),
                        DropdownMenuItem(child: Text("vadodara"),value: "vadodara",),
                        DropdownMenuItem(child: Text("bharuch"),value: "bharuch",),
                        DropdownMenuItem(child: Text("Amadavad"),value: "Amadavad",),
                        DropdownMenuItem(child: Text("bhavanagar"),value: "bhavanagar",),
                      ],
                      onChanged: (value)
                      {
                        city = value!;
                        setState(() { });
                      },),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      // color: Colors.yellow,
                      child: (t)?Image.file(fit: BoxFit.fill,File(image!.path)):(new_image!=null)?Image.file(File(new_image!)):null,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                actions: [
                                  Row(children: [
                                    Text("Choose any one"),
                                  ],),
                                  Row(
                                    children: [
                                      TextButton(
                                          onPressed: () async {
                                            image = await picker.pickImage(
                                                source: ImageSource.camera);
                                            t = true;
                                            Navigator.pop(context);
                                            setState(() {});
                                          },
                                          child: Text("camera")),
                                      TextButton(
                                          onPressed: () async {
                                            image = await picker.pickImage(
                                                source: ImageSource.gallery);
                                            t = true;
                                            Navigator.pop(context);
                                            setState(() {});
                                          },
                                          child: Text("gallery")),
                                    ],
                                  )
                                ],
                              );
                            },
                          );
                        },
                        child: Text("choose")),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                        onPressed: () {
                          String name = t1.text;
                          String contact = t2.text;
                          String email = t3.text;
                          String password = t4.text;

                          //contact validation
                          String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                          RegExp regExp = new RegExp(patttern);

                          //email validation
                          String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                          RegExp regExp1 = new RegExp(p);

                            if(name=="")
                            {
                              er_name=true;
                            }
                            if(contact=="" || !regExp.hasMatch(contact))
                            {
                              er_contact=true;
                            }
                            else
                            {
                              er_contact=false;
                            }
                            if(email.trim()=="" || !regExp1.hasMatch(email.trim()))
                            {
                              er_email=true;
                            }
                            else
                            {
                              er_email=false;
                            }
                            if(password=="")
                            {
                              er_password=true;
                            }

                            if(!er_name && !er_contact && !er_email && !er_password)
                            {
                                if(widget.l!=null)
                                {
                                  String qry = "update user set name='$name',contact='$contact',email='$email',password='$password',gender='$gender',city='$city',image='${image!.path}' where id=${widget.l!['id']}";
                                  first_enter.database!.rawUpdate(qry);
                                  print("update qry=${qry}");
                                  setState(() { });
                                }
                                else
                                {
                                  String sql = "insert into user values(NULL,'$name','$contact','$email','$password','$gender','$city','${image!.path}')";
                                  first_enter.database!.rawInsert(sql).then((value) {
                                    print(value);
                                    print(sql);
                                  });
                                }
                                setState(() { });
                            }
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return view();
                            },
                          ));

                          setState(() { });
                        },
                        child: Text("ADD")),
                    TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return view();
                            },
                          ));
                          setState(() { });
                        },
                        child: Text("VIEW")),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
