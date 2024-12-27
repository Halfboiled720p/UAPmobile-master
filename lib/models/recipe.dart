class Recipe {
  final String id;
  final String title;
  final String portion;
  final String duration;
  final String story;
  final String imageUrl;

  Recipe({
    required this.id,
    required this.title,
    required this.portion,
    required this.duration,
    required this.story,
    required this.imageUrl,
  });

  // Metode untuk mengonversi ke format Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'portion': portion,
      'duration': duration,
      'story': story,
      'image': imageUrl,
      'created_at': DateTime.now(), // Timestamp untuk waktu pembuatan
    };
  }

  // Metode untuk membuat objek Recipe dari snapshot Firestore
  factory Recipe.fromFirestore(String id, Map<String, dynamic> data) {
    return Recipe(
      id: id,
      title: data['title'] ?? '',
      portion: data['portion'] ?? '',
      duration: data['duration'] ?? '',
      story: data['story'] ?? '',
      imageUrl: data['image'] ?? '',
    );
  }
}
