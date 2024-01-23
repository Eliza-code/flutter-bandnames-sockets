import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:band_names/models/band.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'Metalica', votes: 5),
    Band(id: '2', name: 'Queen', votes: 3),
    Band(id: '3', name: 'Heroes del silencio', votes: 7),
    Band(id: '4', name: 'Bon Jovi', votes: 4),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'BandNames',
            style: TextStyle(color: Colors.black87),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
          itemCount: bands.length,
          itemBuilder: (context, i) => _bandTile(bands[i])),
      floatingActionButton: FloatingActionButton(
        onPressed: addNewBand,
        elevation: 1,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction:DismissDirection.startToEnd,
      background: Container(
        padding: const EdgeInsets.only(left: 8.0),
        color: Colors.red,
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Text('Deleted band')),
        ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: Text(band.name.substring(0, 2)),
        ),
        title: Text(band.name),
        trailing: Text(
          '${band.votes}',
          style: const TextStyle(fontSize: 20),
        ),
        onTap: () {
          print(band.name);
        },
      ),
    );
  }

  addNewBand() {
    final textController = new TextEditingController();

    if (!Platform.isAndroid) {
      return showDialog(
          context: context,
          builder: (constext) {
            return AlertDialog(
                title: const Text('New band name'),
                content: TextField(controller: textController),
                actions: <Widget>[
                  MaterialButton(
                    elevation: 5,
                    onPressed: () => addBandToList(textController.text),
                    textColor: Colors.blue,
                    child: const Text('Add'),
                  )
                ]);
          });
    }
    showCupertinoDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: const Text('New Band Name'),
            content: CupertinoTextField(
              controller: textController,
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: const Text('Add'),
                onPressed: () => addBandToList(textController.text),
                ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                child: const Text('Dismiss'),
                onPressed: () => Navigator.pop(context),
                )
              ],
          );
        });
  }

  void addBandToList(String name) {
    if (name.length > 1) {
      this.bands.add( new Band(id: '5', name: name));
      setState(() {});
    }
    Navigator.pop(context);
  }
}
