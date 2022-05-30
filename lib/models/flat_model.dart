class FlatModel {
  FlatModel({required this.id, required this.name, required this.isCheck});

  int id;
  String name;
  bool isCheck;

  @override
  String toString() {
    return 'id:$id name:$name isCheck:$isCheck';
  }
}
