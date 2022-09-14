// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String username;
  final String userImage;
  bool isMine;
  final key;

  MessageBubble(
    this.message,
    this.username,
    this.userImage,
    this.isMine, {
    this.key,
  });

  @override
  Widget build(BuildContext context) {
    print(userImage);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          mainAxisAlignment:
              isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color:
                    isMine ? Colors.grey[300] : Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topRight: !isMine ? Radius.circular(0) : Radius.circular(10),
                  topLeft: isMine ? Radius.circular(0) : Radius.circular(10),
                  bottomRight:
                      isMine ? Radius.circular(0) : Radius.circular(10),
                  bottomLeft:
                      !isMine ? Radius.circular(0) : Radius.circular(10),
                ),
              ),
              width: 140,
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 15,
              ),
              margin: EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 10,
              ),
              child: Column(
                crossAxisAlignment:
                    isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isMine
                          ? Colors.black
                          : Theme.of(context).accentTextTheme.headline1.color,
                    ),
                  ),
                  Text(
                    message,
                    textAlign: isMine ? TextAlign.end : TextAlign.start,
                    style: TextStyle(
                      color: isMine
                          ? Colors.black
                          : Theme.of(context).accentTextTheme.headline1.color,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: isMine ? 220 : 120,
          child: CircleAvatar(
            backgroundImage: NetworkImage(userImage),
          ),
        ),
      ],
    );
  }
}
