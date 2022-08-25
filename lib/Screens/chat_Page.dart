import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scholar_chat/models/message.dart';
import '../constants.dart';
import '../widgets/chat_buble.dart';
import 'package:scholar_chat/models/message.dart';

class ChatPage extends StatelessWidget {
   ChatPage({Key? key}) : super(key: key);

  static String id = 'ChatPage';

  final _controller  = ScrollController();

  CollectionReference messages = FirebaseFirestore.instance.collection('messages');

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
   var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy("createdAt",descending: true).snapshots(),
      builder: (context,snapshot){
        if(snapshot.hasData) {
          List<Message> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++){
            messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
          }
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: primaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/scholar.png",height: 50,),
                  Text("Chat"),
                ],
              ),
              centerTitle: true,
            ),
            body:
            Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: _controller,
                    itemCount: messagesList.length,
                      itemBuilder: (context,index){
                    return messagesList[index].id == email ?
                      ChatBuble(message: messagesList[index],) : ChatBubleForFriend(message:messagesList[index]);
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data){
                      messages.add({
                        'message' : (data),
                        'createdAt' : DateTime.now(),
                        'id' : email,
                      });
                      controller.clear();
                      _controller.animateTo(
                        0,
                        duration: Duration(seconds: 1),
                        curve: Curves.fastOutSlowIn,
                      );

                    },
                    decoration: InputDecoration(
                      hintText: "Send Message",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }else{
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

