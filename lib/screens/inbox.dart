import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foresight/screens/search.dart';
import 'package:hidden_drawer_menu/hidden_drawer/hidden_drawer_menu.dart';
import 'package:image_picker/image_picker.dart';

enum Direction { FROM, TO }
enum Type { TEXT, IMAGE, GIF, VIDEO }

class InboxView extends StatelessWidget {
  final SimpleHiddenDrawerBloc controller;
  FocusNode _focusNode = new FocusNode();
  TextEditingController _editingController = new TextEditingController();

  InboxView({Key key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(FontAwesomeIcons.feather),
          onPressed: () {},
        ),
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: Size(10, 60),
            child: SearchWidget(_focusNode, _editingController),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(FontAwesomeIcons.ellipsisV),
              onPressed: () {},
              color: Colors.black,
            )
          ],
          backgroundColor: Colors.white,
          title: Text(
            "Inbox",
            style: TextStyle(color: Colors.black),
          ),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image(
              color: Colors.green,
              image: AssetImage("assets/splash.png"),
            ),
          ),
        ),
        body: ListView.builder(
          itemBuilder: (_, index) => MessageHeader(
                id: index,
              ),
        ));
  }
}

class MessageHeader extends StatelessWidget {
  final int id;

  const MessageHeader({Key key, this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Dismissible(
        background: ListTile(
          leading: Icon(FontAwesomeIcons.archive),
          trailing: Icon(FontAwesomeIcons.trashAlt),
        ),
        onDismissed: (direction) {},
        child: ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatView(id: id),
              ),
            );
          },
          //dense: true,
          //isLine: true,
          title: Text(
            "Soraya Sativa",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          subtitle: Text("Hello indica"),
          leading: CircleAvatar(
            backgroundImage: AssetImage("assets/pp.jpg"),
          ),
        ),
        key: Key(id.toString()),
      ),
    );
  }
}

class Chat {
  String content;
  Direction direction;
  DateTime dateTime;
  Type type;
}

class ChatView extends StatefulWidget {
  final int id;
  ChatView({Key key, this.id}) : super(key: key);

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> with TickerProviderStateMixin {
  final List<ChatItem> chats = [];
  final TextEditingController _controller = new TextEditingController();
  String image;
  bool isGifBlockOpen = false;
  FocusNode focusNode = new FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(onFocusChange);
  }

  void onFocusChange() {
    if (focusNode.hasFocus) {
      // Hide sticker when keyboard appear
      setState(() {
        print(1);
        isGifBlockOpen = false;
      });
    } else if (!focusNode.hasFocus) {
      setState(() {
        print(4);
        isGifBlockOpen = false;
      });
    }
  }

  handleSubmit(Type type, String content) {
    _controller.clear();
    Chat chat = new Chat();
    chat.content = content;
    chat.type = type;
    chat.dateTime = DateTime.now();
    chat.direction = Direction.TO;

    var chatItem = ChatItem(
      chat: chat,
      animationController: AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1000),
      ),
    );

    setState(() {
      chats.insert(0, chatItem);
    });
    chatItem.animationController.forward();
  }

  getImage() async {
    var file = await ImagePicker.pickImage(source: ImageSource.gallery);
    image = file.uri.path;
    handleSubmit(Type.IMAGE, image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(FontAwesomeIcons.ellipsisV),
            onPressed: () {},
          )
        ],
        title: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 2, right: 8),
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/pp.jpg"),
              ),
            ),
            Text("Soraya Indica"),
          ],
        ),
      ),
      body: Flex(
        direction: Axis.vertical,
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Flexible(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/back/back.jpg"),
                      fit: BoxFit.cover),
                ),
                child: ListView.builder(
                  reverse: true,
                  itemCount: chats.length,
                  itemBuilder: (_, index) {
                    return chats[index];
                  },
                ),
              )),
          Flexible(
            flex: 2,
            child: Container(
              //height: 100,
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(FontAwesomeIcons.image),
                    onPressed: () {
                      getImage();
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.gif),
                    onPressed: () {
                      setState(() {
                        isGifBlockOpen = !isGifBlockOpen;
                      });
                    },
                  ),
                  Container(
                    height: 100,
                    width: 200,
                    //color: Colors.green,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        focusNode: focusNode,
                        controller: _controller,
                        onSubmitted: (text) {
                          handleSubmit(Type.TEXT, text);
                        },
                        decoration: InputDecoration(
                            //isDense: true,
                            contentPadding:
                                EdgeInsets.only(bottom: 10, top: 10, left: 10),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "Type Message",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30))),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      handleSubmit(Type.TEXT, _controller.text);
                    },
                  )
                ],
              ),
            ),
          ),
          isGifBlockOpen ? buildGifBock() : Container()
        ],
      ),
    );
  }

  buildGifItem(String name) {
    var gif = "assets/gifs/$name";
    return InkWell(
      child: Container(
        height: 100,
        width: 100,
        child: Image.asset(gif),
      ),
      onTap: () {
        handleSubmit(Type.GIF, gif);
      },
    );
  }

  buildGifBock() {
    return Container(
      height: 200,
      //color: Colors.blue,
      child: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (_, index) => buildGifItem("mimi${index + 1}.gif"),
        itemCount: 9,
      ),
    );
  }

  @override
  void dispose() {
    for (var item in chats) {
      item.animationController.dispose();
    }
    super.dispose();
  }
}

class ChatItem extends StatelessWidget {
  final AnimationController animationController;
  final Chat chat;
  const ChatItem({Key key, this.animationController, this.chat})
      : super(key: key);

  getType() {
    switch (chat.type) {
      case Type.TEXT:
        return Padding(
          padding: const EdgeInsets.all(3.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 3,
            color: Colors.green,
            child: Container(
              margin: EdgeInsets.all(20),
              child: Text(chat.content,style: TextStyle(color: Colors.white),),
            ),
          ),
        );
      case Type.IMAGE:
        var file = File(chat.content);
        return Card(
          child: Container(
            height: 300,
            child: Image(
              image: FileImage(file),
            ),
          ),
        );

      case Type.GIF:
        return Container(
          height: 100,
          child: Image.asset(chat.content),
        );
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    var time = "${chat.dateTime.hour}:${chat.dateTime.minute}";

    return SizeTransition(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          getType(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              time,
              style: TextStyle(fontSize: 10, color: Colors.white),
            ),
          )
        ],
      ),
      sizeFactor: CurvedAnimation(
        parent: animationController,
        curve: Curves.bounceInOut,
      ),
    );
  }
}
