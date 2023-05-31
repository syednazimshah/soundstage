import 'package:go_router/go_router.dart';
import 'package:soundstageweb/Bottombar/bottombar.dart';
import 'package:soundstageweb/Misc/Alertbox.dart';
import 'package:soundstageweb/Topbar/topbar.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:soundstageweb/Login/AuthManager.dart';

class SynthesisPage extends StatefulWidget {
  const SynthesisPage({Key? key}) : super(key: key);

  @override
  _SynthesisPageState createState() => _SynthesisPageState();
}

class _SynthesisPageState extends State<SynthesisPage> {
  bool switchstate = true;
  bool speechmode = true;
  bool rhythmicmode = true;
  var age = "Select Value";
  var sex = "Select Value";
  var emotion = "Select Value";
  var currentlyplaying = "";
  var currentplayingtext = "";
  TextEditingController inputtext = TextEditingController();
  String UserId = UserID;
  var docs;
  String folder_name = UserID;

  bool isplaying=false;
  final FirebaseStorage storage = FirebaseStorage.instance;

  final AssetsAudioPlayer player = AssetsAudioPlayer();

  Future<String> getDownloadURL(String fileName) async {
    final Reference ref =
        storage.ref().child(UserId + "/" + folder_name + "/" + fileName);
    final String downloadURL = await ref.getDownloadURL();
    return downloadURL;
  }

  playaudio(String link) {
    player.open(Audio.network(link), showNotification: false);
  }

  void playorpause() {

    player.playOrPause();
  }

  // void addDocument(String text) async {
  //   // Get a reference to the Firestore instance
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //
  //   // Get a reference to the collection
  //   CollectionReference collectionRef = firestore.collection('requests');
  //
  //   // Define the data for the new document
  //   Map<String, dynamic> data = {
  //     'text': text,
  //   };
  //
  //   // Add the document to the collection
  //   DocumentReference docRef = await collectionRef.add(data);
  // }

  Future<String> sendRequest(String user, String text) async {
    final url = Uri.parse(
        'https://us-central1-soundstagefyp.cloudfunctions.net/getData');

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final body = {'user': user, 'text': text};

    final encodedBody = json.encode(body);

    final response = await http.post(url, headers: headers, body: encodedBody);

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      print(responseBody);
      return responseBody["folder_name"];
    } else {
      print('Error: ${response.body}');
      return "error";
    }
  }



  // late CollectionReference _myCollectionRef;
  // late List _myDocuments;

  // @override
  // void initState() {
  //   super.initState();
  //   _myCollectionRef = FirebaseFirestore.instance.collection('myCollection');
  //   _myDocuments = [];
  //   _fetchData();
  // }

  // void _fetchData() async {
  //   final querySnapshot = await _myCollectionRef.get();
  //   final documents = querySnapshot.docs;
  //   final data = documents.map((doc) => doc.data()).toList();
  //   setState(() {
  //     _myDocuments = data;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        height: constraints.maxHeight,
        width: constraints.maxWidth,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/background.jpg"), fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: topbar(context, "login"),
          body: isLoggedIn?SingleChildScrollView(
            child: Container(
              // height: constraints.maxHeight,
              // width: constraints.maxWidth,
              padding: EdgeInsets.symmetric(horizontal: 100, vertical: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      CupertinoSwitch(
                        value: switchstate,
                        activeColor: Colors.grey,
                        onChanged: (value) {
                          setState(() {
                            switchstate = !switchstate;
                          });
                        },
                      ),
                      Text(
                        switchstate ? " Auto Mode" : " Manual Mode",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ToggleSwitch(
                    minWidth: 128,
                    initialLabelIndex: speechmode ? 0 : 1,
                    cornerRadius: 20.0,
                    activeFgColor: Colors.black,
                    activeBgColor: [Colors.white],
                    inactiveBgColor: Colors.grey.withOpacity(0.7),
                    inactiveFgColor: Colors.white,
                    totalSwitches: 2,
                    labels: ['Speech', 'Foley'],
                    fontSize: 16,
                    animate: true,
                    animationDuration: 150,
                    //icons: [FontAwesomeIcons.mars, FontAwesomeIcons.venus],
                    //activeBgColors: [[Colors.blue],[Colors.pink]],
                    onToggle: (index) {
                      if (index == 0) {
                        setState(() {
                          speechmode = true;
                        });
                      } else {
                        setState(() {
                          speechmode = false;
                        });
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  !switchstate
                      ? (speechmode
                          ? Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                        // width: constraints.maxWidth / 2,
                                        // height: constraints.maxHeight / 2,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          color: Colors.grey.withOpacity(0.7),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            hint: age == "Select Value"
                                                ? Text("Age",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white))
                                                : Text(age,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white)),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                            icon: Icon(
                                              Icons.keyboard_arrow_down_rounded,
                                              size: 30,
                                            ),
                                            //style: TextStyle(color: Colors.white),
                                            onChanged: (String? value) {
                                              setState(() {
                                                age = value!;
                                              });
                                            },
                                            dropdownColor: Colors.grey,
                                            items: <DropdownMenuItem<String>>[
                                              DropdownMenuItem(
                                                value: "Select Value",
                                                child: Text("Select Value"),
                                              ),
                                              DropdownMenuItem(
                                                value: "0 - 4 yrs",
                                                child: Text("0 - 4 yrs"),
                                              ),
                                              DropdownMenuItem(
                                                value: "5 - 12 yrs",
                                                child: Text("5 - 12 yrs"),
                                              ),
                                              DropdownMenuItem(
                                                value: "13 - 21 yrs",
                                                child: Text("13 - 21 yrs"),
                                              ),
                                              DropdownMenuItem(
                                                value: "22 - 48 yrs",
                                                child: Text("22 - 48 yrs"),
                                              ),
                                              DropdownMenuItem(
                                                value: "Older",
                                                child: Text("Older"),
                                              ),
                                            ],
                                          ),
                                        )),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                        // width: constraints.maxWidth / 2,
                                        // height: constraints.maxHeight / 2,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          color: Colors.grey.withOpacity(0.7),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                            hint: sex == "Select Value"
                                                ? Text("Sex",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white))
                                                : Text(sex,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white)),

                                            icon: Icon(
                                              Icons.keyboard_arrow_down_rounded,
                                              size: 30,
                                              color: Colors.white,
                                            ),
                                            //style: TextStyle(color: Colors.white),
                                            onChanged: (String? value) {
                                              setState(() {
                                                sex = value!;
                                              });
                                            },
                                            dropdownColor: Colors.grey,
                                            items: <DropdownMenuItem<String>>[
                                              DropdownMenuItem(
                                                value: "Select Value",
                                                child: Text("Select Value"),
                                              ),
                                              DropdownMenuItem(
                                                value: "Male",
                                                child: Text("Male"),
                                              ),
                                              DropdownMenuItem(
                                                value: "Female",
                                                child: Text("Female"),
                                              ),
                                            ],
                                          ),
                                        )),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                        // width: constraints.maxWidth / 2,
                                        // height: constraints.maxHeight / 2,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          color: Colors.grey.withOpacity(0.7),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                            hint: emotion == "Select Value"
                                                ? Text("Emotion",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white))
                                                : Text(emotion,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white)),

                                            icon: Icon(
                                              Icons.keyboard_arrow_down_rounded,
                                              size: 30,
                                            ),
                                            //style: TextStyle(color: Colors.white),
                                            onChanged: (String? value) {
                                              setState(() {
                                                emotion = value!;
                                              });
                                            },

                                            dropdownColor: Colors.grey,
                                            items: <DropdownMenuItem<String>>[
                                              DropdownMenuItem(
                                                value: "Select Value",
                                                child: Text("Select Value"),
                                              ),
                                              DropdownMenuItem(
                                                value: "Happiness",
                                                child: Text("Happiness"),
                                              ),
                                              DropdownMenuItem(
                                                value: "Surprise",
                                                child: Text("Surprise"),
                                              ),
                                              DropdownMenuItem(
                                                value: "Contempt",
                                                child: Text("Contempt"),
                                              ),
                                              DropdownMenuItem(
                                                value: "Sadness",
                                                child: Text("Sadness"),
                                              ),
                                              DropdownMenuItem(
                                                value: "Fear",
                                                child: Text("Fear"),
                                              ),
                                              DropdownMenuItem(
                                                value: "Disgust",
                                                child: Text("Disgust"),
                                              ),
                                              DropdownMenuItem(
                                                value: "Anger",
                                                child: Text("Anger"),
                                              ),
                                            ],
                                          ),
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                ToggleSwitch(
                                  minWidth: 128.0,
                                  initialLabelIndex: rhythmicmode ? 0 : 1,
                                  cornerRadius: 20.0,
                                  activeFgColor: Colors.black,
                                  activeBgColor: [Colors.white],
                                  inactiveBgColor: Colors.grey[700],
                                  inactiveFgColor: Colors.white,
                                  totalSwitches: 2,
                                  labels: ['Rhythmic', 'Non Rhythmic'],
                                  fontSize: 16,
                                  animate: true,
                                  animationDuration: 150,
                                  //icons: [FontAwesomeIcons.mars, FontAwesomeIcons.venus],
                                  //activeBgColors: [[Colors.blue],[Colors.pink]],
                                  onToggle: (index) {
                                    if (index == 0) {
                                      setState(() {
                                        rhythmicmode = true;
                                      });
                                    } else {
                                      setState(() {
                                        rhythmicmode = false;
                                      });
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ))
                      : SizedBox(
                          height: 0,
                          width: 0,
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: constraints.maxWidth / 2,
                        height: constraints.maxHeight / 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: Colors.grey.withOpacity(0.25),
                        ),
                        child: TextField(
                          controller: inputtext,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(25.0),
                            hintText: 'Enter your Text',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 20),
                            //prefixIcon: Icon(Icons.email),
                          ),
                        ),
                      ),
                      Container(
                          width: 650,
                          height: constraints.maxHeight / 2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color: Colors.grey.withOpacity(0.25),
                          ),
                          child:
                          folder_name == UserId || folder_name == "error"
                              ? Center(
                                  child: Text(
                                    "Please generate Audio",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              :
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          //crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            ElevatedButton(
                                              onPressed: ()async {
                                                setState(()=>isplaying=true);
                                                playorpause();
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                                                child: Icon(Icons.play_arrow_rounded)//Text('Play All',style: TextStyle(fontSize: 16),),
                                              ),
                                              style: ButtonStyle(
                                                backgroundColor:MaterialStateProperty.all<Color>(Colors.blueGrey.withOpacity(0.3)),
                                                elevation: MaterialStateProperty.all(0),
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: ()async {
                                                setState(()=>isplaying=false);
                                                player.pause();
                                              },
                                              child: Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                                                  child: Icon(Icons.pause)//Text('Play All',style: TextStyle(fontSize: 16),),
                                              ),
                                              style: ButtonStyle(
                                                backgroundColor:MaterialStateProperty.all<Color>(Colors.blueGrey.withOpacity(0.3)),
                                                elevation: MaterialStateProperty.all(0),
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: ()async {
                                                setState(()=>isplaying=true);
                                                String link = await getDownloadURL("full_audio.wav");
                                                playaudio(link);
                                              },
                                              child: Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 8),
                                                  child: Text('Play All',style: TextStyle(fontSize: 16),),
                                              ),
                                              style: ButtonStyle(
                                                backgroundColor:MaterialStateProperty.all<Color>(Colors.blueGrey.withOpacity(0.3)),
                                                elevation: MaterialStateProperty.all(0),
                                              ),
                                            ),
                                          ],
                                        ),
                                        // IconButton(
                                        //     onPressed: () async {
                                        //       setState(()=>isplaying=!isplaying);
                                        //       playorpause();
                                        //     },
                                        //     icon: Icon(
                                        //       isplaying?Icons.pause:Icons.play_arrow_rounded,
                                        //       color: Colors.white,
                                        //     )),
                                        // Text(
                                        //   currentlyplaying,
                                        //   style: TextStyle(color: Colors.white),
                                        // ),
                                        SizedBox(height: 20,),
                                        Text(
                                          currentplayingtext,
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Divider(
                                    color: Colors.white,  // Set the color of the line
                                    thickness: 1,        // Set the thickness of the line
                                    indent: 40,          // Set the left padding of the line
                                    endIndent: 40,       // Set the right padding of the line
                                  ),
                                  StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection(UserId)
                                        .doc(folder_name)
                                        .collection(folder_name)
                                        .orderBy("filename")
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot>
                                            snapshot) {
                                      if (!snapshot.hasData) {
                                        return Center(
                                            child:
                                                CircularProgressIndicator());
                                      }
                                      final documents = snapshot.data!.docs;
                                      docs=documents;
                                      return Expanded(
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          //physics: NeverScrollableScrollPhysics(),
                                          itemCount: documents.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            final data =
                                                documents[index].data()
                                                    as Map<String, dynamic>;
                                            return InkWell(
                                              //onHover: ,
                                              onTap: () async {
                                                String link =
                                                    await getDownloadURL(
                                                        data['filename']);
                                                playaudio(link);
                                              },

                                              child: ListTile(
                                                title: Text(
                                                  data['filename'],
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                subtitle: Text(
                                                  data['text'],
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                                leading: IconButton(
                                                    onPressed: () async {
                                                      if(data['filename']==currentlyplaying){
                                                        setState(()=>isplaying=!isplaying);
                                                        playorpause();
                                                      }else{
                                                        setState(() {
                                                          currentplayingtext =
                                                          data['text'];
                                                          currentlyplaying =
                                                          data['filename'];
                                                        });
                                                        String link =
                                                        await getDownloadURL(
                                                            data[
                                                            'filename']);

                                                        await playaudio(link);
                                                      }

                                                    },
                                                    icon: Icon(isplaying && data['filename']==currentlyplaying?Icons.pause:Icons.play_arrow_rounded,
                                                      color: Colors.white,
                                                    )),
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                          )),
                    ],
                  ),
                  SizedBox(height: 25.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 250,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: Colors.white,
                        ),
                        child: TextButton(
                          onPressed: () async {
                            if (inputtext.text != "") {
                              setState(() => folder_name = UserId);
                              String result = await sendRequest(
                                  UserId, inputtext.text.replaceAll('"', "'").replaceAll("\n", " ").replaceAll('“', "'"));
                              if (result != "error") {
                                setState(() => folder_name = result);
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return RoundedAlertBox(
                                        icon: Icon(
                                          Icons.error_outline_rounded,
                                          size: 100,
                                          color: Colors.red,
                                        ),
                                        message: result,
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          //context.go('/synthesis');
                                        },
                                      );
                                    });
                              }
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return RoundedAlertBox(
                                      icon: Icon(
                                        Icons.error_outline_rounded,
                                        size: 100,
                                        color: Colors.red,
                                      ),
                                      message: "The input text is empty!",
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        //context.go('/synthesis');
                                      },
                                    );
                                  });
                            }
                          },
                          child: Text(
                            'Synthesize',
                            style: TextStyle(
                              color: Colors.blue[900],
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 160,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: Colors.blueGrey.withOpacity(0.3),
                        ),
                        child: TextButton(
                          onPressed: () async {
                            context.go('/history');
                          },
                          child: Text(
                            'View History',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Container(
                  //   height: 400,
                  //   width: 400,
                  //   child: ListView.builder(
                  //
                  //     itemCount: _myDocuments.length,
                  //     itemBuilder: (BuildContext context, int index) {
                  //       final data = _myDocuments[index];
                  //       return ListTile(
                  //         title: Text(data['filename']),
                  //         subtitle: Text(data['text']),
                  //       );
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
          ):Center(child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                Text("Please Login first",style: TextStyle(fontSize: 20,color: Colors.white),),
                SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: (){
                    context.go("/login");
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Login',style: TextStyle(fontSize: 20),),
                  ),
                  style: ButtonStyle(
                    backgroundColor:MaterialStateProperty.all<Color>(Colors.blue),
                    elevation: MaterialStateProperty.all(0),
                  ),
                ),
              ]
          ),),
          bottomNavigationBar: bottombar(),
        ),
      );
    });
  }
}
