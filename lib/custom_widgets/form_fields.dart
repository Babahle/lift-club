import 'package:flutter/material.dart';
class CustomFormFields {
  static TextFormField buildLocationFormField(
      {required String? hint, required String? label, required TextEditingController controller}) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.streetAddress,
      decoration: InputDecoration(
          hintText: hint, label: Text(label!), prefixIcon: Icon(Icons.place)),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter a location";
        }
        return null;
      },
    );
  }

  static TextFormField buildNumberOfSeatsField(TextEditingController controller) {
    return TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
                hintText: "Enter The Number of Seats Available",
                label: Text("No. Seats Available"),
                prefixIcon: Icon(Icons.numbers)),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter a number";
              }
              return null;
            },
          );
  }

}
