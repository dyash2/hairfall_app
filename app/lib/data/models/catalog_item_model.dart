class CatalogItem {
  final String id;
  final String name;
  final String type;
  final String copy;
  final List<String> warnings;

  CatalogItem({
    required this.id,
    required this.name,
    required this.type,
    required this.copy,
    required this.warnings,
  });

  factory CatalogItem.fromJson(Map<String, dynamic> json) {
    return CatalogItem(
      id: json["_id"],
      name: json["name"],
      type: json["type"],
      copy: json["copy"],
      warnings: List<String>.from(json["warnings"] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "name": name,
      "type": type,
      "copy": copy,
      "warnings": warnings,
    };
  }
}
