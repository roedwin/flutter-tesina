
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../infraestructure/datasources/duidb_datasource.dart';


final duiInfoProvider = StateProvider((ref) => DuidbDatasource().datosDui);

