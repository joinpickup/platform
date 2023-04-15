part of 'middleware.dart';

// create classes
class RegistryItem {
  String name;
  int id;
  String endpoint;

  RegistryItem({
    required this.name,
    required this.id,
    required this.endpoint,
  });

  factory RegistryItem.fromJson(Map<String, dynamic> json) {
    return RegistryItem(
      name: json['name'],
      id: json['id'],
      endpoint: json['endpoint'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['endpoint'] = endpoint;
    return data;
  }
}
