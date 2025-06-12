import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

void main() async {
  await dotenv.load(fileName: '.env');

  KakaoSdk.init(
    nativeAppKey: dotenv.get('KAKAO_NATIVE_APP_KEY'),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'Pretendard',
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void KakaoLogin() async {
    try {
      // 카카오톡 실행 가능 여부 확인
      if (await isKakaoTalkInstalled()) {
        print("카카오톡 있음 - 카카오톡 앱으로 로그인 시도");
        try {
          // 카카오톡 앱으로 로그인
          OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
          print('카카오톡으로 로그인 성공: $token');
          // 로그인 성공 후 처리 로직 추가
          await _handleLoginSuccess(token);
        } catch (error) {
          print('카카오톡으로 로그인 실패: $error');

          // 사용자가 로그인을 취소한 경우
          if (error is PlatformException && error.code == 'CANCELED') {
            print('사용자가 로그인을 취소했습니다.');
            return;
          }

          // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인 시도
          print('카카오계정으로 로그인 재시도');
          await _loginWithKakaoAccount();
        }
      } else {
        print("카카오톡 없음 - 카카오계정으로 로그인");
        await _loginWithKakaoAccount();
      }
    } catch (error) {
      print('카카오 로그인 전체 실패: $error');
    }
  }

  // 카카오계정으로 로그인하는 별도 함수
  Future<void> _loginWithKakaoAccount() async {
    try {
      OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
      print('카카오계정으로 로그인 성공: $token');
      await _handleLoginSuccess(token);
    } catch (error) {
      print('카카오계정으로 로그인 실패: $error');
    }
  }

// 로그인 성공 후 처리 함수
  Future<void> _handleLoginSuccess(OAuthToken token) async {
    try {
      // 사용자 정보 가져오기
      User user = await UserApi.instance.me();
      print('사용자 정보: ${user.toString()}');

      // 여기에 로그인 성공 후 필요한 로직 추가
      // 예: 토큰 저장, 화면 이동 등

    } catch (error) {
      print('사용자 정보 가져오기 실패: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                KakaoLogin();
              },
              child: Text('KAKAO LOGIN TEST'),
            ),
          ),
        ],
      ),
    );
  }
}
