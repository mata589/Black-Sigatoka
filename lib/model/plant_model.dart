import 'dart:ui';

class plant {
  final String plantname;
  final String imageUrl;
  final String backImage;
  final Color color;

  final List<String> Diseases;
  //final List<String> Disease;
  Map<String, Object> Disease = Map();
  plant({
    required this.plantname,
    required this.imageUrl,
    required this.backImage,
    required this.color,
    required this.Diseases,
  });
}
