part of 'cui_top_menu_bar.dart';

class CUIMenuItem {
  final String label;
  final MenuSerializableShortcut? shortcut;
  final VoidCallback? onPressed;
  final List<CUIMenuItem>? subMenu;
  final bool hasDivider;

  const CUIMenuItem(
      {required this.label,
      this.shortcut,
      this.onPressed,
      this.subMenu,
      this.hasDivider = false})
      : assert(subMenu == null || onPressed == null,
            'onPressed is ignored if subMenu are provided');

  static Widget menuAcceleratorBuilder(
      BuildContext context, String label, int index) {
    if (index < 0) {
      return Text(label);
    }
    final TextStyle defaultStyle = DefaultTextStyle.of(context).style;
    final Characters characters = label.characters;
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          if (index > 0)
            TextSpan(
                text: characters.getRange(0, index).toString(),
                style: defaultStyle),
          TextSpan(
            text: characters.getRange(index, index + 1).toString(),
            style: defaultStyle.copyWith(
                decorationColor: Theme.of(context).colorScheme.inverseSurface,
                decoration: TextDecoration.underline),
          ),
          if (index < characters.length - 1)
            TextSpan(
                text: characters.getRange(index + 1).toString(),
                style: defaultStyle),
        ],
      ),
    );
  }

  // Static Function to Generate the SubMenu and/or SubMenuItem Widget
  static List<Widget> build(List<CUIMenuItem> menuList, BuildContext context) {
    Widget buildMenuList(CUIMenuItem item) {
      if (item.subMenu != null) {
        return SubmenuButton(
          menuChildren: CUIMenuItem.build(item.subMenu!, context),
          child:
              MenuAcceleratorLabel(item.label, builder: menuAcceleratorBuilder),
        );
      }
      return Container(
          decoration: item.hasDivider
              ? BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: Theme.of(context).colorScheme.outline,
                          width: 1)))
              : null,
          child: MenuItemButton(
            shortcut: item.shortcut,
            onPressed: item.onPressed,
            child: MenuAcceleratorLabel(item.label,
                builder: menuAcceleratorBuilder),
          ));
    }

    return menuList.map<Widget>(buildMenuList).toList();
  }

  // Static Function to Generate a Map of Shortcuts for MenuItem
  static Map<MenuSerializableShortcut, Intent> shortcuts(
      List<CUIMenuItem> menuList) {
    final Map<MenuSerializableShortcut, Intent> result =
        <MenuSerializableShortcut, Intent>{};
    for (final CUIMenuItem item in menuList) {
      if (item.subMenu != null) {
        result.addAll(CUIMenuItem.shortcuts(item.subMenu!));
      } else {
        if (item.shortcut != null && item.onPressed != null) {
          result[item.shortcut!] = VoidCallbackIntent(item.onPressed!);
        }
      }
    }
    return result;
  }
}
