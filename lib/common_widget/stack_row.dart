import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../common/color_extension.dart';

class StackRow extends StatelessWidget {
  final String title;
  final String icon;
  final String about;
  final String value;
  const StackRow(
      {super.key,
      required this.title,
      required this.icon,
      required this.about,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                icon,
                width: 20,
                height: 20,
                color: TColor.gray20,
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                title,
                style: TextStyle(
                    color: TColor.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                width: 8,
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            about,
            style: TextStyle(
                color: TColor.gray20,
                fontSize: 14,
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}

class IconItemSwitchRow extends StatelessWidget {
  final String title;
  final String icon;
  final bool value;
  final Function(bool) didChange;

  const IconItemSwitchRow(
      {super.key,
      required this.title,
      required this.icon,
      required this.didChange,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          Image.asset(
            icon,
            width: 20,
            height: 20,
            color: TColor.gray20,
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            title,
            style: TextStyle(
                color: TColor.white, fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          const SizedBox(
            width: 8,
          ),
          CupertinoSwitch(value: value, onChanged: didChange)
        ],
      ),
    );
  }
}
