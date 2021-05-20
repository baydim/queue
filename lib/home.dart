import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

// import 'package:flutter/foundation.dart' show kIsWeb;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController a = TextEditingController(text: "1");
  TextEditingController b = TextEditingController();

  Widget tombol({IconData icon, Color color, Function function}) {
    return InkWell(
      onTap: function,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        padding: EdgeInsets.all(6),
        child: Icon(
          icon,
          color: color,
          size: 28,
        ),
      ),
    );
  }

  void kurang() {
    setState(
      () {
        if (a.text == "1") {
          print("");
        } else {
          int aa = int.tryParse(a.text);

          int bb = aa - 1;
          a.text = bb.toString();
        }
      },
    );
  }

  void tambah() {
    setState(() {
      int aa = int.tryParse(a.text);
      int bb = aa + 1;
      a.text = bb.toString();
      print(bb);
    });
  }

  FlutterTts speak = FlutterTts();

  @override
  initState() {
    super.initState();
    initTts();
  }

  initTts() {
    speak.setStartHandler(() {
      setState(() {
        print("Playing");
      });
    });

    speak.setCompletionHandler(() {
      setState(() {
        print("Complete");
      });
    });

    speak.setCancelHandler(() {
      setState(() {
        print("Cancel");
      });
    });

    speak.setPauseHandler(() {
      setState(() {
        print("Paused");
      });
    });

    speak.setContinueHandler(() {
      setState(() {
        print("Continued");
      });
    });

    speak.setErrorHandler((msg) {
      setState(() {
        print("error: $msg");
      });
    });
  }

  Future bicara({String nomer}) async {
    await speak.setVolume(100);
    await speak.setSpeechRate(0.7);
    await speak.setPitch(1);

    await speak.speak("Antrian nomor $nomer");
  }

  Future bicarab({String nama}) async {
    await speak.setVolume(100);
    await speak.setSpeechRate(0.7);
    await speak.setPitch(1);

    await speak.speak(nama + "Mohon kedepan");
  }

  int hl = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.black,
        body: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          hl = 0;
                        });
                      },
                      child: Text(
                        "Nomer",
                        style: TextStyle(
                          decoration: hl == 0
                              ? TextDecoration.underline
                              : TextDecoration.none,
                          fontSize: hl == 0 ? 24 : 18,
                          color: hl == 0 ? Colors.white : Colors.white30,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          hl = 1;
                        });
                      },
                      child: Text(
                        "Nama",
                        style: TextStyle(
                          decoration: hl == 1
                              ? TextDecoration.underline
                              : TextDecoration.none,
                          fontSize: hl == 1 ? 24 : 18,
                          color: hl == 1 ? Colors.white : Colors.white30,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              hl == 0
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        tombol(
                          function: kurang,
                          icon: Icons.remove_rounded,
                          color: Colors.black,
                        ),
                        /////
                        Container(
                          width: Get.width / 3,
                          child: TextField(
                            onChanged: (value) {
                              setState(() {});
                            },
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            textAlignVertical: TextAlignVertical.center,
                            controller: a,
                            style: TextStyle(
                              fontSize: 28,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        /////
                        tombol(
                          function: tambah,
                          icon: Icons.add_rounded,
                          color: Colors.black,
                        ),
                      ],
                    )
                  : Container(
                      margin: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {});
                        },
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Nama penunggu"),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.text,
                        textAlignVertical: TextAlignVertical.center,
                        controller: b,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
              SizedBox(
                height: 60,
              ),
            ],
          ),
        ),
        bottomNavigationBar: InkWell(
          onTap: () {
            if (hl == 0) {
              bicara(nomer: a.text);
            }
            if (hl == 1) {
              b.text.length == 0
                  ? Get.rawSnackbar(message: "Nama harus diisi")
                  : bicarab(nama: b.text);
            }
          },
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            margin: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.volume_up_rounded,
                ),
                Text(
                  "Panggil",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
