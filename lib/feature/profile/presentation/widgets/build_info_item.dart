import 'package:flutter/material.dart';

class buildInfoItem extends StatelessWidget {
  const buildInfoItem({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 15, color: Colors.grey)),
          Divider(
            endIndent: 40,
            indent: 40,
            thickness: 1,
            color: Colors.grey,
            radius: BorderRadius.circular(20),
          ),
        ],
      ),
    );
  }
}
