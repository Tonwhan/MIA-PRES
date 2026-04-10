import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pillpal/core/services/session/session_manager.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  static bool _isGoogleInitialized = false;
  static final String _rawNonce = _generateRandomString(32);
  static final String _hashedNonce = sha256
      .convert(utf8.encode(_rawNonce))
      .toString();

  static String _generateRandomString(int length) {
    final random = Random.secure();
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    return List.generate(
      length,
      (_) => charset[random.nextInt(charset.length)],
    ).join();
  }

  //Continue With Google
  Future<void> continueWithGoogle() async {
    try {
      if (!_isGoogleInitialized) {
        final webClientId = dotenv.env['WEB_CLIENT'];
        final iosClientId = dotenv.env['IOS_CLIENT'];

        await GoogleSignIn.instance.initialize(
          serverClientId: webClientId,
          clientId: iosClientId,
          nonce: _hashedNonce, // Google requires the hashed nonce in ID Token
        );
        _isGoogleInitialized = true;
      }

      final GoogleSignInAccount googleUser = await GoogleSignIn.instance
          .authenticate();

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      final idToken = googleAuth.idToken;

      if (idToken == null) {
        throw Exception('Missing Google ID Token');
      }

      await _supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        nonce:
            _rawNonce, // Supabase requires the raw nonce to verify against the ID token's hash
      );
    } catch (e) {
      throw Exception('Google Sign-IN Error: $e');
    }
  }

  //Sign in with email and password
  Future<AuthResponse> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    return await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  //Sign up with email and password
  Future<AuthResponse> signUpWithEmailPassword(
    String email,
    String password,
  ) async {
    return await _supabase.auth.signUp(email: email, password: password);
  }

  //Sign out
  Future<void> signOut() async {
    SessionManager().reset();
    await _supabase.auth.signOut();
  }

  //Get user email
  String? getCurrentuserEmail() {
    return _supabase.auth.currentUser?.email;
  }

  //Get user profile image
  String? getUserProfileImage() {
    return _supabase.auth.currentUser?.userMetadata?['avatar_url'];
  }

  //Update User Profile (Auth Metadata)
  Future<void> updateUserProfile(String fullName) async {
    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    try {
      //Update Auth Metadata
      final data = {'full_name': fullName};

      await _supabase.auth.updateUser(
        UserAttributes(data: data),
      );
    } catch (e) {
      debugPrint('Error updating profile metadata: $e');
      rethrow;
    }
  }

  // Update User Metadata
  Future<void> updateUserMetadata(Map<String, dynamic> metadata) async {
    try {
      await _supabase.auth.updateUser(UserAttributes(data: metadata));
    } catch (e) {
      throw Exception('Update Metadata Error: $e');
    }
  }

  // Upload Profile Image to Supabase Storage
  Future<String?> uploadProfileImage(File imageFile) async {
    final user = _supabase.auth.currentUser;
    if (user == null) {
      debugPrint('UPLOAD ERROR: No user found in session');
      throw Exception('User not logged in');
    }
    
    debugPrint('UPLOAD START: User ID = ${user.id}');

    try {
      final String userId = user.id;
      final String fileExtension = imageFile.path.split('.').last;
      
      // Fixed fileName: use userId to always overwrite the same file (Upsert)
      // This saves storage space by replacing the old profile image.
      final String filePath = '$userId.$fileExtension'; 

      debugPrint('Attempting to upload to bucket: avatars, path: $filePath');

      // Upload the file to the 'avatars' bucket with upsert: true
      await _supabase.storage.from('avatars').upload(
            filePath,
            imageFile,
            fileOptions: const FileOptions(
              cacheControl: '0', // Set cache to 0 so the image updates immediately in the app
              upsert: true,
            ),
          );

      // Get the public URL for the uploaded file
      // Add a timestamp query parameter to bust any client-side cache (e.g., Image.network)
      final String publicUrl = _supabase.storage.from('avatars').getPublicUrl(filePath) + 
          '?t=${DateTime.now().millisecondsSinceEpoch}';

      // Update user metadata with the new avatar_url
      await updateUserMetadata({'avatar_url': publicUrl});

      return publicUrl;
    } catch (e) {
      debugPrint('Error uploading profile image: $e');
      rethrow;
    }
  }
}
