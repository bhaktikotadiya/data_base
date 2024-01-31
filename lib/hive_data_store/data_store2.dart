import 'package:hive/hive.dart';
part 'data_store2.g.dart';

@HiveType(typeId: 0)
class adapter extends HiveObject
{
  @HiveField(0)
  String name;

  @HiveField(1)
  String contact;

  adapter(this.name,this.contact);

  @override
  String toString() {
    return 'adapter{name: $name, contact: $contact}';
  }
}