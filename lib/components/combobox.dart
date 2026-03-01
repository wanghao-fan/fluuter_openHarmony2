import 'package:flutter/material.dart';

class ShadcnCombobox extends StatefulWidget {
  final List<ComboboxOption> options;
  final String? label;
  final String? placeholder;
  final Function(ComboboxOption) onSelected;
  final ComboboxOption? initialValue;

  const ShadcnCombobox({
    super.key,
    required this.options,
    this.label,
    this.placeholder,
    required this.onSelected,
    this.initialValue,
  });

  @override
  State<ShadcnCombobox> createState() => _ShadcnComboboxState();
}

class _ShadcnComboboxState extends State<ShadcnCombobox> {
  bool _isOpen = false;
  ComboboxOption? _selectedOption;

  @override
  void initState() {
    super.initState();
    _selectedOption = widget.initialValue;
  }

  void _toggleDropdown() {
    setState(() {
      _isOpen = !_isOpen;
    });
  }

  void _selectOption(ComboboxOption option) {
    setState(() {
      _selectedOption = option;
      _isOpen = false;
    });
    widget.onSelected(option);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                widget.label!,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1E293B),
                ),
              ),
            ),
          GestureDetector(
            onTap: _toggleDropdown,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(
                  color: _isOpen
                      ? const Color(0xFF3B82F6)
                      : const Color(0xFFE2E8F0),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedOption?.label ?? widget.placeholder ?? 'Select an option',
                    style: TextStyle(
                      fontSize: 16,
                      color: _selectedOption != null
                          ? const Color(0xFF1E293B)
                          : const Color(0xFF94A3B8),
                    ),
                  ),
                  Icon(
                    _isOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                    color: const Color(0xFF64748B),
                  ),
                ],
              ),
            ),
          ),
          if (_isOpen)
            Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFFE2E8F0),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: widget.options.map((option) {
                  return GestureDetector(
                    onTap: () => _selectOption(option),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: _selectedOption?.value == option.value
                            ? const Color(0xFFEFF6FF)
                            : Colors.transparent,
                      ),
                      child: Row(
                        children: [
                          if (_selectedOption?.value == option.value)
                            const Icon(
                              Icons.check,
                              size: 16,
                              color: Color(0xFF3B82F6),
                            ),
                          if (_selectedOption?.value == option.value)
                            const SizedBox(width: 8),
                          Text(
                            option.label,
                            style: TextStyle(
                              fontSize: 16,
                              color: _selectedOption?.value == option.value
                                  ? const Color(0xFF3B82F6)
                                  : const Color(0xFF1E293B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}

class ComboboxOption {
  final String value;
  final String label;

  const ComboboxOption({
    required this.value,
    required this.label,
  });
}
