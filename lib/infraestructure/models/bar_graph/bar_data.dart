
import 'package:proyecto_tesina/infraestructure/models/bar_graph/individual_bar.dart';

class BarData {

  final List data;

  BarData({
    required this.data
  });

  List<IndividualBar> barData = [];

  void initialBarData() {
    barData = [
      //data.forEach((element) { })
    ];
  }

}