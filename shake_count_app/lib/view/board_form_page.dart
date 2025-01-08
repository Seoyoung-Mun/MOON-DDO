import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shake_count_app/services/board_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BoardFormPage extends StatefulWidget {
  final int? postId; // null이면 생성 모드, 값이 있으면 수정 모드

  BoardFormPage({Key? key, this.postId}) : super(key: key);

  @override
  _BoardFormPageState createState() => _BoardFormPageState();
}

class _BoardFormPageState extends State<BoardFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  late final BoardService _boardService;
  // bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _boardService = BoardService(Supabase.instance.client);
    if (widget.postId != null) {
      _loadPostData();
    }
  }

  Future<void> _loadPostData() async {
    try {
      final post = await _boardService.fetchPost(widget.postId!);
      _titleController.text = post['title'] ?? '';
      _bodyController.text = post['body'] ?? '';
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('게시글을 불러오지 못했습니다: $e')),
      );
    }
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      try {
        if (widget.postId == null) {
          // 생성 모드
          await _boardService.createPost(
            _titleController.text,
            _bodyController.text,
          );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('게시글이 생성되었습니다.')),
          );
        } else {
          // 수정 모드
          await _boardService.updatePost(
            widget.postId!,
            _titleController.text,
            _bodyController.text,
          );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('게시글이 수정되었습니다.')),
          );
        }
        context.go('/');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('오류가 발생했습니다: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.postId == null ? '게시글 작성' : '게시글 수정'),
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
                    onPressed: _submit,
                    child: Text(widget.postId == null ? '생성' : '수정'),
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
