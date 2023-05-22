import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTabBar<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final String leading;
  final ValueChanged<T?> onChanged;

  const CustomTabBar({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.leading,
  });
//
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(value),
      child: Row(
        children: [
          _customRadioButton,
        ],
      ),
    );
  }

  Widget get _customRadioButton {
    final isSelected = value == groupValue;
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF512DA8) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: isSelected ? const Color(0xFF512DA8) : Colors.black12),
        ),
        child: Text(
          leading,
          style: GoogleFonts.roboto(
            color: isSelected ? Colors.white : const Color(0xff0F172A),
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
