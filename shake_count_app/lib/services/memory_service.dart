import 'package:supabase_flutter/supabase_flutter.dart';

class MemoryService {
  final _client = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getMemories() async {
    final response = await _client
        .from('memories')
        .select('id, title, created_at, image_id')
        .order('created_at', ascending: true);



    // 데이터 반환
    return List<Map<String, dynamic>>.from(response);
  }
}