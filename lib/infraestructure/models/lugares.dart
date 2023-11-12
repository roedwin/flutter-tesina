
class Departamento {
  int id;
  String name;
  int votes;

  Departamento({
    required this.id,
    required this.name,
    this.votes = 0
  });

  factory Departamento.fromMap(Map<String, dynamic> obj) {
    return Departamento(
      id: obj.containsKey('id') ? obj['id'] : 'no-id', 
      name: obj.containsKey('name') ?  obj['name']: 'no-name', 
      votes: obj.containsKey('votes') ?  obj['M']: 'no-votes'
    );
  }

}