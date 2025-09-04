import 'package:e_commerce/core/data/network/network_config.dart';

class AuthEndPoint {
  static final String base = 'auth';
  static final String login = NetworkConfig.getFullApiRout('auth/login');
  static final String signUp = NetworkConfig.getFullApiRout('auth/register');
  static final String verifyEmail = NetworkConfig.getFullApiRout('auth/verify-email');
}

