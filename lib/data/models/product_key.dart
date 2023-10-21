class ProductKey{
  String title;
  String img;
  int id;

  ProductKey({required this.title ,required this.img , required this.id});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProductKey && other.title == title && other.img == img && other.id==other.id;
  }

  @override
  int get hashCode => title.hashCode ^ img.hashCode;

}