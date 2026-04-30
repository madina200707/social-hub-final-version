import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/post_model.dart';

class PostCubit extends Cubit<List<Post>> {
  PostCubit() : super([]);

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> fetchPosts() async {
    final snapshot = await _firestore
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .get();

    final posts = snapshot.docs
        .map((doc) => Post.fromMap(doc.id, doc.data()))
        .toList();

    emit(posts);
  }

  Future<void> addPost(String content) async {
    final user = FirebaseAuth.instance.currentUser;

    await _firestore.collection('posts').add({
      'userId': user?.uid ?? '',
      'username': user?.email ?? 'User',
      'content': content,
      'createdAt': FieldValue.serverTimestamp(),
      'likes': 0,
    });

    await fetchPosts();
  }

  Future<void> likePost(String id, int currentLikes) async {
    await _firestore.collection('posts').doc(id).update({
      'likes': currentLikes + 1,
    });

    await fetchPosts();
  }
}