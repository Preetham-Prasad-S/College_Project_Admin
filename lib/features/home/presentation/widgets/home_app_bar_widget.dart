import 'package:flutter/material.dart';

class HomeAppBarWidget extends StatelessWidget {
  const HomeAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: CircleAvatar(
                maxRadius: 25,
                backgroundImage: NetworkImage(
                  "https://img.freepik.com/premium-vector/vector-illustration-man-cartoon-character_1234575-314.jpg",
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Good Morning,"),
                Text(
                  "Preetham Prasad",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
        IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
      ],
    );
  }
}
