import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shake_count_app/services/board_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BoardListPage extends StatefulWidget {
  @override
  _BoardListPageState createState() => _BoardListPageState();
}

class _BoardListPageState extends State<BoardListPage> {
  late final BoardService _boardService;
  late Future<List<Map<String, dynamic>>> _postsFuture;

  @override
  void initState() {
    super.initState();
    _boardService = BoardService(Supabase.instance.client);
    _postsFuture = _boardService.fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('게시글 목록'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _postsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('오류: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('게시글이 없습니다.'));
          } else {
            final posts = snapshot.data!;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return ListTile(
                  title: Text(post['title'] ?? '제목 없음'),
                  subtitle: Text(
                    // post['body'] ?? '내용 없음', //작동안함 확인, 아래 삼항연산자로 대체함
                    post['body'] != null && post['body'].isNotEmpty
                        ? post['body']
                        : '내용 없음',
                    maxLines: 1, // 최대 1줄까지만 표시
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () {
                    print(post);
                    final postId = post['id'];
                    context.go('/detail/$postId');
                    // 게시글 상세 페이지로 이동하는 로직 추가 가능 (아직 화면 없음)

                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/create');
        },
        child: Icon(Icons.add),
        tooltip: '게시글 작성',
      ),
    );
  }
}
