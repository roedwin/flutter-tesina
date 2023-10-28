import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_tesina/infraestructure/models/partidos.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { online, offline, connecting }

final socketServiceProvider = StateNotifierProvider<SocketService, dynamic>((ref) {
  return SocketService();
});


final socketStatusProvider = StateNotifierProvider<serverStatus,ServerStatus>((ref) {
  return serverStatus();
});

class serverStatus extends StateNotifier<ServerStatus> {
  //final IO.Socket _socket = IO.io('http://10.0.2.2:3000', {
  final IO.Socket _socket = IO.io('https://backend-graph.onrender.com', {
    'transports': ['websocket'],
    'autoConnect': true,
  });
  serverStatus() : super(ServerStatus.connecting){_initConfig();}

  void _initConfig() {
    _socket.on('connect', (_) {
      print('connect');
      state = ServerStatus.online;
      // Notify listeners using Riverpod's StateNotifier
    });
    _socket.on('disconnect', (_) {
      print('disconnect');
      state = ServerStatus.offline;
      // Notify listeners using Riverpod's StateNotifier
    });
  }

}

class SocketService extends StateNotifier<dynamic>{
  ServerStatus _serverStatus = ServerStatus.connecting;
  final IO.Socket _socket = IO.io('https://backend-graph.onrender.com/', {
    'transports': ['websocket'],
    'autoConnect': true,
  });

  ServerStatus get serverStatus => _serverStatus;
  IO.Socket get socket => _socket;

  
  SocketService() : super([]);
   
}


final datosProvider = StateNotifierProvider<DatosNotifier,List<Partido>>((ref) {
  return DatosNotifier();
});


class DatosNotifier extends StateNotifier<List<Partido>> {
  // final IO.Socket _socket = IO.io('https://backend-graph.onrender.com/', {
  final IO.Socket _socket = IO.io('http://54.218.81.88:3002', {
    'transports': ['websocket'],
    'autoConnect': true,
  });
  List<Partido> bands = [];
  DatosNotifier(): super([]){llenarDatos();}

  void llenarDatos(){
    // _socket.on('active-bands', (data) {
    _socket.on('getSufragios', (data) {
      print(data);
      bands = (data as List).map((band) => Partido.fromMap(band)).toList();
      state = bands;
    });
  }

}