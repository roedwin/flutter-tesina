import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_tesina/config/menu/menu_items.dart';

import '../providers/theme/theme_provider.dart';

class SideMenu extends ConsumerStatefulWidget {

  final GlobalKey<ScaffoldState> scaffoldKey;

  const SideMenu({
    super.key, 
    required this.scaffoldKey
  });

  @override
  SideMenuState createState() => SideMenuState();
}

class SideMenuState extends ConsumerState<SideMenu> {

  int navDrawerIndex = 0;


  @override
  Widget build(BuildContext context) {


    final isDarkmode = ref.watch(isDarkModeProvider);

    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;

    return NavigationDrawer(
      selectedIndex: navDrawerIndex,
      onDestinationSelected: (value) {
        setState(() {
          navDrawerIndex = value;
        });
        final menuItem = appMenuItems[value];
        context.push(menuItem.link);
        widget.scaffoldKey.currentState?.closeDrawer();
      },
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(28, hasNotch ? 0 : 20, 16, 10),
          child: const Text('Principal'),
        ),
        ...appMenuItems
          .sublist(0,3)
          .map((item) => NavigationDrawerDestination(
            icon: Icon(item.icon), 
            label: Text(item.title)
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
          child: Divider(),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 10, 16, 10),
          child:  Text('Mas Opciones'),
        ),
        ...appMenuItems
          .sublist(3,4)
          .map((item) => NavigationDrawerDestination(
            icon: Icon(item.icon), 
            label: Text(item.title)
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(28, 5, 16, 10),
          child: Row(
            children: [
              const Text("Modo Oscuro"),
              const SizedBox(width: 10,),
              IconButton(
                iconSize: 30,
                  onPressed: () {
                    ref.read(isDarkModeProvider.notifier).isDark();
                  }, 
                  icon: Icon( isDarkmode ?  Icons.dark_mode : Icons.dark_mode_outlined )         
                ),
            ],
          ),
        )        
        
      ]
    );
  }
}