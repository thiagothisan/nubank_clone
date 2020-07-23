import 'package:flutter/material.dart';
import 'package:nubank_clone/pages/widgets/item_menu_bottom.dart';

class BottomMenu extends StatelessWidget {
  final bool showMenu;

  const BottomMenu({Key key, this.showMenu}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 200),
      bottom: !showMenu ? 0 + MediaQuery.of(context).padding.bottom : 0,
      left: 0,
      right: 0,
      height: MediaQuery.of(context).size.height * 0.18,
      child: IgnorePointer(
        ignoring: showMenu,
        child: AnimatedOpacity(
          duration: Duration(milliseconds: 200),
          opacity: !showMenu ? 1 : 0,
          child: Container(
            child: ListView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                ItemMenuBotoom(icon: Icons.person_add, text: 'Indicar amigos'),
                ItemMenuBotoom(
                    icon: Icons.phone_android, text: 'Recarga de celular'),
                ItemMenuBotoom(icon: Icons.chat, text: 'Cobrar'),
                ItemMenuBotoom(
                    icon: Icons.monetization_on, text: 'Empréstimos'),
                ItemMenuBotoom(icon: Icons.move_to_inbox, text: 'Depositar'),
                ItemMenuBotoom(
                    icon: Icons.mobile_screen_share, text: 'Transferir'),
                ItemMenuBotoom(icon: Icons.tune, text: 'Ajustat limite'),
                ItemMenuBotoom(icon: Icons.chrome_reader_mode, text: 'Pagar'),
                ItemMenuBotoom(icon: Icons.lock_open, text: 'Bloquear cartão'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
