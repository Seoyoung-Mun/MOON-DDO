import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shake_count_app/router.dart';
import 'package:shake_count_app/services/board_service.dart';
import 'package:shake_count_app/view/board_create_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'view/my_home_page.dart';


void main() async {
  // Flutter 프레임워크가 초기화되기 전에 비동기 작업을 수행할 수 있도록 보장
  WidgetsFlutterBinding.ensureInitialized();

  // .env 파일 로드
  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.get("SBASE_URL"),
    anonKey: dotenv.get("SBASE_URL"),
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
