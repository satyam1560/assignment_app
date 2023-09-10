import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  const CustomDropDown({
    required this.items,
    required this.selectedItem,
    required this.onChanged,
    super.key,
  });

  final List<String> items;
  final String? selectedItem;
  final Function(String?)? onChanged;

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: InputDecoration(
              isDense: true,
              labelStyle: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade900,
              ),
              errorStyle: const TextStyle(
                color: Colors.redAccent,
                fontSize: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2),
                borderSide: const BorderSide(
                  width: 1.2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2),
                borderSide: const BorderSide(
                  width: 1.2,
                ),
              ),
            ),
            isEmpty: widget.selectedItem == '',
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                focusColor: Colors.transparent,
                value: widget.selectedItem,
                isDense: true,
                onChanged: widget.onChanged,
                items: widget.items.map(
                  (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
