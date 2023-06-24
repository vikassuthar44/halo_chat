import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  CustomButton({
    super.key,
    required this.size,
    required this.text,
    required this.isLoading
  });

  final double size;
  final String text;
  bool isLoading = false;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: 65,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(25)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
            child: widget.isLoading == true
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Text(
                    widget.text,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 24),
                  )),
      ),
    );
  }
}
