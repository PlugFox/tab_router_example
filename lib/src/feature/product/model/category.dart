import 'package:meta/meta.dart';

typedef CategoryID = String;

@immutable
class CategoryEntity with Comparable<CategoryEntity> {
  const CategoryEntity({
    required this.parent,
    required this.id,
    required this.title,
  });

  final CategoryID? parent;
  final CategoryID id;
  final String title;

  bool get isRoot => parent == null;

  factory CategoryEntity.fromJson(Map<String, Object?> json) => CategoryEntity(
        parent: json['parent'] as CategoryID?,
        id: json['id']! as CategoryID,
        title: json['title']! as String,
      );

  Map<String, Object?> toJson() => {
        'parent': parent,
        'id': id,
        'title': title,
      };

  @override
  String toString() => 'Category('
      'parent: $parent, '
      'id: $id, '
      'title: $title'
      ')';

  @override
  int compareTo(covariant CategoryEntity other) => title.compareTo(other.title);

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other) || (other is CategoryEntity && other.id == id);
}
