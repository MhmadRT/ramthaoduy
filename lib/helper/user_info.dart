import '../screens/loginscreen/model/login_response.dart';

LoginResponse? loginResponse;
UserRole? userRole;

bool iSAuditor() {
  if (userRole?.roleId == 4) return true;
  return false;
}
