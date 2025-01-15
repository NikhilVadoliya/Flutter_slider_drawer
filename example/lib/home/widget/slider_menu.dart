import 'package:example/model/menu.dart';
import 'package:flutter/material.dart';

class SliderMenu extends StatelessWidget {
  final Function(String)? onItemClick;

  const SliderMenu({Key? key, this.onItemClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 30),
      child: ListView(
        children: <Widget>[
          const SizedBox(height: 30),
          const _Profile(),
          const SizedBox(height: 20),
          ...[
            Menu(Icons.home, 'Home'),
            Menu(Icons.add_circle, 'Add Post'),
            Menu(Icons.notifications_active, 'Notification'),
            Menu(Icons.favorite, 'Likes'),
            Menu(Icons.settings, 'Setting'),
            Menu(Icons.arrow_back_ios, 'LogOut')
          ]
              .map((menu) => _MenuItem(
                  title: menu.title,
                  iconData: menu.iconData,
                  onTap: onItemClick))
              .toList(),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Function(String)? onTap;

  const _MenuItem(
      {Key? key,
      required this.title,
      required this.iconData,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(title, style: const TextStyle(color: Colors.black)),
        leading: Icon(iconData, color: Colors.black),
        onTap: () => onTap?.call(title));
  }
}

class _Profile extends StatelessWidget {
  const _Profile();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 62,
          backgroundColor: Colors.black26,
          child: CircleAvatar(
            radius: 60,
            backgroundImage: Image.network(
                    'https://nikhilvadoliya.github.io/assets/images/nikhil_1.webp')
                .image,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Nikhil',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ],
    );
  }
}
