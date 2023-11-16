import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:proyecto_tesina/infraestructure/models/generos.dart';
import 'package:proyecto_tesina/infraestructure/models/lugares.dart';
import 'package:proyecto_tesina/infraestructure/models/partidos.dart';
import 'package:proyecto_tesina/presentation/providers/graficos/grafico_provider.dart';
import 'package:proyecto_tesina/presentation/providers/theme/theme_provider.dart';
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
  // List<Departamento> bandsDep = [];

  @override
  Widget build(BuildContext context) {
    //final socketService = Provider.of<SocketService>(context);
    //final bands = ref.watch(socketServiceProvider);
    //final serverStatus = ref.read(socketServiceProvider.notifier).serverStatus;
    //final serverStatus = ref.watch(socketStatusProvider);

    bands = ref.watch(datosProvider);
    bandsM = ref.watch(masculinosProvider);
    bandsF = ref.watch(femeninasProvider);
    // bandsDep = ref.watch(departamentoProvider);

    int totalVotes = 0;
    int totalFVotes = 0;
    int totalMVotes = 0;
    for (var partido in bands) {
      totalVotes += partido.votes;
    }
    for (var partido in bandsF) {
      totalFVotes += partido.votes;
    }
    for (var partido in bandsM) {
      totalMVotes += partido.votes;
    }

    final objGeneros = [
      {
        "id": 1,
        "name": "Masculinos",
        "votes": totalMVotes
      },
      {
        "id": 2,
        "name": "Femeninos",
        "votes": totalFVotes
      },
    ];

    final totalGenero = totalFVotes + totalMVotes;

    final datosGeneros = (objGeneros).map((band) => Generos.fromMap(band)).toList();

    final titleStyle = Theme.of(context).textTheme.titleLarge;
    //final titleStyle = TextStyle(color: Colors.black, fontSize: 25);
    //final captionStyle = Theme.of(context).textTheme.bodySmall;

    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Votacion general total: ', style: titleStyle,),
                Text(totalVotes.toString(), style: titleStyle,),
              ],
            ),
            Center(child: showGraph(bands)),

            Text('Voto por departamento', style: titleStyle,),
            const SizedBox(child: DropdownButtonExample()),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Votos totales por genero', style: titleStyle,),
              ],
            ),
            Center(child: showGraph(datosGeneros),),

            Text('Voto Masculino', style: titleStyle,),
            // _showGraph(bandsM),
            const BarChartSampleM(),

            Text('Voto Femenino', style: titleStyle,),
            // _showGraph(bandsF),
            const BarChartSample(),


            //_showGraph(bandsDep),

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
        onTap:
            () {}, //() => socketService.socket.emit('vote-band', {'id': band.id}),
      ),
    );
  }

  
}
Widget showGraph(List datos) {
    Map<String, double> dataMap = {};

    //print(datos);

    //final datos = ref.watch(datosProvider);

    if (datos.isEmpty) return SizedBox(height: 250,child: Pulse(child: Icon(Icons.timelapse_rounded, size: 70,)));

    datos.forEach((band) {
      dataMap.putIfAbsent(band.name, () => band.votes.toDouble());
    });

    return Container(
        padding: const EdgeInsets.only(top: 10),
        width: double.infinity,
        height: 250,
        child: PieChart(dataMap: dataMap));
  }

const List<String> list = <String>['AHUACHAPAN','CABAÑAS','CHALATENANGO','CUSCATLAN','LA LIBERTAD','MORAZAN','LA PAZ','SANTA ANA','SAN MIGUEL','SAN SALVADOR','SAN VICENTE','SONSONATE','LA UNION','USULUTAN'];

class DropdownButtonExample extends ConsumerStatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  DropdownButtonExampleState createState() => DropdownButtonExampleState();
}

class DropdownButtonExampleState extends ConsumerState<DropdownButtonExample> {
  String dropdownValue = list.first;
  List<Departamento> bandsDep = [];

  @override
  Widget build(BuildContext context) {
    bandsDep = ref.watch(departamentoProvider);
    final isDark = ref.watch(isDarkModeProvider);
    dropdownValue = ref.watch(depProvider);
    return Column(
      children: [
        SizedBox(
          //width: double.infinity,
          child: DropdownButton<String>(
            alignment: AlignmentDirectional.centerStart,
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: TextStyle(color: isDark ? Colors.white70 : Colors.black87),
            underline: Container(
              height: 2,
              color: isDark ? Colors.white70 : Colors.black87,
            ),
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                dropdownValue = value!;
                ref.read(depProvider.notifier).update((state) => state = value);
              });
            },
            items: list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
        showGraph(bandsDep)
      ],
    );
  }
}