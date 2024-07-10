import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_and_healty_app/userData.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Community extends StatefulWidget {
  const Community({Key? key}) : super(key: key);

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  List<Map<String, dynamic>> posts = [];
  Map<String, List<Map<String, dynamic>>> replies =
      {}; // Use post ID as key instead of index
  TextEditingController postController = TextEditingController();
  TextEditingController replyController = TextEditingController();
  bool show = false;
  UserData _userData = UserData();
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await _userData.loadUserData();
    setState(() {});
  }

  final CollectionReference postsCollection =
      FirebaseFirestore.instance.collection('posts');
  final CollectionReference repliesCollection =
      FirebaseFirestore.instance.collection('replies');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'Community',
            style: GoogleFonts.alike(
              fontSize: 28,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: postsCollection.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                // Convert Firestore data to List<Map<String, dynamic>>
                posts = snapshot.data!.docs.map((DocumentSnapshot document) {
                  return {
                    'id': document.id,
                    'post': document['post'] ?? '',
                    'userName': document['userName'] ?? '',
                    'userImage': document['userImage'] ?? '',
                    // Add more fields as needed
                  };
                }).toList();

                return ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    return buildPostCard(index, posts[index]);
                  },
                );
              },
            ),
          ),
          buildPostInputField(),
        ],
      ),
    );
  }

  // Widget to build post card
  Widget buildPostCard(int index, Map<String, dynamic> postData) {
    String postId = postData['id'];
    String userName = postData['userName'];
    String userImage = postData['userImage'];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.33),
              spreadRadius: 0,
              blurRadius: 0,
              offset: Offset(1, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(100),
                      image: DecorationImage(
                        image: userImage.isNotEmpty
                            ? NetworkImage(userImage)
                            : AssetImage('assets/images/profile1.png')
                                as ImageProvider,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 7),
                    child: Text(
                      userName,
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                postData['post'],
                style: TextStyle(fontSize: 17),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        show = !show;
                        if (show) {
                          loadReplies(postId);
                        } else {
                          replies.remove(postId);
                        }
                      });
                    },
                    child: Text(
                      show ? 'Hide Replies' : 'Show Replies',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (show && replies.containsKey(postId))
              ...replies[postId]!.map((reply) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.85),
                          spreadRadius: 0,
                          blurRadius: 0,
                          offset: Offset(1, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        reply['text'],
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                    ),
                  ),
                );
              }).toList(),
            buildReplyField(postId),
          ],
        ),
      ),
    );
  }

  // Widget to build post input field
  Widget buildPostInputField() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: postController,
              decoration: InputDecoration(
                hintText: 'Write your post...',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: Colors.black54),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: Colors.black54),
                ),
              ),
            ),
          ),
          SizedBox(width: 8.0),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.black87),
            ),
            onPressed: () {
              if (postController.text.isNotEmpty) {
                addPostToFirestore(postController.text);
                postController.clear();
              }
            },
            child: Text(
              'Post',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // Widget to build reply field
  Widget buildReplyField(String postId) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: replyController,
              decoration: InputDecoration(
                hintText: 'Write your reply...',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: Colors.black54),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: Colors.black54),
                ),
              ),
            ),
          ),
          SizedBox(width: 8.0),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.black87),
            ),
            onPressed: () {
              if (replyController.text.isNotEmpty) {
                addReplyToFirestore(postId, replyController.text);
                replyController.clear();
              }
            },
            child: Text(
              'Reply',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // Function to add post to Firestore
  Future<void> addPostToFirestore(String postText) async {
    try {
      await postsCollection.add({
        'post': postText,
        'userId': FirebaseAuth.instance.currentUser!.uid,
        'userName': _userData.name,
        'userImage': _userData.imageUrl,
        // Add more fields as needed
      });
      print('Post added to Firestore: $postText');
    } catch (e) {
      print('Error adding post to Firestore: $e');
    }
  }

  // Function to load replies from Firestore
  void loadReplies(String postId) {
    replies[postId] = [];

    repliesCollection
        .where('post_id', isEqualTo: postId)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        replies[postId]!.add({
          'text': doc['text'],
          // Add more fields as needed
        });
      });
      setState(() {
        // Trigger rebuild to show replies
      });
    }).catchError((error) {
      print('Error loading replies: $error');
    });
  }

  // Function to add reply to Firestore
  Future<void> addReplyToFirestore(String postId, String replyText) async {
    try {
      await repliesCollection.add({
        'post_id': postId,
        'text': replyText,
        // Add more fields as needed
      });

      setState(() {
        if (!replies.containsKey(postId)) {
          replies[postId] = [];
        }
        replies[postId]!.add({
          'text': replyText,
          // Add more fields as needed
        });
      });

      print('Reply added to Firestore: $replyText');
    } catch (e) {
      print('Error adding reply to Firestore: $e');
    }
  }
}
