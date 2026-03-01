import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/widget_state.dart';

class ShadcnSlider extends StatefulWidget {
  final double value;
  final double min;
  final double max;
  final int? divisions;
  final ValueChanged<double>? onChanged;
  final ValueChanged<double>? onChangeStart;
  final ValueChanged<double>? onChangeEnd;
  final String? label;
  final Color? activeColor;
  final Color? inactiveColor;

  const ShadcnSlider({
    super.key,
    required this.value,
    this.min = 0.0,
    this.max = 100.0,
    this.divisions,
    this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.label,
    this.activeColor = const Color(0xFF3B82F6),
    this.inactiveColor = const Color(0xFFE2E8F0),
  });

  @override
  State<ShadcnSlider> createState() => _ShadcnSliderState();
}

class _ShadcnSliderState extends State<ShadcnSlider> {
  double _value = 0.0;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  void didUpdateWidget(covariant ShadcnSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      setState(() {
        _value = widget.value;
      });
    }
  }

  void _handleChange(double value) {
    setState(() {
      _value = value;
    });
    widget.onChanged?.call(value);
  }

  void _handleChangeStart(double value) {
    widget.onChangeStart?.call(value);
  }

  void _handleChangeEnd(double value) {
    widget.onChangeEnd?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                widget.label!,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF475569),
                ),
              ),
            ),
          Slider(
            value: _value,
            min: widget.min,
            max: widget.max,
            divisions: widget.divisions,
            onChanged: _handleChange,
            onChangeStart: _handleChangeStart,
            onChangeEnd: _handleChangeEnd,
            activeColor: widget.activeColor,
            inactiveColor: widget.inactiveColor,
            thumbColor: Colors.white,
            overlayColor: widget.activeColor != null
                ? WidgetStateProperty.all(widget.activeColor!.withOpacity(0.1))
                : null,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.min.toStringAsFixed(0),
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF64748B),
                ),
              ),
              Text(
                _value.toStringAsFixed(widget.divisions != null ? 0 : 1),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: widget.activeColor,
                ),
              ),
              Text(
                widget.max.toStringAsFixed(0),
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
