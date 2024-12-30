import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shake_count_app/services/board_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BoardDetailPage extends StatelessWidget {
  final int postId;
  final BoardService _boardService = BoardService(Supabase.instance.client);

  BoardDetailPage({Key? key, required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('게시글 상세보기'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _boardService.fetchPost(postId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('오류: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('게시글을 찾을 수 없습니다.'));
          } else {
            final post = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post['title'] ?? '제목 없음',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '작성일: ${post['created_at'] ?? '알 수 없음'}',
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 16),
                  Text(
                    post['body'] != null && post['body'].isNotEmpty
                        ? post['body']
                        : '내용 없음',
                  ),
                ],
              ),
            );
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: () {
                  context.go('/');
                },
                icon: Icon(Icons.list),
                label: Text('목록으로'),
              ),
              TextButton.icon(
                onPressed: () {
                  // 수정 페이지로 이동하는 로직 추가
                  context.go('/edit/$postId');
                },
                icon: Icon(Icons.edit),
                label: Text('수정'),
              ),
              TextButton.icon(
                onPressed: () {},
                // onPressed: () => _deletePost(context),
                icon: Icon(Icons.delete),
                label: Text('삭제'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
