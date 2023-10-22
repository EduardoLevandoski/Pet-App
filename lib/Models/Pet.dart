class Pet {
  int petCod;
  String petNome;
  String? petImgUrl;
  DateTime? petIdade;
  String? petSexo;
  String? petEspecie;
  String? petRaca;
  String? petPeso;
  String? petCor;

  Pet({
    required this.petCod,
    required this.petNome,
    this.petImgUrl,
    this.petIdade,
    this.petSexo,
    this.petEspecie,
    this.petRaca,
    this.petPeso,
    this.petCor,
  });
}
