import 'package:equatable/equatable.dart';

class ArticleEntity extends Equatable {
  const ArticleEntity({
    required this.articleType,
    required this.id,
    required this.header,
    required this.category,
    required this.description,
    required this.image,
    required this.dateShow,
    required this.externalLink,
    required this.show,
    required this.userCreated,
    required this.dateCreated,
    required this.userUpdate,
    required this.dateUpdated,
  });

  final String id;
  final ArticleTypeEntity articleType;
  final String header;
  final String category;
  final String description;
  final String image;
  final DateTime dateShow;
  final String externalLink;
  final bool show;
  final String userCreated;
  final DateTime dateCreated;
  final String userUpdate;
  final DateTime dateUpdated;

  @override
  List<Object?> get props => [
        articleType,
        id,
        header,
        category,
        description,
        image,
        dateShow,
        externalLink,
        show,
        userCreated,
        dateCreated,
        userUpdate,
        dateUpdated,
      ];
}

class ArticleTypeEntity extends Equatable {
  const ArticleTypeEntity({
    required this.id,
    required this.code,
    required this.description,
  });

  final String id;
  final String code;
  final String description;

  @override
  List<Object?> get props => [id, code, description];
}
