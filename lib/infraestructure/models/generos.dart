
class Masculino {
  int id;
  String name;
  int votes;

  Masculino({
    required this.id,
    required this.name,
    this.votes = 0
  });

  factory Masculino.fromMap(Map<String, dynamic> obj) {
    return Masculino(
      id: obj.containsKey('id') ? obj['id'] : 'no-id', 
      name: obj.containsKey('name') ?  obj['name']: 'no-name', 
      votes: obj.containsKey('votes') ?  obj['M']: 'no-votes'
    );
  }

}

class Femenino {
  int id;
  String name;
  int votes;

  Femenino({
    required this.id,
    required this.name,
    this.votes = 0
  });

  factory Femenino.fromMap(Map<String, dynamic> obj) {
    return Femenino(
      id: obj.containsKey('id') ? obj['id'] : 'no-id', 
      name: obj.containsKey('name') ?  obj['name']: 'no-name', 
      votes: obj.containsKey('votes') ?  obj['F']: 'no-votes'
    );
  }

}