import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gundemz/screens/aramasayfasi.dart';
import 'package:gundemz/screens/kesfet.dart';
import 'package:gundemz/view/anasayfa_view.dart';

class BottomNavigationbar extends StatefulWidget {
  const BottomNavigationbar({super.key});

  @override
  State<BottomNavigationbar> createState() => _BottomNavigationbarState();
}

class _BottomNavigationbarState extends State<BottomNavigationbar> {
  int pageIndex = 0;
  late PageController pageController = new PageController();

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  onPageChange(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) async {
    await pageController.animateToPage(pageIndex,
        duration: Duration(microseconds: 900), curve: Curves.bounceInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  appBar: AppBar(title: Text('Home')),
      body: PageView(
        children: [
         // ElevatedButton(child: Text('logout'), onPressed: () {}),
          AnasayfaView(),
          Kesfet(),
          AramaSayfasi(),
        ],
        controller: pageController,
        onPageChanged: onPageChange,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: pageIndex,
        activeColor: Colors.blue,
        onTap: onTap,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled)),
          BottomNavigationBarItem(icon: Icon(Icons.language)),
          BottomNavigationBarItem(icon: Icon(Icons.search)),
          // BottomNavigationBarItem(icon: Icon(Icons.bookmark_border)),
        ],
      ),
    );
  }
}

// import 'package:gundemz/screens/aramasayfasi.dart';
// import 'package:gundemz/screens/kesfet.dart';
// import 'package:gundemz/widgets/drawer.dart';
// import 'package:gundemz/widgets/tapWithNestedScrollView.dart';
// import '../screens/anasayfa.dart';
// class BottomNavigationbar extends StatefulWidget {
//   @override
//   State<BottomNavigationbar> createState() => _BottomNavigationbarState();
// }
// class _BottomNavigationbarState extends State<BottomNavigationbar> {
//   int _currentIndex = 0;
//   Widget _buildIcon(int index) {
//     return _currentIndex == index
//         ? Icon(
//             _icons[index].icon,
//             color: Colors.blue,
//           )
//         : _icons[index];
//   }
//   final List<Icon> _icons = [
//     Icon(Icons.home_filled),
//     Icon(Icons.language),
//     Icon(Icons.search),
//     // Icon(Icons.bookmark_border),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: _currentIndex == 0 ? TapNestedScrollView() : AramaSayfasi(),
//       ),
//       bottomNavigationBar: bottoNB(context),
//     );
//   }
//   bottoNB(BuildContext context) {
//     final List<Icon> _icons = [
//       Icon(Icons.home_filled, color: Colors.black),
//       Icon(Icons.language, color: Colors.black),
//       Icon(Icons.search, color: Colors.black),
//       // Icon(Icons.bookmark_border),
//     ];
//     return BottomNavigationBar(
//       unselectedIconTheme: IconThemeData(color: Colors.black),
//       items: <BottomNavigationBarItem>[
//         BottomNavigationBarItem(
//           icon: _buildIcon(0),
//           label: '',
//         ),
//         BottomNavigationBarItem(
//           icon: _buildIcon(1),
//           label: '',
//         ),
//         BottomNavigationBarItem(
//           icon: _buildIcon(2),
//           label: '',
//         ),
//         // BottomNavigationBarItem(
//         //   icon: Icon(Icons.bookmark_border),
//         //   label: '',
//         // ),
//       ],
//       currentIndex: _currentIndex,
//       selectedItemColor: Colors.blue,
//       onTap: (index) {
//         setState(() {
//           _currentIndex = index;
//         });
//         if (index == 0)
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => Anasayfa(),
//             ),
//           );
//         if (index == 1)
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => Kesfet(),
//             ),
//           );
//         if (index == 2)
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => AramaSayfasi(),
//             ),
//           );
//         // if (index == 3)
//         //   Navigator.push(
//         //     context,
//         //     MaterialPageRoute(
//         //       builder: (context) => AramaSayfasi(),
//         //     ),
//         //   );
//       },
//     );
//   }
// }
// bottomnavigationbar(BuildContext context) {
//   return BottomNavigationBar(
//     // fixedColor: Colors.amber,
//     enableFeedback: true,
//     unselectedIconTheme: IconThemeData(color: Colors.black),
//     items: <BottomNavigationBarItem>[
//       BottomNavigationBarItem(
//         icon: Icon(
//           Icons.home_filled,
//           size: 30,
//         ),
//         label: '',
//       ),
//       BottomNavigationBarItem(
//         icon: Icon(Icons.language, size: 30),
//         label: '',
//       ),
//       BottomNavigationBarItem(
//         icon: Icon(Icons.search, size: 30),
//         label: '',
//       ),
//       // BottomNavigationBarItem(
//       //   icon: Icon(Icons.bookmark_border, size: 30),
//       //   label: '',
//       // ),
//     ],
//     // currentIndex: 0,
//     selectedItemColor: Colors.black,
//     onTap: (value) {
//       if (value == 0)
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => Anasayfa(),
//           ),
//         );
//       if (value == 1)
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => Kesfet(),
//           ),
//         );
//       if (value == 2)
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => AramaSayfasi(),
//           ),
//         );
//       // if (value == 3)
//       //   Navigator.push(
//       //     context,
//       //     MaterialPageRoute(
//       //       builder: (context) => DropdownButtonExample(),
//       //     ),
//       //   );
//     },
//   );
// }
// class OneCikan extends StatelessWidget {
//   const OneCikan({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(30.0),
//         child: AppBar(
//           centerTitle: true,
//           title: Text(
//             'ÖNE ÇIKAN',
//             style: TextStyle(fontSize: 15),
//           ),
//         ),
//       ),
//       drawer: drawerItem(context),
//       body: Center(child: Text('2 bottom item')),
//       // bottomNavigationBar: bottomnavigationbar(context),
//     );
//   }
// }




















// import 'package:flutter/material.dart';
// class BottomNavigationBarExample extends StatefulWidget {
//   const BottomNavigationBarExample({super.key});
//   @override
//   State<BottomNavigationBarExample> createState() =>
//       _BottomNavigationBarExampleState();
// }
// class _BottomNavigationBarExampleState
//     extends State<BottomNavigationBarExample> {
//   int _selectedIndex = 0;
//   static const TextStyle optionStyle =
//       TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
//   static const List<Widget> _widgetOptions = <Widget>[
//     Text(
//       'Index 0: Home',
//       style: optionStyle,
//     ),
//     Text(
//       'Index 1: Business',
//       style: optionStyle,
//     ),
//     Text(
//       'Index 2: School',
//       style: optionStyle,
//     ),
//   ];
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('BottomNavigationBar Sample'),
//       ),
//       body: Center(
//         child: _widgetOptions.elementAt(_selectedIndex),
//       ),
//       bottomNavigationBar: bottomnavigationbar(),
//     );
//   }
//   BottomNavigationBar bottomnavigationbar() {
//     return BottomNavigationBar(
//       items: const <BottomNavigationBarItem>[
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home),
//           label: 'Home',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.business),
//           label: 'Business',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.school),
//           label: 'School',
//         ),
//       ],
//       currentIndex: _selectedIndex,
//       selectedItemColor: Colors.amber[800],
//       onTap: _onItemTapped,
//     );
//   }
// }
