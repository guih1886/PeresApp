import 'package:flutter/material.dart';

class CustomInput extends StatefulWidget {
  final String label;
  final String text;
  final double width;

  const CustomInput(
      {super.key, required this.label, required this.text, required this.width});

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        readOnly: true,
        initialValue: widget.text,
        style: const TextStyle(fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: widget.label,
          labelStyle: const TextStyle(
              color: Colors.indigoAccent, fontWeight: FontWeight.bold),
          border: const OutlineInputBorder(),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );

    final card = Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: content,
    );

    return widget.width != null ? SizedBox(width: widget.width, child: card) : card;
  }
}
