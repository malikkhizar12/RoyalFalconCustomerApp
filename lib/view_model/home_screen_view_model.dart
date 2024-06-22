  import 'package:flutter/material.dart';
  import 'package:provider/provider.dart';
  import 'package:royal_falcon/model/user_model.dart';
  import 'package:royal_falcon/view_model/user_view_model.dart';

  class HomeScreenViewModel with ChangeNotifier {
    String? userName;
    String? userEmail;
    bool _isInitialized = false;

    void setUserModel(UserModel userModel) {
      userName = userModel.user?.name;
      userEmail = userModel.user?.email;
      _isInitialized = true;
      notifyListeners(); // Notify listeners only when data changes
    }
    void initializeData(BuildContext context) async {
      final userViewModel = Provider.of<UserViewModel>(context, listen: false);
      UserModel? userData = await userViewModel.getUser();
      if (userData != null) {
        setUserModel(userData);
      }
    }
    bool get isInitialized => _isInitialized;

    String capitalizeFirstLetter(String input) {
      if (input.isEmpty) return input;
      return input[0].toUpperCase() + input.substring(1);
    }
  }
