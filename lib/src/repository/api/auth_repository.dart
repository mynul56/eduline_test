import 'package:mynul_test/src/repository/api/network/NetworkApiServices.dart';

class AuthRepository {
  final _api = NetworkApiServices();

  /// Performs user login. Returns true on success.
  Future<bool> login(String email, String password) async {
    try {
      // NOTE: Replace with your actual login endpoint
      final url =
          'https://example.com/api/auth/login?email=${Uri.encodeComponent(email)}&password=${Uri.encodeComponent(password)}';
      final resp = await _api.getGetApiResponse(url: url);
      if (resp is Map && (resp['success'] == true || resp['status'] == 'ok')) {
        return true;
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }

  /// Sends a forgot-password email. Returns true on success.
  /// NOTE: Replace the URL with your real endpoint.
  Future<bool> sendResetEmail(String email) async {
    try {
      final url =
          'https://example.com/api/auth/forgot?email=${Uri.encodeComponent(email)}';
      final resp = await _api.getGetApiResponse(url: url);
      // Expecting a JSON response with success flag
      if (resp is Map && (resp['success'] == true || resp['status'] == 'ok')) {
        return true;
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }

  /// Verifies the OTP code. Returns true on success.
  Future<bool> verifyOtp(String email, String code) async {
    try {
      final url =
          'https://example.com/api/auth/verify-otp?email=${Uri.encodeComponent(email)}&code=${Uri.encodeComponent(code)}';
      final resp = await _api.getGetApiResponse(url: url);
      if (resp is Map && (resp['success'] == true || resp['status'] == 'ok')) {
        return true;
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }

  /// Resets the password using provided email and new password.
  Future<bool> resetPassword(String email, String newPassword) async {
    try {
      final url =
          'https://example.com/api/auth/reset-password?email=${Uri.encodeComponent(email)}&password=${Uri.encodeComponent(newPassword)}';
      final resp = await _api.getGetApiResponse(url: url);
      if (resp is Map && (resp['success'] == true || resp['status'] == 'ok')) {
        return true;
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }
}
