

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_tesina/infraestructure/datasources/duidb_datasource.dart';

final httpStatusProvider = StateNotifierProvider<HttpStatus,bool>((ref) {
  return HttpStatus();
});

class HttpStatus extends StateNotifier<bool> {
  HttpStatus():super(DuidbDatasource().isGood);  
}