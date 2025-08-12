import 'package:equatable/equatable.dart';

class Photo extends Equatable {
  final String id;
  final String author;
  final int width;
  final int height;
  final String downloadUrl;

  const Photo({
    required this.id,
    required this.author,
    required this.width,
    required this.height,
    required this.downloadUrl,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'],
      author: json['author'],
      width: json['width'],
      height: json['height'],
      downloadUrl: json['download_url'],
    );
  }

  @override
  List<Object?> get props => [id, author, width, height, downloadUrl];
}