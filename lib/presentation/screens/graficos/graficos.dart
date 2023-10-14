import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:proyecto_tesina/infraestructure/models/partidos.dart';
import 'package:proyecto_tesina/presentation/providers/graficos/grafico_provider.dart';


class Graficos extends ConsumerStatefulWidget {
  static const name = 'graficos-screen';
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<Graficos> {
  List<Partido> bands = [
    // Band(id: '1', name: 'Metalica', votes: 1),
    // Band(id: '1', name: 'Queen', votes: 5),
    // Band(id: '1', name: 'System of down', votes: 3),
    // Band(id: '1', name: 'Blink 182', votes: 6),
  ];
  @override
  void initState() {
    final socketService = ref.read(socketServiceProvider.notifier);

    socketService.socket.on('active-bands', _handleActiveBands);

    super.initState();    
  }

  _handleActiveBands(dynamic payload) {
    bands = (payload as List).map((band) => Partido.fromMap(band)).toList();

    setState(() {});
  }

  @override
  void dispose() {
    final socketService = ref.read(socketServiceProvider.notifier).socket;
    socketService.off('active-bands');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final socketService = Provider.of<SocketService>(context);
    //final bands = ref.watch(socketServiceProvider);
    //final serverStatus = ref.read(socketServiceProvider.notifier).serverStatus;
    final serverStatus = ref.watch(socketStatusProvider);

   
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child:
                serverStatus.toString() == "ServerStatus.online"
                    ? Icon(
                        Icons.check_circle,
                        color: Colors.blue[300],
                      )
                    : const Icon(
                        Icons.offline_bolt,
                        color: Colors.red,
                      ),
          )
        ],
        title: const Text(
          'BandNames',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          _showGraph(),
          Expanded(
            child: ListView.builder(
              itemCount: bands.length,
              itemBuilder: (context, i) => _bandTile(bands[i]),
            ),
          )
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   elevation: 1,
      //   onPressed: addNewBand,
      //   child: const Icon(Icons.add),
      // ),
    );
  }

  Widget _bandTile(Partido band) {
    //final socketService = Provider.of<SocketService>(context, listen: false);
    //final bands = ref.watch(socketServiceProvider);
    //final serverStatus = ref.watch(socketStateNotifierProvider);
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      // onDismissed: (_) =>
      //     socketService.socket.emit('delete-band', {'id': band.id}),
      background: Container(
        padding: const EdgeInsets.only(left: 8.0),
        color: Colors.red,
        child: const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Delete band',
              style: TextStyle(color: Colors.white),
            )),
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
          
        },//() => socketService.socket.emit('vote-band', {'id': band.id}),
      ),
    );
  }

  // addNewBand() {
  //   final textController = TextEditingController();
  //   if (Platform.isAndroid) {
  //     return showDialog(
  //       context: context,
  //       builder: (_) => AlertDialog(
  //         title: const Text('New band name:'),
  //         content: TextField(
  //           controller: textController,
  //         ),
  //         actions: [
  //           MaterialButton(
  //             textColor: Colors.blue,
  //             elevation: 5,
  //             onPressed: () => addBandToList(textController.text),
  //             child: const Text(
  //               'Add',
  //               style: TextStyle(fontSize: 20),
  //             ),
  //           )
  //         ],
  //       ),
  //     );
  //   }
  //   showCupertinoDialog(
  //     context: context,
  //     builder: (_) => CupertinoAlertDialog(
  //       title: const Text('New band name:'),
  //       content: TextField(
  //         controller: textController,
  //       ),
  //       actions: [
  //         CupertinoDialogAction(
  //           isDefaultAction: true,
  //           child: const Text('Add'),
  //           onPressed: () => addBandToList(textController.text),
  //         ),
  //         CupertinoDialogAction(
  //           isDestructiveAction: true,
  //           child: const Text('Dismiss'),
  //           onPressed: () => Navigator.pop(context),
  //         )
  //       ],
  //     ),
  //   );
  // }

  // void addBandToList(String name) {
  //   if (name.length > 1) {
  //     final socketService = Provider.of<SocketService>(context, listen: false);
  //     socketService.socket.emit('add-band', {'name': name});
  //   }

  //   Navigator.pop(context);
  // }
  // int touchedIndex = 0;
  Widget _showGraph() {
    Map<String, double> dataMap = {};

    bands.forEach((band) {
      dataMap.putIfAbsent(band.name, () => band.votes.toDouble());
    });

    //if(dataMap.isEmpty) return const CircularProgressIndicator();

    return dataMap.isEmpty ? const CircularProgressIndicator() : Container(
      padding: const EdgeInsets.only(top: 10),
      width: double.infinity,
      height: 250,
      child: PieChart(dataMap: dataMap)
    );   
    
  } 
  
}
