import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isScanCompleted = false;
  String? code;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(

          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          backgroundColor: Colors.amber,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Center(
            child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: ClipPath(
                      clipper: CustomShape(),
                      // this is my own class which extendsCustomClipper
                      child: Container(
                          height: 150,
                          color: Colors.amber),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.amber,),

                        height: 50,
                        width: 200,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(style: TextStyle(
                              fontStyle: FontStyle.italic, fontSize: 30.1),
                              "Question 1"
                          ),
                        )
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Container(
                    height: 100,
                    width: 300,
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(
                                  width: 4.0,
                                  color: Colors.amber,
                                  style: BorderStyle.solid
                              )

                          ),

                          enabledBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(
                                  width: 4.0,
                                  color: Colors.amber,
                                  style: BorderStyle.solid
                              )

                          ),

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),)),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height :100,
                    width : 100,
                    child: MobileScanner(
                        allowDuplicates: true,
                        onDetect: (barcode, args) {
                          if (!isScanCompleted) {
                            code = barcode.rawValue ?? '---';
                            isScanCompleted = true;
                            showDialog(context: context, builder: (BuildContext context1) {
                              return Scaffold(
                                body: Center(
                                  child:Column(
                                    children: [
                                      Text(
                                        "$code",
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 16,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width-100,
                                        height: 48,
                                        child: ElevatedButton(onPressed: (){},
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blue,
                                          ),
                                          child:  Text(
                                            "Copy",
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 16,
                                              letterSpacing: 1,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                          }
                        }
                    ),
                  )
                ]
            )
        )
    );
  }
}
class CustomShape extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    double height = size.height;
    double width = size.width;
    var path = Path();
    path.lineTo(0, height - 150);
    path.quadraticBezierTo(width / 2, height, width, height);
    path.lineTo(width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

