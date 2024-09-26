import 'package:flutter/material.dart';

class ModeCard extends StatelessWidget {
  final String title;
  final int number;
  final IconData icon;
  final Function() onTap;

  const ModeCard(
      {super.key,
      required this.title,
      required this.number,
      required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            const Spacer(),
            Text('$number단어'),
      
            //진행률
            const SizedBox(width: 10),
            Icon(
              icon,
              size: 50,
            ),
          ],
        ),
      ),
    );
  }
}
