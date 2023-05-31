import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soundstageweb/Topbar/topbar.dart';
import '../Bottombar/bottombar.dart';
import 'package:soundstageweb/Login/AuthManager.dart';
import 'package:intl/intl.dart';



class HistoryPage extends StatefulWidget {


  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {


  String UserId= UserID;
  FirebaseFirestore firestore = FirebaseFirestore.instance;





  final FirebaseStorage storage = FirebaseStorage.instance;

  final AssetsAudioPlayer player = AssetsAudioPlayer();

  Future<String> getDownloadURL(String folder_name) async {
    final Reference ref =
    storage.ref().child(UserId + "/" + folder_name + "/" + "full_audio.wav");
    final String downloadURL = await ref.getDownloadURL();
    return downloadURL;
  }

  playaudio(String link) {
    player.open(Audio.network(link), showNotification: false);
  }

  void playorpause() {

    player.playOrPause();
  }





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

          bottomNavigationBar: bottombar(),

          backgroundColor: Colors.transparent,

          appBar: topbar(context, "login"),

          body: isLoggedIn?SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 250.0,vertical: 100),
              child: Center(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection(UserId).orderBy("time",descending: true).snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child:
                          CircularProgressIndicator());
                    }

                    return ListView(
                      shrinkWrap: true,
                      children: snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ListTile(
                              title: Text(DateFormat('yyyy-MM-dd HH:mm:ss').format(data['time'].toDate()),style: TextStyle(color: Colors.white),),
                              subtitle: Text(data['text'].toString(),style: TextStyle(color: Colors.white),),
                            ),
                            ElevatedButton(
                              onPressed: ()async {
                                String link = await getDownloadURL(data["folder_name"]);
                                playaudio(link);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 8),
                                child: Text('Play Generated Audio',style: TextStyle(fontSize: 16),),
                              ),
                              style: ButtonStyle(
                                backgroundColor:MaterialStateProperty.all<Color>(Colors.blueGrey.withOpacity(0.3)),
                                elevation: MaterialStateProperty.all(0),
                              ),
                            ),
                            Divider(
                              color: Colors.white,
                              indent: 10,
                              endIndent: 10,
                              thickness: 1,
                            )
                          ],
                        );
                      }).toList(),
                    );
                  },
                ),
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
        ),

      );
    });
  }
}

