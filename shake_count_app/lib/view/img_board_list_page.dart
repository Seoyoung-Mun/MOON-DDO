import 'package:flutter/material.dart';

// 샘플 게시글 데이터 리스트
class ImgBoardListPage extends StatelessWidget {
  // 샘플 게시글 데이터 리스트
  final List<Map<String, String>> posts = [
    {
      'title': '첫 번째 게시글',
      'imageUrl':
          'https://wwfavizlmoqhhdpiwbgb.supabase.co/storage/v1/object/public/memories/image/cat.jpeg',
    },
    {
      'title': '두 번째 게시글',
      'imageUrl':
          'https://wwfavizlmoqhhdpiwbgb.supabase.co/storage/v1/object/public/memories/image/cat.jpeg',
    },
    {
      'title': '세 번째 게시글',
      'imageUrl':
          'https://wwfavizlmoqhhdpiwbgb.supabase.co/storage/v1/object/public/memories/image/cat.jpeg',
    },
    {
      'title': '네 번째 게시글',
      'imageUrl':
          'https://wwfavizlmoqhhdpiwbgb.supabase.co/storage/v1/object/public/memories/image/cat.jpeg',
    },
    {
      'title': '다섯 번째 게시글',
      'imageUrl':
      'https://wwfavizlmoqhhdpiwbgb.supabase.co/storage/v1/object/public/memories/image/cat.jpeg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('게시판 목록'),
      ),
      body: GridView.builder(
        //ListView.builder 대신 GridView.builder를 사용하여 격자형 레이아웃을 구현
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          // 격자 레이아웃을 위한 SliverGridDelegate
          crossAxisCount: 2, // 한 줄에 2개의 아이템
          crossAxisSpacing: 10, // 아이템 간의 가로 간격
          mainAxisSpacing: 10, // 아이템 간의 세로 간격
          childAspectRatio: 3 / 4, // 아이템의 가로 세로 비율
        ),
        itemCount: posts.length,
        padding: EdgeInsets.all(10),
        itemBuilder: (context, index) {
          final post = posts[index];
          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  post['imageUrl']!,
                  width: double.infinity,
                  height: 160,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      post['title']!,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
