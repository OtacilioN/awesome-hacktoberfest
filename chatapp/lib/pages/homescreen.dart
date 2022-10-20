import 'dart:convert';
import 'dart:async';
import 'package:cbot/helper/authSave.dart';
import 'package:cbot/model/Data.dart';
import 'package:cbot/pages/Camera_content.dart';
import 'package:cbot/model/Search_Data.dart';
import 'package:cbot/model/fData.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:velocity_x/velocity_x.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  GlobalKey<_ChatScreenState> _key = new GlobalKey<_ChatScreenState>();
  List<Data> chats = [];
  List<Search_Data> sData = [];
  String email = "";
  String id = "";
  //var key, index;
  int isSearching = 1;
  int rd = 0;
  io.Socket socket =
      io.io("https://cbot-backend.herokuapp.com/", <String, dynamic>{
    "transports": ["websocket"],
    "autoConnect": false,
  });
  Map<String, fData> users = new Map();
  // ignore: unnecessary_new
  TextEditingController cnt = new TextEditingController();

  @override
  void initState() {
    getId();
    super.initState();
  }

  setRead(String key) async {
    print("setRead");
    if (isSearching == 1 && !key.isEmptyOrNull) {
      var url = Uri.parse('https://cbot-backend.herokuapp.com/setRead');
      users[key]!.id.forEach((element) async {
        var body = jsonEncode({'id': element});
        var response = await http.post(url,
            body: body, headers: {'content-type': 'application/json'});
      });
      users[key]!.id = [];
      users[key]!.unreadCount = 0;
      setState(() {});
    }
  }

  setOnline() async {
    var url = Uri.parse('https://cbot-backend.herokuapp.com/setStatus');
    var body = jsonEncode({'id': id});
    var response = await http
        .post(url, body: body, headers: {'content-type': 'application/json'});
    print("------User Online----");
  }

  getId() async {
    print("getId");
    await authSave.getId().then((value) => {id = value!});
    socket.connect();
    socket.onConnect((data) {
      socket.emit('signin', id);
      setOnline();
    });
    if (id != "") {
      socket.emit("signin", '${id}');
      socket.on("message", (data) async {
        print(data);
        await getChats();
        if (_key.currentWidget != null) if (!_key
            .currentState!.widget.email.isEmptyOrNull) {
          await setRead(_key.currentState!.widget.email);
        }
        if (_key.currentWidget != null && context.screenWidth < 875) {
          _key.currentState!.setState(() {});
        }
      });
      await getChats();
    }
  }

  getChats() async {
    print("getChats");
    //all chats
    var url = Uri.parse('https://cbot-backend.herokuapp.com/getChat');
    var response = await http.post(url,
        body: json.encode({'user': id}),
        headers: {'content-type': 'application/json'});
    var data = jsonDecode(response.body);
    if (data['data'] != null) {
      chats = [];
      data['data'].forEach((v) {
        chats.add(new Data.fromJson(v));
      });
    }
    print(chats.length);
    //unread Chats
    Map<String, fData> lusers = new Map<String, fData>();
    chats.reversed.forEach((element) {
      //print(element.messageText);
      if (element.sentUser == id) {
        if (!lusers.containsKey(element.receivedUserEmail)) {
          //last chat enterred after repeat messaging
          fData fd = new fData(
            id: [],
            userEmail: element.receivedUserEmail.toString(),
            lastText: element.messageText.toString(),
            unreadCount: 0,
          );
          lusers[element.receivedUserEmail.toString()] = fd;
        }
      } else if ((element.receivedUser == id)) {
        if (element.unread == "false") {
          if (!lusers.containsKey(element.sentUserEmail)) {
            fData fd = new fData(
              id: [element.sId!],
              userEmail: element.sentUserEmail.toString(),
              lastText: element.messageText.toString(),
              unreadCount: 0,
            );
            lusers[element.sentUserEmail.toString()] = fd;
          }
        } else if (element.unread == "True") {
          if (!lusers.containsKey(element.sentUserEmail)) {
            fData fd = new fData(
              id: [element.sId!],
              userEmail: element.sentUserEmail.toString(),
              lastText: element.messageText.toString(),
              unreadCount: 1,
            );
            lusers[element.sentUserEmail.toString()] = fd;
          } else {
            fData fd = lusers[element.sentUserEmail.toString()]!;
            fd.id.add(element.sId.toString());
            //print(fd.lastText);
            fd.unreadCount++;
            lusers[element.sentUserEmail.toString()] = fd;
          }
        }
      }
    });
    users = lusers;
    print(lusers.length);
    _key.currentWidget != null ? _key.currentState!.widget.chats = chats : null;
    setState(() {});
  }

  searchValue(String value) async {
    var url = Uri.parse('https://cbot-backend.herokuapp.com/findData');
    var response = await http.post(url,
        body: json.encode({'string': value, "user": id}),
        headers: {'content-type': 'application/json'});
    var data = jsonDecode(response.body);
    if (data['data'] != null) {
      sData = <Search_Data>[];
      data['data'].forEach((v) {
        sData.add(new Search_Data.fromJson(v));
      });
    }
    setState(() {
      isSearching = 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      child: Row(
        children: [
          Container(
              width: context.screenWidth > 875
                  ? context.screenWidth * 0.25 > 350
                      ? context.screenWidth * 0.25
                      : 350
                  : context.screenWidth,
              color: Color.fromRGBO(245, 247, 251, 1),
              child: Scaffold(
                appBar: AppBar(
                    elevation: 0,
                    backgroundColor: Color.fromRGBO(245, 247, 251, 1),
                    title: Row(
                      children: [
                        Text(
                          "Whatsapp",
                          style: TextStyle(color: Vx.black),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.account_circle_rounded,
                            color: Colors.black38,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        )
                      ],
                    )),
                body: Container(
                    color: Color.fromRGBO(245, 247, 251, 1),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    child: Column(
                      children: [
                        Container(
                          child: TextField(
                            controller: cnt,
                            decoration: InputDecoration(
                              hoverColor: Color.fromRGBO(255, 255, 255, 0.8),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none),
                              hintText: "Type Something",
                              fillColor: Color.fromRGBO(255, 255, 255, 0.8),
                              filled: true,
                              contentPadding: EdgeInsets.all(10),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    //newewewewew
                                    setState(() {
                                      cnt.clear();
                                      rd = 0;
                                      isSearching = 1;
                                    });
                                  },
                                  icon: Icon(rd == 0
                                      ? Icons.search_rounded
                                      : Icons.highlight_off)),
                            ),
                            onTap: () {
                              setState(() {
                                rd = 1;
                              });
                            },
                            onChanged: (value) {
                              if (value != "")
                                setState(() {
                                  searchValue(value);
                                });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white),
                          child: ListView.separated(
                              shrinkWrap: true,
                              itemBuilder: ((context, index) {
                                String key = isSearching == 2
                                    ? ""
                                    : users.keys.elementAt(index);

                                return GestureDetector(
                                  onTap: () async {
                                    if (context.screenWidth > 875) {
                                      setState(() {
                                        email = isSearching == 2
                                            ? sData[index].email.toString()
                                            : key;
                                      });
                                      setRead(key);
                                    } else {
                                      await setRead(key);
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (_) => ChatScreen(
                                                  key: _key,
                                                  email: isSearching == 2
                                                      ? sData[index]
                                                          .email
                                                          .toString()
                                                      : key,
                                                  chats: chats,
                                                  getchats: getChats)));
                                    }
                                  },
                                  child: Container(
                                      //color: users[key]!.unreadCount > 0? Vx.blue800: Vx.white,
                                      width: context.screenWidth,
                                      padding: EdgeInsets.all(15),
                                      child: Row(
                                        children: [
                                          CircleAvatar(),
                                          SizedBox(
                                            width: 25,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              //Text("Helo")
                                              Text(
                                                isSearching == 2
                                                    ? sData[index]
                                                        .email
                                                        .toString()
                                                    : key,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Vx.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              isSearching == 2
                                                  ? Text("")
                                                  : users[key]!
                                                          .lastText
                                                          .toString()
                                                          .isEmptyOrNull
                                                      ? Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Icon(Icons.photo,
                                                                size: 20),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(
                                                              "Photo",
                                                              style: TextStyle(
                                                                  fontSize: 15),
                                                            )
                                                          ],
                                                        )
                                                      : Text(users[key]!
                                                          .lastText
                                                          .toString()),
                                            ],
                                          ),
                                          Spacer(),
                                          isSearching == 1
                                              ? Container(
                                                  child: Text(
                                                  users[key]!
                                                              .unreadCount
                                                              .toString() ==
                                                          '0'
                                                      ? ''
                                                      : users[key]!
                                                          .unreadCount
                                                          .toString(),
                                                ))
                                              : SizedBox(
                                                  width: 0,
                                                ),
                                          SizedBox(width: 8)
                                        ],
                                      )),
                                );
                              }),
                              separatorBuilder: (context, index) => Divider(),
                              itemCount: isSearching == 2
                                  ? sData.length
                                  : users.length),
                        )
                      ],
                    )),
              )),
          context.screenWidth > 875
              ? Container(
                  width: context.screenWidth * 0.25 > 350
                      ? context.screenWidth * 0.75
                      : context.screenWidth - 350,
                  color: Color.fromRGBO(245, 247, 251, 1),
                  child: ChatScreen(
                      key: _key,
                      email: email,
                      chats: chats,
                      getchats: getChats),
                )
              : SizedBox()
        ],
      ),
    ));
  }
}

class ChatScreen extends StatefulWidget {
  String email;
  List<Data> chats;
  Function getchats;
  ChatScreen({
    Key? key,
    required this.email,
    required this.chats,
    required this.getchats,
  }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController cnt = new TextEditingController();
  ScrollController scr = new ScrollController();
  List<Data> fChats = [];
  bool a_clk = false;
  io.Socket socket =
      io.io("https://cbot-backend.herokuapp.com/", <String, dynamic>{
    "transports": ["websocket"],
    "autoConnect": false,
  });
  String id = "";
  String subt = "";
  scanData() async {
    print("scanData");
    if (!widget.email.isEmptyOrNull) {
      fChats.clear();
      widget.chats.forEach((element) {
        if (element.receivedUserEmail == widget.email ||
            element.sentUserEmail == widget.email) {
          fChats.add(element);
        }
      });
      fChats = fChats.reversed.toList();
    }
  }

  sendMessage(String text) async {
    print("send Message");
    var url = Uri.parse('https://cbot-backend.herokuapp.com/getUID');
    var response = await http.post(url,
        body: json.encode({'user': widget.email}),
        headers: {'content-type': 'application/json'});
    var data = jsonDecode(response.body);
    var rId = data['id'];
    url = Uri.parse('https://cbot-backend.herokuapp.com/addChat');
    response = await http.post(url,
        body: json.encode({'sentUser': id, "recUser": rId, "mssgText": text}),
        headers: {'content-type': 'application/json'});
    socket.emit('message', {"message": text, "recUser": rId, "sentUser": id});
    if (response.statusCode == 200) {
      await widget.getchats();
      Timer(Duration(milliseconds: 100), () {
        setState(() {});
      });
    }
  }

  getId() async {
    print("getChat  screenId");
    await authSave.getId().then((value) => {id = value!});
    socket.connect();
  }

  getStatus() async {
    print("getStatus");
    var url = Uri.parse('https://cbot-backend.herokuapp.com/getStatus');
    var response = await http.post(url,
        body: json.encode({'email': widget.email}),
        headers: {'content-type': 'application/json'});
    var data = jsonDecode(response.body);
    if (data['status'])
      subt = "Online";
    else
      subt = "Offline";
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getId();
  }

  @override
  Widget build(BuildContext context) {
    !widget.email.isEmptyOrNull ? scanData() : null;
    if ((!widget.email.isEmptyOrNull) && subt.isEmptyOrNull) {
      getStatus();
    }
    var wvalue = context.screenWidth > 875
        ? context.screenWidth * 0.25 > 350
            ? context.screenWidth * 0.75
            : context.screenWidth - 350
        : context.screenWidth;
    return widget.email != ""
        ? Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Vx.white,
              leading: IconButton(
                onPressed: () {
                  context.screenWidth < 875
                      ? Navigator.of(context).pop()
                      : null;
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Vx.black,
                ),
              ),
              title: Container(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.email,
                          style: TextStyle(
                              fontSize: context.screenWidth > 900 ? 25 : 15,
                              color: Vx.black),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          subt,
                          style: TextStyle(
                              color: Vx.black,
                              fontSize: context.screenWidth > 900 ? 15 : 10),
                        ),
                      ],
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
            body: Container(
                color: Color.fromRGBO(245, 247, 251, 1),
                padding: context.screenWidth > 875
                    ? EdgeInsets.symmetric(horizontal: 5, vertical: 5)
                    : EdgeInsets.all(0),
                alignment: Alignment.bottomCenter,
                width: context.screenWidth,
                height: context.screenHeight,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    //part screeen
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Container(
                              padding: EdgeInsets.fromLTRB(15, 5, 15, 90),
                              color: Color.fromRGBO(245, 245, 245, 0.8),
                              alignment: Alignment.bottomLeft,
                              width: context.screenWidth,
                              child: ScrollConfiguration(
                                behavior: MyBehavior(),
                                child: ListView.builder(
                                  controller: scr,
                                  reverse: true,
                                  shrinkWrap: true,
                                  itemBuilder: ((context, index) {
                                    return Container(
                                      padding: EdgeInsets.all(5),
                                      alignment: fChats[index].sentUserEmail ==
                                              widget.email
                                          ? Alignment.centerLeft
                                          : Alignment.centerRight,
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color:
                                                fChats[index].sentUserEmail ==
                                                        widget.email
                                                    ? Colors.red.shade100
                                                    : Colors.green.shade200),
                                        child: Column(
                                          crossAxisAlignment:
                                              fChats[index].sentUserEmail ==
                                                      widget.email
                                                  ? CrossAxisAlignment.start
                                                  : CrossAxisAlignment.end,
                                          children: [
                                            fChats[index]
                                                        .imagePath
                                                        .toString() !=
                                                    "null"
                                                ? Container(
                                                    width: wvalue * 0.5,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      child: Image(
                                                        image: NetworkImage(
                                                          'https://cbot-backend.herokuapp.com/uploads/${fChats[index].imagePath}',
                                                        ),
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ))
                                                : SizedBox(height: 0),
                                            fChats[index]
                                                        .imagePath
                                                        .toString() !=
                                                    "null"
                                                ? !fChats[index]
                                                        .messageText
                                                        .toString()
                                                        .isEmptyOrNull
                                                    ? SizedBox(
                                                        height: 10,
                                                      )
                                                    : SizedBox(
                                                        height: 0,
                                                      )
                                                : SizedBox(
                                                    height: 0,
                                                  ),
                                            !fChats[index]
                                                    .messageText
                                                    .toString()
                                                    .isEmptyOrNull
                                                ? Text(fChats[index]
                                                    .messageText
                                                    .toString())
                                                : SizedBox(
                                                    height: 0,
                                                  ),
                                            fChats[index].sentUserEmail !=
                                                    widget.email
                                                ? Icon(
                                                    Icons.done_all_outlined,
                                                    color:
                                                        fChats[index].unread ==
                                                                "false"
                                                            ? Colors.blue
                                                            : Colors.grey,
                                                    size: 10,
                                                  )
                                                : SizedBox(
                                                    height: 0,
                                                  )
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                  itemCount: fChats.length,
                                ),
                              )),
                        ),
                      ],
                    ),
                    //send buttton and input
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        a_clk
                            ? AnimatedContainer(
                                duration: Duration(milliseconds: 1000),
                                curve: Curves.easeInCirc,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  height: 100,
                                  margin: EdgeInsets.fromLTRB(50, 0, 0, 0),
                                ))
                            : SizedBox(
                                height: 0,
                              ),
                        a_clk
                            ? SizedBox(
                                height: 10,
                              )
                            : SizedBox(
                                height: 0,
                              ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: context.screenWidth > 875
                                ? BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15))
                                : BorderRadius.circular(0),
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: TextField(
                                  onSubmitted: (value) {
                                    if (value != "") {
                                      sendMessage(cnt.text);
                                      cnt.clear();
                                    }
                                  },
                                  controller: cnt,
                                  decoration: InputDecoration(
                                    hoverColor:
                                        Color.fromRGBO(245, 247, 251, 1),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide.none),
                                    hintText: "Type Something",
                                    fillColor: Color.fromRGBO(245, 247, 251, 1),
                                    filled: true,
                                    contentPadding: EdgeInsets.all(10),
                                    prefixIcon: IconButton(
                                      icon: Icon(Icons.attachment_outlined),
                                      onPressed: () {
                                        setState(() {
                                          a_clk = !a_clk;
                                        });
                                      },
                                    ),
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          if (context.screenWidth < 875)
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        Camera_content(
                                                          email: widget.email,
                                                          callState: () {
                                                            setState(() {});
                                                          },
                                                          getchats:
                                                              widget.getchats,
                                                        )));
                                          else {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                    contentPadding:
                                                        EdgeInsets.all(0),
                                                    content: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      child: Container(
                                                        height: context
                                                                .screenHeight *
                                                            0.5,
                                                        width: context
                                                                .screenWidth *
                                                            0.5,
                                                        color: Vx.black,
                                                        child: Camera_content(
                                                          email: widget.email,
                                                          callState: () {
                                                            setState(() {});
                                                          },
                                                          getchats:
                                                              widget.getchats,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                });
                                          }
                                        },
                                        icon: Icon(cameras.isNotEmpty
                                            ? Icons.photo_camera
                                            : Icons.no_photography)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (cnt.text != "") {
                                    sendMessage(cnt.text);
                                    cnt.clear();
                                  }
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
                    )
                  ],
                )),
          )
        : Scaffold(
            body: Container(
              alignment: Alignment.center,
              color: Color.fromRGBO(245, 247, 251, 1),
              width: context.screenWidth,
              height: context.screenWidth,
              child: Center(child: Text("Click on a chat to show")),
            ),
          );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
