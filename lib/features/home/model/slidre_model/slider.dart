class Slider {
  String? image;

  Slider({this.image});

  factory Slider.fromJson(Map<String, dynamic> json) {
    return Slider(
      image: json['image'] as String?,
    );
  }
}
