import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shake_count_app/router.dart';
import 'package:shake_count_app/services/board_service.dart';
import 'package:shake_count_app/view/board_form_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'view/my_home_page.dart';


void main() async {
  // Flutter 프레임워크가 초기화되기 전에 비동기 작업을 수행할 수 있도록 보장
  WidgetsFlutterBinding.ensureInitialized();

  // .env 파일 로드
  await dotenv.load(fileName: ".env");

  // 환경 변수에서 URL과 키를 가져오기
  final supabaseUrl = dotenv.env['SBASE_URL'];
  final supabaseAnonKey = dotenv.env['SBASE_KEY'];

  // URL과 키가 null인지 확인하여 오류 방지
  if (supabaseUrl == null || supabaseAnonKey == null) {
    throw Exception('Supabase URL 또는 익명 키가 설정되지 않았습니다.');
  }

  // Supabase 초기화
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final BoardService boardService = BoardService(Supabase.instance.client);

    return MaterialApp.router(
      routerConfig: router,

      // home: const MyHomePage(title: '흔들기 카운트 앱'),
      // home: BoardCreatePage(),
    );
  }
}
