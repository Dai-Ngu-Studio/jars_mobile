import 'package:flutter/material.dart';
import 'package:jars_mobile/constants/colors.dart';

class TouchSpinWidget extends StatefulWidget {
  const TouchSpinWidget({
    Key? key,
    required this.controller,
    required this.min,
    required this.max,
    this.steps = 1,
    this.onChanged,
  }) : super(key: key);

  final TextEditingController controller;
  final int min;
  final int max;
  final int? steps;
  final ValueChanged<TextEditingController>? onChanged;

  @override
  State<TouchSpinWidget> createState() => _TouchSpinWidgetState();
}

class _TouchSpinWidgetState extends State<TouchSpinWidget> {
  late TextEditingController? _controller;

  bool get minusBtnDisabled {
    return int.parse(_controller!.text) <= widget.min ||
        int.parse(_controller!.text) - widget.steps! < widget.min;
  }

  bool get addBtnDisabled {
    return int.parse(_controller!.text) >= widget.max ||
        int.parse(_controller!.text) + widget.steps! > widget.max;
  }

  Color? _buttonColor(bool btnDisabled) {
    return btnDisabled ? Colors.grey : jarsColor;
  }

  void _adjustValue(int adjustment) {
    int newVal = int.parse(_controller!.text) + adjustment;
    setState(() => _controller!.text = newVal.toString());
    widget.onChanged?.call(TextEditingController(text: newVal.toString()));
  }

  @override
  void didUpdateWidget(TouchSpinWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.controller != widget.controller) {
      setState(() => _controller = widget.controller);
      widget.onChanged?.call(widget.controller);
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Material(
          color: _buttonColor(minusBtnDisabled),
          borderRadius: BorderRadius.circular(5),
          child: InkWell(
            onTap: minusBtnDisabled ? null : () => _adjustValue(-widget.steps!),
            child: Padding(
              padding: MediaQuery.of(context).size.width < 350
                  ? const EdgeInsets.all(4)
                  : const EdgeInsets.all(8),
              child: const Icon(Icons.remove, color: Colors.white, size: 14),
            ),
          ),
        ),
        const SizedBox(width: 5),
        Container(
          width: MediaQuery.of(context).size.width < 350 ? 30 : 35,
          height: MediaQuery.of(context).size.width < 350 ? 30 : 35,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(.2),
            borderRadius: BorderRadius.circular(6),
          ),
          child: TextField(
            controller: _controller,
            textAlign: TextAlign.center,
            enabled: false,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width < 350 ? 12 : 16,
              fontWeight: FontWeight.w600,
            ),
            decoration: const InputDecoration(border: InputBorder.none, isDense: true),
          ),
        ),
        const SizedBox(width: 5),
        Material(
          color: _buttonColor(addBtnDisabled),
          borderRadius: BorderRadius.circular(5),
          child: InkWell(
            onTap: addBtnDisabled ? null : () => _adjustValue(widget.steps!),
            child: Padding(
              padding: MediaQuery.of(context).size.width < 350
                  ? const EdgeInsets.all(4)
                  : const EdgeInsets.all(8),
              child: const Icon(Icons.add, color: Colors.white, size: 14),
            ),
          ),
        ),
      ],
    );
  }
}
