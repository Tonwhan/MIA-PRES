import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pillpal/config/theme/colors_theme.dart';
import 'package:pillpal/core/services/auth/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileManage extends StatefulWidget {
  final String? username;

  const ProfileManage({super.key, this.username});

  @override
  State<ProfileManage> createState() => _ProfileManageState();
}

class _ProfileManageState extends State<ProfileManage> {
  final AuthService _authService = AuthService();
  final TextEditingController _usernameController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;
  String _displayName = '';
  String? _avatarUrl;
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  void _fetchUserData() {
    final user = Supabase.instance.client.auth.currentUser;
    setState(() {
      _displayName =
          user?.userMetadata?['full_name'] ?? widget.username ?? 'User';
      _avatarUrl = user?.userMetadata?['avatar_url'];
      _usernameController.text = _displayName;
    });
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );

    if (image == null || !mounted) return;

    final croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: AppColors.primary,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          title: 'Crop Image',
          aspectRatioLockEnabled: true,
          resetAspectRatioEnabled: false,
        ),
        WebUiSettings(context: context),
      ],
    );
    if (croppedFile != null && mounted) {
      setState(() {
        _imageFile = File(croppedFile.path);
      });
    }
  }

  Future<void> _saveProfile() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    try {
      // Update image if selected
      if (_imageFile != null) {
        final newUrl = await _authService.uploadProfileImage(_imageFile!);
        setState(() {
          _avatarUrl = newUrl;
          _imageFile = null;
        });
      }

      // Update display name
      await _authService.updateUserProfile(_usernameController.text.trim());

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully!'),
            backgroundColor: AppColors.primary,
          ),
        );
        setState(() {
          _displayName = _usernameController.text.trim();
        });
      }
    } catch (e) {
      String errorMessage = e.toString();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        toolbarHeight: 40,
        centerTitle: true,
        title: Text("Profile and Username"),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
        ),
      ),
      backgroundColor: AppColors.backgroundColor1,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(color: AppColors.backgroundColor),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          GestureDetector(
                            onTap: _pickImage,
                            child: Container(
                              padding: const EdgeInsets.all(3.0),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.primary,
                                    AppColors.variant1,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 50,
                                backgroundColor: AppColors.backgroundColor1,
                                backgroundImage: _imageFile != null
                                    ? FileImage(_imageFile!)
                                    : (_avatarUrl != null
                                              ? NetworkImage(_avatarUrl!)
                                              : null)
                                          as ImageProvider?,
                                child: _imageFile == null && _avatarUrl == null
                                    ? const Icon(
                                        Icons.person,
                                        size: 50,
                                        color: Colors.white38,
                                      )
                                    : null,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 4,
                            child: GestureDetector(
                              onTap: _pickImage,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.backgroundColor,
                                    width: 3,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.camera_alt,
                                  size: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _displayName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Username",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _usernameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.backgroundColor,
                        hintText: "Enter your username",
                        hintStyle: const TextStyle(color: Colors.white24),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.white10,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: AppColors.primary,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _saveProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.backgroundColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.backgroundColor,
                                ),
                              )
                            : const Text(
                                "Save Changes",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
