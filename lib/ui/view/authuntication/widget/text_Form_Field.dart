import 'package:flutter/material.dart';

class Text_Form_Custom extends StatelessWidget {
  final String? label;
  final IconData? iconlabel;
  final TextEditingController? controllerr;
  final Function(String)? onChanged;
  const Text_Form_Custom({
    super.key,
    this.label,
    this.iconlabel,
    this.controllerr,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: TextFormField(
        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
        onChanged: onChanged,
        controller: controllerr,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.grey, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.grey, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: Colors.green,
              width: 2,
            ), // 👈 لون لما يكون فوكس
          ),
          prefixIcon: iconlabel != null ? Icon(iconlabel, size: 20) : null,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 16,
          ),
        ),
      ),
    );
  }
}
