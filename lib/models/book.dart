class Book {
  final int? id;
  final String title;
  final String author;
  final int rating;
  final bool read;
  final bool isFavorite;

  Book({
    this.id,
    required this.title,
    required this.author,
    required this.rating,
    required this.read,
    this.isFavorite = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'rating': rating,
      'read': read ? 1 : 0,
      'isFavorite': isFavorite ? 1 : 0,
    };
  }

  static Book fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'],
      title: map['title'],
      author: map['author'],
      rating: map['rating'],
      read: map['read'] == 1,
      isFavorite: map['isFavorite'] == 1,
    );
  }
}
