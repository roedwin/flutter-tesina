
class Departamento {
  int id;
  String name;
  int votes;

  Departamento({
    required this.id,
    required this.name,
    this.votes = 0
  });

  factory Departamento.fromMap(Map<String, dynamic> obj, String dep) {
    // Buscar el nombre en el arreglo dep y obtener su _count
    int count = 0; // Valor predeterminado si no se encuentra el nombre
    if (obj.containsKey('dep')) {
      List<dynamic> departamentos = obj['dep'];
      for (var departamento in departamentos) {
        if (departamento.containsKey('nombre') && departamento['nombre'] == dep) {
          count = departamento.containsKey('_count') ? (departamento['_count'] as int) : 0;
          break; // Salir del bucle una vez que se encuentra el nombre
        }
      }
    }

    // Crear la instancia de Departamento
    return Departamento(
      id: obj.containsKey('id') ? obj['id'] : 'no-id',
      name: obj.containsKey('name') ? obj['name'] : 'no-name',
      votes: obj.containsKey('votes') ? count : 0, // Usar el count obtenido
    );
  }

}

