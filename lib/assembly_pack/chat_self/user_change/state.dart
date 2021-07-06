import 'package:flutter/material.dart';

class UserChangeState {
  TextEditingController nameController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  UserChangeState() {
    ///Initialize variables
  }
}
