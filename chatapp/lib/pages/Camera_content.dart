import 'dart:convert';
import 'package:cbot/helper/authSave.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

List<CameraDescription> cameras = [];

class Camera_content extends StatefulWidget {
  String email;
  Function getchats;
  Function callState;
  Camera_content(
      {Key? key,
      required this.email,
      required this.getchats,
      required this.callState})
      : super(key: key);

  @override
  _Camera_contentState createState() => _Camera_contentState();
}

class _Camera_contentState extends State<Camera_content> {
  CameraController? cnt;
  int current = 0;
  XFile? file;
  String id = "";
  io.Socket socket =
      io.io("https://cbot-backend.herokuapp.com/", <String, dynamic>{
    "transports": ["websocket"],
    "autoConnect": false,
  });
  bool clicked = false;
  TextEditingController cont = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    socket.connect();
    if (cameras.isNotEmpty) {
      cnt = CameraController(cameras[current], ResolutionPreset.ultraHigh);
      cnt!.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    }
  }

  sendMessage(String text) async {
    await authSave.getId().then((value) => {id = value!});

    var url = Uri.parse('https://cbot-backend.herokuapp.com/getUID');
    var response = await http.post(url,
        body: json.encode({'user': widget.email}),
        headers: {'content-type': 'application/json'});
    var data = jsonDecode(response.body);
    var rId = data['id'];

    Uri uri = Uri.parse('https://cbot-backend.herokuapp.com/attChat');
    http.MultipartRequest request = http.MultipartRequest('POST', uri);
    request.fields['sentUser'] = id;
    request.fields['recUser'] = rId;
    List<int> fl = await file!.readAsBytes();
    if (fl.isNotEmpty) {
      request.files.add(await http.MultipartFile.fromBytes('filePath', fl,
          filename: 'snapshot.jpg'));
      request.headers.addAll({
        "Content-type": "multipart/form-data",
      });
      http.StreamedResponse resp = await request.send();
      var responseBytes = await resp.stream.toBytes();
      var responseString = utf8.decode(responseBytes);
      socket.emit('message', {"message": text, "recUser": rId, "sentUser": id});
      if (response.statusCode == 200) {
        await widget.getchats();
        await widget.callState();
      }
    }
  }

  @override
  void dispose() {
    cnt?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: Icon(Icons.close, color: Vx.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )),
        extendBodyBehindAppBar: true,
        body: clicked == false
            ? Container(
                alignment: Alignment.center,
                color: Vx.black,
                child: (cameras.isNotEmpty)
                    ? Stack(
                        alignment: Alignment.center,
                        children: [
                          CameraPreview(cnt!),
                          Container(
                              alignment: Alignment.bottomCenter,
                              height: context.screenHeight,
                              padding: EdgeInsets.only(bottom: 25),
                              width: context.screenWidth,
                              color: Colors.transparent,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.switch_camera_outlined,
                                        color: Vx.white, size: 25),
                                    onPressed: () {
                                      current = current == 1 ? 0 : 1;
                                      cameras.length >= 2
                                          ? cnt = CameraController(
                                              cameras[current],
                                              ResolutionPreset.ultraHigh)
                                          : null;
                                      cnt!.initialize().then((_) {
                                        if (!mounted) {
                                          return;
                                        }
                                        setState(() {});
                                      });
                                    },
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      file = await cnt!.takePicture();
                                      setState(() {
                                        clicked = true;
                                      });
                                    },
                                    child: Container(
                                      child: Icon(
                                        Icons.camera,
                                        color: Vx.white,
                                        size: 55,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.video_camera_back,
                                        color: Vx.white, size: 25),
                                    onPressed: () {},
                                  )
                                ],
                              ))
                        ],
                      )
                    : Text(
                        "Couldnt detect Camera\nTry refreshing and reconnecting device",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Vx.white),
                      ),
              )
            : Container(
                alignment: Alignment.center,
                color: Vx.black,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.network(
                      file!.path,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                        borderRadius: context.screenWidth > 875
                            ? BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15))
                            : BorderRadius.circular(0),
                        color: Colors.transparent,
                      ),
                      padding: EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: TextField(
                              onSubmitted: (value) {
                                sendMessage(cont.text);
                                cont.clear();
                                Navigator.of(context).pop();
                              },
                              controller: cont,
                              decoration: InputDecoration(
                                hoverColor: Color.fromRGBO(245, 247, 251, 1),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide.none),
                                hintText: "Type Something",
                                fillColor: Color.fromRGBO(245, 247, 251, 1),
                                filled: true,
                                contentPadding: EdgeInsets.all(10),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          GestureDetector(
                            onTap: () {
                              sendMessage(cont.text);
                              cont.clear();
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Vx.green700,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Icon(
                                Icons.send,
                                color: Vx.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )));
  }
}
