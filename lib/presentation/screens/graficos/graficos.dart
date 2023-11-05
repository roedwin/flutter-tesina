
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:proyecto_tesina/infraestructure/models/generos.dart';
import 'package:proyecto_tesina/infraestructure/models/partidos.dart';
import 'package:proyecto_tesina/presentation/providers/graficos/grafico_provider.dart';
import 'package:proyecto_tesina/presentation/widgets/bar_graph.dart';
import 'package:proyecto_tesina/presentation/widgets/bar_graph_m.dart';
import 'package:proyecto_tesina/presentation/widgets/side_menu.dart';


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

  List<Masculino> bandsM = [];
  List<Femenino> bandsF = [];

  @override
  Widget build(BuildContext context) {
    //final socketService = Provider.of<SocketService>(context);
    //final bands = ref.watch(socketServiceProvider);
    //final serverStatus = ref.read(socketServiceProvider.notifier).serverStatus;
    //final serverStatus = ref.watch(socketStatusProvider);

    bands = ref.watch(datosProvider);
    bandsM = ref.watch(masculinosProvider);
    bandsF = ref.watch(femeninasProvider);
   
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
      ),
      body: SingleChildScrollView(
        child:Column(
          children: [
            const Text('Votacion general'),
            Center(child: _showGraph(bands)),
      
            const Text('Voto Masculino'),
            // _showGraph(bandsM),
            const BarChartSampleM(),
            
            const Text('Voto Femenino'),
            // _showGraph(bandsF),
            const BarChartSample()
            
            
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: bands.length,
            //     itemBuilder: (context, i) => _bandTile(bands[i]),
            //   ),
            // )
          ],
        ),
      ),
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      floatingActionButton: FloatingActionButton(
        elevation: 1,
        onPressed: () => context.go('/'),
        child: const Icon(Icons.arrow_back),
      ),
    );
  }

  Widget _bandTile(Partido band) {
    //final socketService = Provider.of<SocketService>(context, listen: false);
    //final bands = ref.watch(socketServiceProvider);
    //final serverStatus = ref.watch(socketStateNotifierProvider);
    return Dismissible(
      key: Key(band.id.toString()),
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

  Widget _showGraph(List datos) {
    Map<String, double> dataMap = {};

    //final datos = ref.watch(datosProvider);

    if(datos.isEmpty) return const CircularProgressIndicator();
    

    datos.forEach((band) {
      dataMap.putIfAbsent(band.name, () => band.votes.toDouble());
    });


    return Container(
      padding: const EdgeInsets.only(top: 10),
      width: double.infinity,
      height: 250,
      child: PieChart(dataMap: dataMap)
    );   
    
  } 
  
}
