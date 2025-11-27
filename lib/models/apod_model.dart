import 'dart:convert';

class ApodModel {
  final String date;
  final String title;
  final String explanation;
  final String url;
  final String mediaType;

  ApodModel({
    required this.date,
    required this.title,
    required this.explanation,
    required this.url,
    required this.mediaType,
  });

  factory ApodModel.fromJson(Map<String, dynamic> json) {
    return ApodModel(
      date: json['date'] ?? '',
      title: json['title'] ?? 'Sem título',
      explanation: json['explanation'] ?? 'Sem descrição.',
      url: json['url'] ?? '',
      mediaType: json['media_type'] ?? 'image',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'title': title,
      'explanation': explanation,
      'url': url,
      'media_type': mediaType,
    };
  }

  static String encode(List<ApodModel> apods) => json.encode(
    apods.map<Map<String, dynamic>>((apod) => apod.toJson()).toList(),
  );

  static List<ApodModel> decode(String apods) =>
      (json.decode(apods) as List<dynamic>)
          .map<ApodModel>((item) => ApodModel.fromJson(item))
          .toList();
}
