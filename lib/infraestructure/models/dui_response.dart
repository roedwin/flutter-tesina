

class DuiDbResponse {
    final int idDetalleSufragio;
    final int idPersonaNatural;
    final String? uuidInfo;
    final String? ledgerId;
    final int idJrv;
    final dynamic asistioEn;
    final String estadoVoto;
    final DateTime creadoEn;
    final DateTime modificadoEn;
    final InformacionPersonal informacionPersonal;
    final Jrv jrv;

    DuiDbResponse({
        required this.idDetalleSufragio,
        required this.idPersonaNatural,
        required this.uuidInfo,
        required this.ledgerId,
        required this.idJrv,
        required this.asistioEn,
        required this.estadoVoto,
        required this.creadoEn,
        required this.modificadoEn,
        required this.informacionPersonal,
        required this.jrv,
    });

    factory DuiDbResponse.fromJson(Map<String, dynamic> json) => DuiDbResponse(
        idDetalleSufragio: json["id_detalle_sufragio"],
        idPersonaNatural: json["id_persona_natural"],
        uuidInfo: json["uuid_info"],
        ledgerId: json["ledger_id"],
        idJrv: json["id_jrv"],
        asistioEn: json["asistio_en"],
        estadoVoto: json["estado_voto"],
        creadoEn: DateTime.parse(json["creado_en"]),
        modificadoEn: DateTime.parse(json["modificado_en"]),
        informacionPersonal: InformacionPersonal.fromJson(json["informacion_personal"]),
        jrv: Jrv.fromJson(json["jrv"]),
    );

    Map<String, dynamic> toJson() => {
        "id_detalle_sufragio": idDetalleSufragio,
        "id_persona_natural": idPersonaNatural,
        "uuid_info": uuidInfo,
        "ledger_id": ledgerId,
        "id_jrv": idJrv,
        "asistio_en": asistioEn,
        "estado_voto": estadoVoto,
        "creado_en": creadoEn.toIso8601String(),
        "modificado_en": modificadoEn.toIso8601String(),
        "informacion_personal": informacionPersonal.toJson(),
        "jrv": jrv.toJson(),
    };
}

class InformacionPersonal {
    final int idPersonaNatural;
    final String dui;
    final String nombres;
    final String apellidos;
    final String genero;
    final int idMunicipio;
    final String detalleDireccion;
    final DateTime fechaNacimiento;
    final DateTime fechaVencimientoDui;
    final DateTime creadoEn;
    final Municipio municipio;

    InformacionPersonal({
        required this.idPersonaNatural,
        required this.dui,
        required this.nombres,
        required this.apellidos,
        required this.genero,
        required this.idMunicipio,
        required this.detalleDireccion,
        required this.fechaNacimiento,
        required this.fechaVencimientoDui,
        required this.creadoEn,
        required this.municipio,
    });

    factory InformacionPersonal.fromJson(Map<String, dynamic> json) => InformacionPersonal(
        idPersonaNatural: json["id_persona_natural"],
        dui: json["dui"],
        nombres: json["nombres"],
        apellidos: json["apellidos"],
        genero: json["genero"],
        idMunicipio: json["id_municipio"],
        detalleDireccion: json["detalle_direccion"],
        fechaNacimiento: DateTime.parse(json["fecha_nacimiento"]),
        fechaVencimientoDui: DateTime.parse(json["fecha_vencimiento_dui"]),
        creadoEn: DateTime.parse(json["creado_en"]),
        municipio: Municipio.fromJson(json["municipio"]),
    );

    Map<String, dynamic> toJson() => {
        "id_persona_natural": idPersonaNatural,
        "dui": dui,
        "nombres": nombres,
        "apellidos": apellidos,
        "genero": genero,
        "id_municipio": idMunicipio,
        "detalle_direccion": detalleDireccion,
        "fecha_nacimiento": fechaNacimiento.toIso8601String(),
        "fecha_vencimiento_dui": fechaVencimientoDui.toIso8601String(),
        "creado_en": creadoEn.toIso8601String(),
        "municipio": municipio.toJson(),
    };
}

class Municipio {
    final int idMunicipio;
    final int idDepartamento;
    final String nombre;
    final Departamentos departamentos;

    Municipio({
        required this.idMunicipio,
        required this.idDepartamento,
        required this.nombre,
        required this.departamentos,
    });

    factory Municipio.fromJson(Map<String, dynamic> json) => Municipio(
        idMunicipio: json["id_municipio"],
        idDepartamento: json["id_departamento"],
        nombre: json["nombre"],
        departamentos: Departamentos.fromJson(json["departamentos"]),
    );

    Map<String, dynamic> toJson() => {
        "id_municipio": idMunicipio,
        "id_departamento": idDepartamento,
        "nombre": nombre,
        "departamentos": departamentos.toJson(),
    };
}

class Departamentos {
    final int idDepartamento;
    final String nombre;

    Departamentos({
        required this.idDepartamento,
        required this.nombre,
    });

    factory Departamentos.fromJson(Map<String, dynamic> json) => Departamentos(
        idDepartamento: json["id_departamento"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toJson() => {
        "id_departamento": idDepartamento,
        "nombre": nombre,
    };
}

class Jrv {
    final int idJrv;
    final String codigo;
    final int idCentroVotacion;
    final String estado;
    final DateTime creadoEn;
    final DateTime modificadoEn;
    final CentroVotacion centroVotacion;

    Jrv({
        required this.idJrv,
        required this.codigo,
        required this.idCentroVotacion,
        required this.estado,
        required this.creadoEn,
        required this.modificadoEn,
        required this.centroVotacion,
    });

    factory Jrv.fromJson(Map<String, dynamic> json) => Jrv(
        idJrv: json["id_jrv"],
        codigo: json["codigo"],
        idCentroVotacion: json["id_centro_votacion"],
        estado: json["estado"],
        creadoEn: DateTime.parse(json["creado_en"]),
        modificadoEn: DateTime.parse(json["modificado_en"]),
        centroVotacion: CentroVotacion.fromJson(json["centro_votacion"]),
    );

    Map<String, dynamic> toJson() => {
        "id_jrv": idJrv,
        "codigo": codigo,
        "id_centro_votacion": idCentroVotacion,
        "estado": estado,
        "creado_en": creadoEn.toIso8601String(),
        "modificado_en": modificadoEn.toIso8601String(),
        "centro_votacion": centroVotacion.toJson(),
    };
}

class CentroVotacion {
    final int idCentroVotacion;
    final int idMunicipio;
    final String nombre;
    final String direccion;
    final String estado;
    final DateTime creadoEn;
    final DateTime modificadoEn;
    final Municipio municipios;

    CentroVotacion({
        required this.idCentroVotacion,
        required this.idMunicipio,
        required this.nombre,
        required this.direccion,
        required this.estado,
        required this.creadoEn,
        required this.modificadoEn,
        required this.municipios,
    });

    factory CentroVotacion.fromJson(Map<String, dynamic> json) => CentroVotacion(
        idCentroVotacion: json["id_centro_votacion"],
        idMunicipio: json["id_municipio"],
        nombre: json["nombre"],
        direccion: json["direccion"],
        estado: json["estado"],
        creadoEn: DateTime.parse(json["creado_en"]),
        modificadoEn: DateTime.parse(json["modificado_en"]),
        municipios: Municipio.fromJson(json["municipios"]),
    );

    Map<String, dynamic> toJson() => {
        "id_centro_votacion": idCentroVotacion,
        "id_municipio": idMunicipio,
        "nombre": nombre,
        "direccion": direccion,
        "estado": estado,
        "creado_en": creadoEn.toIso8601String(),
        "modificado_en": modificadoEn.toIso8601String(),
        "municipios": municipios.toJson(),
    };
}
