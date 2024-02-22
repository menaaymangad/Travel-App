import '../views/social_login.dart';
import '../shared/network/local/cach_helper.dart';
import 'components.dart';

void signOut(context) {
  CachHelper.removeData(
    key: 'uId',
  ).then((value) {
    if (value) {
      navigateAndfinish(
        context,
        LoginScreen(),
      );
    }
  });
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String uId = '';
