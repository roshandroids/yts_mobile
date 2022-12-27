import 'package:flutter_test/flutter_test.dart';
import 'package:yts_mobile/features/auth/auth.dart';

void main() {
  const rawUserData = {
    'email': 'roshan@gmail.com',
    'userId': 'xyz123asd',
    'emailVerified': false,
  };
  const userDataObject = UserModel(
    email: 'roshan@gmail.com',
    userId: 'xyz123asd',
    emailVerified: false,
  );
  group(
    'Test for user info model',
    () {
      test(
        'can parse data to  user model fromJson',
        () async {
          expect(
            UserModel.fromJson(rawUserData),
            equals(userDataObject),
          );
        },
      );
      test('can convert user data model toJson', () {
        expect(userDataObject.toJson(), rawUserData);
      });
    },
  );
}
