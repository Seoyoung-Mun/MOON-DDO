import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shake_count_app/services/board_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BoardCreatePage extends StatefulWidget {
  final int? postId; // null이면 생성 모드, 값이 있으면 수정 모드

  BoardCreatePage({Key? key, this.postId}) : super(key: key);

  @override
  _BoardCreatePageState createState() => _BoardCreatePageState();
}

class _BoardCreatePageState extends State<BoardCreatePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  late final BoardService _boardService;
  bool _isLoading = false;

  // @override
  // void initState() {
  //   super.initState();
  //   _boardService = BoardService(Supabase.instance.client);
  //   if (widget.postId != null) {
  //     _loadPostData();
  //   }
  // }

  void _createPost() {
    try {
      if (_formKey.currentState!.validate()) {
        String title = _titleController.text;
        String body = _bodyController.text;

        _boardService = BoardService(Supabase.instance.client); // BoardService 인스턴스 생성 후 Supabase client 전달
        _boardService.createPost(title, body);

        // 입력 필드 초기화
        _titleController.clear();
        _bodyController.clear();

        // 사용자에게 성공 메시지 표시
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('게시글이 생성되었습니다.')),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('게시글 작성'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: '제목',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '제목을 입력하세요.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _bodyController,
                decoration: InputDecoration(
                  labelText: '내용',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return '내용을 입력하세요.';
                //   }
                //   return null;
                // },
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.go('/');
                    },
                    child: Text('게시글 목록'),
                  ),
                  ElevatedButton(
                    onPressed: _createPost,
                    child: Text('Create'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
