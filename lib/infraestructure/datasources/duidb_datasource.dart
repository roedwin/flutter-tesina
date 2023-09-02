
import 'package:dio/dio.dart';

import 'package:proyecto_tesina/domain/datasources/dui_datasource.dart';
import 'package:proyecto_tesina/domain/entities/dui.dart';
import 'package:proyecto_tesina/infraestructure/models/dui_response.dart';

class DuidbDatasource extends DuiDatasource{
  final dio = Dio(BaseOptions(
    baseUrl: 'http://10.0.2.2:8000/posts/dui/',
  ));

  Dui? datosDui;

  @override
  Future getData(String dui) async{
    
    final response = await dio.get(dui);
    final duiDBResponse = DuiDbResponse.fromJson(response.data);
    datosDui = Dui(
      id: duiDBResponse.id, 
      dui: duiDBResponse.dui, 
      nombre: duiDBResponse.nombre, 
      departamento: duiDBResponse.departamento, 
      municipio: duiDBResponse.municipio,
      centrodevotacion: duiDBResponse.centroDeVotacion, 
      direccion: duiDBResponse.direccion, 
      jrv: duiDBResponse.jrv, 
      correlativo: duiDBResponse.correlativo
    );

    print(datosDui?.nombre);

    return datosDui;
  }

}