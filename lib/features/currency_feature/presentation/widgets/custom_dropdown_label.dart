import 'package:flutter/material.dart';


// ignore: must_be_immutable
class CustomDropDownLabel extends StatefulWidget {
  CustomDropDownLabel(
      {Key? key,
        required this.dropdownChild,
        required this.hintText,
        this.hasLabel = true,
        this.smallestHeight = false})
      : super(key: key);

  final String hintText;
  final bool hasLabel;
  Widget dropdownChild;
  final bool smallestHeight;

  @override
  State<CustomDropDownLabel> createState() => _CustomDropDownLabelState();
}

class _CustomDropDownLabelState extends State<CustomDropDownLabel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.hasLabel
            ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(widget.hintText ,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14 ,
                  fontWeight: FontWeight.bold)),
        )
            : const SizedBox(),
        SizedBox(height: widget.hasLabel ? 5 : 0),
        Container(
          height: widget.smallestHeight ? 40 : 50,
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius:
              BorderRadius.circular(widget.smallestHeight ? 5 : 10),
              border: Border.all(color: Colors.red)),
          child: Center(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: widget.dropdownChild),
          ),
        ),
        const SizedBox(height: 10)
      ],
    );
  }
}
