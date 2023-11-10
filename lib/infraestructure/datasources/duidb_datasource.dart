
import 'package:dio/dio.dart';

import 'package:proyecto_tesina/domain/datasources/dui_datasource.dart';
import 'package:proyecto_tesina/domain/entities/dui.dart';
import 'package:proyecto_tesina/infraestructure/models/dui_response.dart';



class DuidbDatasource extends DuiDatasource{
  final dio = Dio(BaseOptions(
    baseUrl: 'https://cloudiqinnovations.link/api/v1/destino-sufragio/dui/',
  ));

  Dui? datosDui;

  @override
  Future getData(String dui) async{
    
    final response = await dio.get(dui);
    final duiDBResponse = DuiDbResponse.fromJson(response.data);
    datosDui = Dui(
      id: duiDBResponse.idPersonaNatural.toString(), 
      dui: duiDBResponse.informacionPersonal.dui, 
      nombre: duiDBResponse.informacionPersonal.nombres + duiDBResponse.informacionPersonal.apellidos, 
      departamento: duiDBResponse.informacionPersonal.municipio.departamentos.nombre, 
      municipio: duiDBResponse.informacionPersonal.municipio.nombre,
      centrodevotacion: duiDBResponse.jrv.centroVotacion.nombre, 
      direccion: duiDBResponse.jrv.centroVotacion.direccion, 
      jrv: duiDBResponse.jrv.codigo, 
      correlativo: duiDBResponse.jrv.idJrv.toString()
    );

    //print(datosDui?.nombre);

    return datosDui;
  }

}