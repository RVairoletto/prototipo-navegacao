import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:prototipo_navegacao/widgets/default_alert_dialog.dart';
import 'package:prototipo_navegacao/widgets/default_user_drawer.dart';
import 'dart:html';

class TestesView extends StatefulWidget {
  const TestesView({super.key});

  @override
  State<TestesView> createState() => _TestesViewState();
}

class _TestesViewState extends State<TestesView> {
  Color corContainer = Colors.yellow;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const DefaultUserDrawer(),
        appBar: AppBar(title: const Text("Tela de testes")),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              ElevatedButton(
                onPressed: () async {
                  final result = await showDialog(
                    context: context,
                    builder: (context) {
                      return const DefaultAlertDialog();
                    },
                  );

                  setState(() {
                    if (result) {
                      corContainer = Colors.green;
                    } else {
                      corContainer = Colors.red;
                    }
                  });
                },
                child: const Text("Mostrar modal"),
              ),
              Container(
                width: 300,
                height: 300,
                color: corContainer,
              ),
              ElevatedButton(
                onPressed: () async {
                  //
                },
                child: const Text("Get api"),
              )
            ],
          ),
        ));
  }

  void getAlbum() async {
    var client = HttpClient();

    try {
      HttpClientRequest request = await client.get('localhost', 80, '/file.txt');
      // Optionally set up headers...
      // Optionally write to the request object...
      HttpClientResponse response = await request.close();
      // Process the response
      final stringData = await response.transform(utf8.decoder).join();
      print(stringData);
    } finally {
      client.close();
    }
  }
}

class Album {
  final int userId;
  final int id;
  final String title;

  const Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}
