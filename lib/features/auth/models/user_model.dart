import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 5)
class UserModel {
  @HiveField(0)
  String name;

  @HiveField(7)
  String image;

  UserModel({
    required this.name,
    required this.image,
  });
}
