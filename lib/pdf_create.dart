import 'dart:io';
import 'dart:math';

import 'package:external_path/external_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

void main()
{
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,home: pdf_make(),
  ));
}
class pdf_make extends StatefulWidget {
  const pdf_make({super.key});

  @override
  State<pdf_make> createState() => _pdf_makeState();
}

class _pdf_makeState extends State<pdf_make> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }

  get()
  async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      // We haven't asked for permission yet or the permission has been denied before, but not permanently.
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
        Permission.storage,
      ].request();
      print(statuses[Permission.location]);

    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("PDF CREATE"),
            centerTitle: true,
            backgroundColor: Colors.teal,
          ),
          body: Center(
            child: ElevatedButton(onPressed: () async {

              // Create a new PDF document.
              final PdfDocument document = PdfDocument();
              // Add a new page to the document.
              final PdfPage page = document.pages.add();
              //create first page
              //Draw text in the PDF page.
              page.graphics.drawString('Hello World!', PdfStandardFont(PdfFontFamily.helvetica, 25),
                  brush: PdfSolidBrush(PdfColor(0, 0, 0)),
                  bounds: const Rect.fromLTWH(0, 0, 150, 20)
                  // bounds: Rectangle(0, 0, 150, 120),
              );

              var path = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS)+"/pdf_file";
              print(path);

              Directory dir=Directory(path);
              if(! await dir.exists())
              {
                dir.create();
              }

              File f = File("${dir.path}/mypdg${Random().nextInt(100)}.pdf");
              f.writeAsBytes(await document.save());
              OpenFile.open(f.path);
              document.dispose();

              setState(() { });

              //search in google:syncfusion_flutter_pdf: package pubget

            }, child: Text("PDF CREATE")),
          ),
        )
    );
  }
}



