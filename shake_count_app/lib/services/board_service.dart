import 'package:supabase_flutter/supabase_flutter.dart';

class BoardService {
  final SupabaseClient _client;

  BoardService(this._client);

  // 게시글 생성
  Future<void> createPost(String title, String body) async {
    try {
      await _client.from('board').insert({
        'title': title,
        'body': body,
        'created_at': DateTime.now().toIso8601String(),
      });
    } catch (error) {
      throw Exception('게시글 생성에 실패했습니다: $error');
    }
  }

  // 게시글 목록 조회
  Future<List<Map<String, dynamic>>> fetchPosts() async {
    try {
      final response = await _client
          .from('board')
          .select()
          .order('created_at', ascending: false); // 내림차순

      // 응답이 null이거나 비어있는지 확인
      if (response == null || response.isEmpty) {
        throw Exception('게시글 불러오기에 실패했습니다: 응답이 비어있습니다.');
      }

      return List<Map<String, dynamic>>.from(response);
    } catch (error) {
      throw Exception('게시글 불러오기에 실패했습니다: $error');
    }
  }

  // 게시글 상세보기
  Future<Map<String, dynamic>> fetchPost(int id) async {
    try {
      final response =
          await _client.from('board').select().eq('id', id).single();

      if (response == null) {
        throw Exception('게시글을 불러오지 못했습니다.');
      }

      return response;
    } catch (error) {
      throw Exception('게시글 불러오기에 실패했습니다: $error');
    }
  }

  // 게시글 수정
  Future<void> updatePost(int id, String title, String body) async {
    try {
      final response = await _client.from('board').update({
        'title': title,
        'body': body,
        // 'updated_at': DateTime.now().toIso8601String(),
      }).eq('id', id);

      // Supabase는 에러를 response.error로 반환하므로 확인
      if (response.error != null) {
        throw Exception('게시글 수정에 실패했습니다: ${response.error!.message}');
      }
    } catch (error) {
      throw Exception('게시글 수정 중 오류가 발생했습니다: $error');
    }
  }

  // 게시글 삭제
  Future<void> deletePost(int id) async {
    try {
      final response = await _client
          .from('board')
          .delete()
          .eq('id', id); //.eq 메서드는 supabase의 필터링 메서드, 'id' 컬럼이 지정된 id 값과 동일한 행만 대상으로 함

      // Supabase는 에러를 response.error로 반환하므로 확인
      if (response.error != null) {
        throw Exception('게시글 삭제에 실패했습니다: ${response.error!.message}');
      }
    } catch (error) {
      throw Exception('게시글 삭제 중 오류가 발생했습니다: $error');
    }
  }
}
