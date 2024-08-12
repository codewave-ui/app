import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

part "cui_menu_item.dart";

class CUITopMenuBar extends StatefulWidget {
  const CUITopMenuBar({super.key});

  @override
  State<CUITopMenuBar> createState() => _CUITopMenuBarState();
}

class _CUITopMenuBarState extends State<CUITopMenuBar> {
  ShortcutRegistryEntry? _shortcutsEntry;

  @override
  void dispose() {
    _shortcutsEntry?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: MenuBar(
          children: CUIMenuItem.build(_getMenus(), context),
        ))
      ],
    );
  }

  List<CUIMenuItem> _getMenus() {
    final List<CUIMenuItem> result = <CUIMenuItem>[
      CUIMenuItem(
        label: '&File',
        subMenu: <CUIMenuItem>[
          // CUIMenuItem(
          //     label: '&Close Project',
          //     shortcut: const SingleActivator(LogicalKeyboardKey.keyW,
          //         control: true, alt: true),
          //     onPressed: () {
          //       SmartDialog.show(
          //           builder: (childContext) => CUIDialog(
          //               config: CUIConfirmationDialogConfig(
          //                   width: 400,
          //                   height: 150,
          //                   title: 'Close Project',
          //                   positiveAction: CUIConfirmationDialogPositiveAction(
          //                       onClick: () {
          //                     context.read<AppCubit>().closeProject();
          //                     windowManager
          //                         .setSize(const Size(1000, 600))
          //                         .then((e) {
          //                       windowManager.center().then((e2) {
          //                         windowManager.unmaximize().then((e3) {
          //                           Navigator.of(context, rootNavigator: true)
          //                               .pushReplacementNamed('/');
          //                         });
          //                       });
          //                     });
          //                   }),
          //                   negativeAction:
          //                       CUIConfirmationDialogNegativeAction(),
          //                   content: "Are you sure want to close project?")));
          //     }),
          CUIMenuItem(
            hasDivider: true,
            label: '&About',
            shortcut:
                const SingleActivator(LogicalKeyboardKey.keyA, control: true),
            onPressed: () {
              showAboutDialog(
                context: context,
                applicationName: 'Codewave UI',
                applicationVersion: '0.0.1-beta',
              );
            },
          ),
          // CUIMenuItem(
          //     label: "&Exit",
          //     onPressed: () {
          //       SmartDialog.show(
          //           builder: (childContext) => CUIDialog(
          //               config: CUIConfirmationDialogConfig(
          //                   width: 400,
          //                   height: 150,
          //                   title: 'Exit App',
          //                   positiveAction: CUIConfirmationDialogPositiveAction(
          //                       onClick: () {
          //                     debugger();
          //                     exit(0);
          //                     // SystemChannels.platform
          //                     //     .invokeMethod('SystemNavigator.pop');
          //                   }),
          //                   negativeAction:
          //                       CUIConfirmationDialogNegativeAction(),
          //                   content: "Are you sure want to exit the app?")));
          //     })
          // CUIMenuItem(
          //   label: showingMessage ? 'Hide Message' : 'Show Message',
          //   onPressed: () {
          //     setState(() {
          //       _lastSelection =
          //       showingMessage ? 'Hide Message' : 'Show Message';
          //       showingMessage = !showingMessage;
          //     });
          //   },
          //   shortcut:
          //   const SingleActivator(LogicalKeyboardKey.keyS, control: true),
          // ),
          // Hides the message, but is only enabled if the message isn't
          // already hidden.
          // CUIMenuItem(
          //   label: 'Reset Message',
          //   onPressed: showingMessage
          //       ? () {
          //     setState(() {
          //       _lastSelection = 'Reset Message';
          //       showingMessage = false;
          //     });
          //   }
          //       : null,
          //   shortcut: const SingleActivator(LogicalKeyboardKey.escape),
          // ),
          // CUIMenuItem(
          //   label: '&Background Color',
          //   subMenu: <CUIMenuItem>[
          //     CUIMenuItem(
          //       label: 'Red Background',
          //       onPressed: () {
          //         // setState(() {
          //         //   _lastSelection = 'Red Background';
          //         //   backgroundColor = Colors.red;
          //         // });
          //       },
          //       shortcut: const SingleActivator(LogicalKeyboardKey.keyR,
          //           control: true),
          //     ),
          //     CUIMenuItem(
          //       label: 'Green Background',
          //       onPressed: () {
          //         // setState(() {
          //         //   _lastSelection = 'Green Background';
          //         //   backgroundColor = Colors.green;
          //         // });
          //       },
          //       shortcut: const SingleActivator(LogicalKeyboardKey.keyG,
          //           control: true),
          //     ),
          //     CUIMenuItem(
          //       label: 'Blue Background',
          //       onPressed: () {
          //         // setState(() {
          //         //   _lastSelection = 'Blue Background';
          //         //   backgroundColor = Colors.blue;
          //         // });
          //       },
          //       shortcut: const SingleActivator(LogicalKeyboardKey.keyB,
          //           control: true),
          //     ),
          //   ],
          // ),
        ],
      ),
    ];
    // (Re-)register the shortcuts with the ShortcutRegistry so that they are
    // available to the entire application, and update them if they've changed.
    _shortcutsEntry?.dispose();
    _shortcutsEntry =
        ShortcutRegistry.of(context).addAll(CUIMenuItem.shortcuts(result));
    return result;
  }
}
