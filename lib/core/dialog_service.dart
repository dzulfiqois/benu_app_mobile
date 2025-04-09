import 'package:flutter/material.dart'
    show AlertDialog, ScaffoldMessenger, SnackBar, TextButton, showDialog;
import 'package:flutter/widgets.dart';

class DialogService {
  DialogService._privateConstructor();

  static final DialogService _instance = DialogService._privateConstructor();
  static DialogService get instance => _instance;

  Future<bool> showConfirmationDialog(
      BuildContext context, String message) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Konfirmasi'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Batal'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Ya'),
              ),
            ],
          ),
        ) ??
        false;
  }

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
