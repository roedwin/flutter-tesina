
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_tesina/infraestructure/models/generos.dart';
import 'package:proyecto_tesina/infraestructure/models/partidos.dart';
import 'package:proyecto_tesina/presentation/providers/graficos/grafico_provider.dart';

class MyWidgetGraph extends StatelessWidget {
  final BarTouchData barTouchData;
  final FlTitlesData titlesData;
  final FlBorderData borderData;
  final List<BarChartGroupData> barGroups;
  final int ref;
  const MyWidgetGraph(
      {super.key,
      required this.barTouchData,
      required this.titlesData,
      required this.borderData,
      required this.barGroups,
      required this.ref});

  @override
  Widget build(BuildContext context) {
    return BarChart(BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        gridData: const FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        maxY: ref.toDouble()+1));
  }
}

class BarChartSample extends ConsumerStatefulWidget {
  const BarChartSample({super.key});

  @override
  BarChartSampleState createState() => BarChartSampleState();
}

class BarChartSampleState extends ConsumerState<BarChartSample> {
  @override
  Widget build(BuildContext context) {
    List<Partido> bands = ref.watch(datosProvider);
    int totalVotes = 0;
    for (var partido in bands) {
      totalVotes += partido.votes;
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AspectRatio(
        aspectRatio: 2,
        child: MyWidgetGraph(
          barTouchData: barTouchData,
          titlesData: titlesData,
          borderData: borderData,
          barGroups: barGroups,
          ref: totalVotes,
        ),
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
      enabled: false,
      touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
                rod.toY.toString(),
                const TextStyle(
                    color: Colors.cyan, fontWeight: FontWeight.bold));
          }));

  Widget geTitles(double value, TitleMeta meta) {
    final style = TextStyle(
        color: Colors.blueAccent, fontWeight: FontWeight.bold, fontSize: 14);
    String text;
    List<Femenino> bands = ref.watch(femeninasProvider);
    if (value.toInt() >= 0 && value.toInt() < bands.length) {
      text = bands[value.toInt()].name;
    } else {
      text = '';
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(
        text,
        style: style,
      ),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
            sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          getTitlesWidget: geTitles,
        )),
        leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles:
            const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      );

  FlBorderData get borderData => FlBorderData(
        show: true,
      );

  LinearGradient get _barsGradient => const LinearGradient(
      colors: [Colors.blueAccent, Colors.pinkAccent],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter);

  List<BarChartGroupData> get barGroups {
    List<Femenino> bands = ref.watch(femeninasProvider);

    // Crear una lista de BarChartGroupData utilizando datos de la lista bands.
    List<BarChartGroupData> result = [];
    for (var i = 0; i < bands.length; i++) {
      result.add(BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(toY: bands[i].votes.toDouble(), gradient: _barsGradient, width: 35, borderRadius: BorderRadius.zero)
        ],
        showingTooltipIndicators: [0],
      ));
    }
    return result;
  }

}
