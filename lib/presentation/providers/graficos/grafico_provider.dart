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
  final IO.Socket _socket = IO.io('http://10.0.2.2:3000', {
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
  final IO.Socket _socket = IO.io('http://10.0.2.2:3000', {
    'transports': ['websocket'],
    'autoConnect': true,
  });

  ServerStatus get serverStatus => _serverStatus;
  IO.Socket get socket => _socket;

  List<Partido> bands = [
    // Band(id: '1', name: 'Metalica', votes: 1),
    // Band(id: '1', name: 'Queen', votes: 5),
    // Band(id: '1', name: 'System of down', votes: 3),
    // Band(id: '1', name: 'Blink 182', votes: 6),
  ];

  SocketService() : super([]);
   

  void _initConfig() {
    _socket.on('connect', (_) {
      print('connect');
      _serverStatus = ServerStatus.online;
      // Notify listeners using Riverpod's StateNotifier
      ChangeNotifier();
    });
    _socket.on('disconnect', (_) {
      print('disconnect');
      _serverStatus = ServerStatus.offline;
      // Notify listeners using Riverpod's StateNotifier
      ChangeNotifier();
    });
  }
}



