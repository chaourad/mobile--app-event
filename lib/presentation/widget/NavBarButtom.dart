import 'package:evenmt_sportif/presentation/pages/AjouterEvenemnt.dart';
import 'package:evenmt_sportif/presentation/pages/HomePage.dart';
import 'package:evenmt_sportif/presentation/pages/MessagePage.dart';
import 'package:evenmt_sportif/presentation/pages/MyEventPage.dart';
import 'package:evenmt_sportif/presentation/pages/ProfilePage.dart';
import 'package:flutter/material.dart';

class NavBarButton extends StatefulWidget {
  const NavBarButton({super.key});

  @override
  State<NavBarButton> createState() => _NavBarButtonState();
}

class _NavBarButtonState extends State<NavBarButton> {
   int _currentIndex = 0;

  final List<Widget> _pages = [
   const  HomePage(),
    const MessagePage(),
    const AjouterEvent(),
    const MyEventPage(),
     ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30,
              color: _currentIndex == 0
                  ? const Color.fromRGBO(85, 105, 254, 1.0)
                  : Colors.grey,
            ),
            label: "home ",

            // textStyle: TextStyle(color: Colors.black12),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.message,
              color: _currentIndex == 1
                  ? const Color.fromRGBO(85, 105, 254, 1.0)
                  : Colors.grey,
              size: 30,
            ),
            label: "msg",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add,
              size: 30,
              color: _currentIndex == 2
                  ? const Color.fromRGBO(85, 105, 254, 1.0)
                  : Colors.grey,
            ),
            label: "add ",

            // textStyle: TextStyle(color: Colors.black12),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.event,
              color: _currentIndex == 3
                  ? const Color.fromRGBO(85, 105, 254, 1.0)
                  : Colors.grey,
              size: 30,
            ),
            label: "event",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: _currentIndex == 4
                  ? const Color.fromRGBO(85, 105, 254, 1.0)
                  : Colors.grey,
              size: 30,
            ),
            label: "personne",
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: _pages[_currentIndex],
    );
  }
}
