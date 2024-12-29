import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class BoardCreatePage extends StatefulWidget {
  @override
  _BoardCreatePageState createState() => _BoardCreatePageState();
}

class _BoardCreatePageState extends State<BoardCreatePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  void _createPost() {
    if (_formKey.currentState!.validate()) {
      String title = _titleController.text;
      String body = _bodyController.text;

      // 여기서 작성된 게시글을 처리합니다.
      // 예를 들어, 서버에 전송하거나 로컬 상태에 저장할 수 있습니다.

      // 입력 필드 초기화
      _titleController.clear();
      _bodyController.clear();

      // 사용자에게 성공 메시지 표시
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('게시글이 생성되었습니다.')),
      );
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '내용을 입력하세요.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: (){},
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
