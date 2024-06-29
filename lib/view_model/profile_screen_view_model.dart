import 'dart:io' show Platform, File;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';
import '../view_model/user_view_model.dart';

class ProfileScreenViewModel with ChangeNotifier {
  String? userName;
  String? userEmail;
  String? userGender;
  String? userCountry;
  String? _profileImagePath;
  bool _isInitialized = false;
  String? userToken;

  String? get profileImagePath => _profileImagePath;

  void setUserModel(UserModel userModel) {
    userName = userModel.user?.name;
    userEmail = userModel.user?.email;
    userToken = userModel.token;
    _isInitialized = true;
    notifyListeners(); // Notify listeners only when data changes
  }

  void initializeData(BuildContext context) async {
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);
    UserModel? userData = await userViewModel.getUser();
    if (userData != null) {
      setUserModel(userData);
    }
    await _loadProfileData();
  }

  bool get isInitialized => _isInitialized;

  String capitalizeFirstLetter(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1);
  }

  Future<void> pickImage(BuildContext context) async {
    if (kIsWeb || Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      // Image picker not supported on these platforms
      return;
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Camera', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      _profileImagePath = pickedFile.path;
      await _saveProfileImage(_profileImagePath!);
      notifyListeners();
    }
  }

  Future<void> _saveProfileImage(String path) async {
    final prefs = await SharedPreferences.getInstance();
    if (userToken != null) {
      await prefs.setString('profile_image_path_$userToken', path);
    }
  }

  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    if (userToken != null) {
      _profileImagePath = prefs.getString('profile_image_path_$userToken');
      userGender = prefs.getString('user_gender_$userToken');
      userCountry = prefs.getString('user_country_$userToken');
    }
    notifyListeners();
  }

  Future<void> saveGender(String? gender) async {
    userGender = gender;
    final prefs = await SharedPreferences.getInstance();
    if (userToken != null) {
      await prefs.setString('user_gender_$userToken', gender ?? '');
    }
    notifyListeners();
  }

  Future<void> saveCountry(String? country) async {
    userCountry = country;
    final prefs = await SharedPreferences.getInstance();
    if (userToken != null) {
      await prefs.setString('user_country_$userToken', country ?? '');
    }
    notifyListeners();
  }
}
