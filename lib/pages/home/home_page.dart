import 'package:flutter/material.dart';
import 'package:nubank_clone/pages/widgets/item_menu_bottom.dart';
import 'package:nubank_clone/pages/widgets/menu_app.dart';
import 'package:nubank_clone/pages/widgets/my_app_bar.dart';
import 'package:nubank_clone/pages/widgets/my_dots_app.dart';
import 'package:nubank_clone/pages/widgets/page_view_app.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _showMenu;
  int _currentIndex;
  double _yPosition;

  @override
  void initState() {
    super.initState();
    _showMenu = false;
    _currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    double _screenHeigth = MediaQuery.of(context).size.height;
    if (_yPosition == null) {
      _yPosition = _screenHeigth * .24;
    }
    return Scaffold(
      backgroundColor: Colors.purple[800],
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          MyAppBar(
            showMenu: _showMenu,
            onTap: () {
              setState(() {
                _showMenu = !_showMenu;
                _yPosition =
                    _showMenu ? _screenHeigth * .75 : _screenHeigth * .24;
              });
            },
          ),
          MenuApp(
            top: _screenHeigth * .20,
            showMenu: _showMenu,
          ),
          PageViewApp(
            showMenu: _showMenu,
            top: _yPosition,
            onChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            onPanUpdate: (details) {
              double positionBottomLimit = _screenHeigth * .75;
              double positionTopLimit = _screenHeigth * .24;
              double midlePosition = positionBottomLimit - positionTopLimit;

              midlePosition = midlePosition / 2;

              setState(() {
                _yPosition += details.delta.dy;

                _yPosition = _yPosition < positionTopLimit
                    ? positionTopLimit
                    : _yPosition;

                _yPosition = _yPosition > positionBottomLimit
                    ? positionBottomLimit
                    : _yPosition;

                if (_yPosition != positionBottomLimit && details.delta.dy > 0) {
                  _yPosition =
                      _yPosition > positionTopLimit + midlePosition - 50
                          ? positionBottomLimit
                          : _yPosition;
                }

                if (_yPosition != positionTopLimit && details.delta.dy < 0) {
                  _yPosition = _yPosition < positionBottomLimit - midlePosition
                      ? positionTopLimit
                      : _yPosition;
                }

                if (_yPosition == positionBottomLimit) {
                  _showMenu = true;
                } else if (_yPosition == positionTopLimit) {
                  _showMenu = false;
                }
              });
            },
          ),
          MyDotsApp(
            top: _screenHeigth * .70,
            currentIndex: _currentIndex,
            showMenu: _showMenu,
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 200),
            bottom: !_showMenu ? 0 + MediaQuery.of(context).padding.bottom : 0,
            left: 0,
            right: 0,
            height: _screenHeigth * 0.18,
            child: IgnorePointer(
              ignoring: _showMenu,
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 200),
                opacity: !_showMenu ? 1 : 0,
                child: Container(
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      ItemMenuBotoom(
                          icon: Icons.person_add, text: 'Indicar amigos'),
                      ItemMenuBotoom(
                          icon: Icons.phone_android,
                          text: 'Recarga de celular'),
                      ItemMenuBotoom(icon: Icons.chat, text: 'Cobrar'),
                      ItemMenuBotoom(
                          icon: Icons.monetization_on, text: 'Empréstimos'),
                      ItemMenuBotoom(
                          icon: Icons.move_to_inbox, text: 'Depositar'),
                      ItemMenuBotoom(
                          icon: Icons.mobile_screen_share, text: 'Transferir'),
                      ItemMenuBotoom(icon: Icons.tune, text: 'Ajustat limite'),
                      ItemMenuBotoom(
                          icon: Icons.chrome_reader_mode, text: 'Pagar'),
                      ItemMenuBotoom(
                          icon: Icons.lock_open, text: 'Bloquear cartão'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
