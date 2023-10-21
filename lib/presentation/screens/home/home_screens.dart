import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:proyecto_tesina/infraestructure/models/partidos.dart';
import 'package:proyecto_tesina/presentation/widgets/side_menu.dart';

import '../../../config/menu/menu_items.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const name = 'home-screen';


  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  List<Partido> bands = [
    Partido(id: '1', name: 'FMLN', votes: 2),
    Partido(id: '1', name: 'Nuevas Ideas', votes: 7),
    Partido(id: '1', name: 'Arena', votes: 3),
    Partido(id: '1', name: 'VAMOS', votes: 1),
  ];

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        const Align(
          alignment:
              Alignment.topCenter, // Alinea la imagen en la parte superior
          child: FractionallySizedBox(
            widthFactor: 1.0, // Ocupa todo el ancho disponible
            child: Image(
              image: AssetImage('assets/images/Tse_logo.png'),
              width: 250,
              height: 250,
            ),
          ),
        ),
        const SizedBox(height: 40,),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(screen: 1, text: "Verificar DUI", icon: Icon(Icons.co_present_outlined, color: Color(0xff2862f5) , size: 50,),),
            SizedBox(width: 16),
            CustomButton(screen: 3, text: "Estadisticas", icon: Icon(Icons.pie_chart, color: Color(0xff2862f5) , size: 50,),),
          ],
        ),
        const SizedBox(height: 80,),
        _showGraph()
      ]),
      drawer: SideMenu(scaffoldKey: scaffoldKey),
    );
  }

  Widget _showGraph() {
    Map<String, double> dataMap = {};

    bands.forEach((band) {
      dataMap.putIfAbsent(band.name, () => band.votes.toDouble());
    });

    //if(dataMap.isEmpty) return const CircularProgressIndicator();

    return Container(
      padding: const EdgeInsets.only(top: 10),
      width: double.infinity,
      height: 250,
      child: PieChart(dataMap: dataMap)
    );   
    
  } 
}


class CustomButton extends StatelessWidget {
  final int screen;
  final String text;
  final Icon icon;
  const CustomButton({
    super.key,
    required this.screen,
    required this.text,
    required this.icon
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Material(
        color: Color.fromARGB(255, 221, 222, 224),
        child: InkWell(
          onTap: (){
            final menuItem = appMenuItems[screen];
            context.push(menuItem.link);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Column(
              children: [
                Text(text, style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
                icon
              ],
            )
          ),
        ),
      ),
    );
  }
}