
class Partido {
  String id;
  String name;
  int votes;

  Partido({
    required this.id,
    required this.name,
    this.votes = 0
  });

  factory Partido.fromMap(Map<String, dynamic> obj) {
    return Partido(
      id: obj.containsKey('id') ? obj['id'] : 'no-id', 
      name: obj.containsKey('name') ?  obj['name']: 'no-name', 
      votes: obj.containsKey('votes') ?  obj['votes']: 'no-votes'
    );
  }

}