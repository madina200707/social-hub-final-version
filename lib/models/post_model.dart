class Post {
  final String id;
  final String content;
  final String username;
  final int likes;

  Post({
    required this.id,
    required this.content,
    required this.username,
    required this.likes,
  });

  factory Post.fromMap(String id, Map<String, dynamic> data) {
    return Post(
      id: id,
      content: data['content'] ?? '',
      username: data['username'] ?? 'User',
      likes: data['likes'] ?? 0,
    );
  }
}