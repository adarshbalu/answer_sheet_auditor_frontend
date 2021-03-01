import 'package:answer_sheet_auditor/core/presentation/theme/theme.dart';
import 'package:flutter/material.dart';

class RedButton extends StatelessWidget {
  const RedButton({
    @required this.label,
    @required this.onPressed,
  });
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: const BoxDecoration(
              color: AppTheme.ERROR_COLOR,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Text(
              label,
              style: AppTheme.TEXT_THEME.headline4.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
