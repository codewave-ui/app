import 'package:flutter/material.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
import 'package:path_drawing/path_drawing.dart';

part 'project_content.model.dart';

class CUIProjectView extends StatefulWidget {
  const CUIProjectView({super.key});

  @override
  State<CUIProjectView> createState() => _CUIProjectViewState();
}

class _CUIProjectViewState extends State<CUIProjectView> {
  late List<MyTreeNode> roots;
  late TreeController<MyTreeNode> treeController;

  @override
  void initState() {
    roots = [
      new MyTreeNode(title: "Parent 1", children: [
        new MyTreeNode(title: 'Children 1', children: [
          new MyTreeNode(title: "Sub Children 1"),
          new MyTreeNode(title: "Sub Children 2"),
        ]),
        new MyTreeNode(title: 'Children 2'),
      ]),
      new MyTreeNode(title: "Parent 2")
    ];
    treeController = TreeController<MyTreeNode>(
      roots: roots,
      childrenProvider: (MyTreeNode node) => node.children,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.surfaceContainer,
      child: Center(
          child: AnimatedTreeView<MyTreeNode>(
        duration: const Duration(milliseconds: 100),
        treeController: treeController,
        nodeBuilder: (BuildContext context, TreeEntry<MyTreeNode> entry) {
          return InkWell(
            onTap: () {
              if (entry.hasChildren) {
                treeController.toggleExpansion(entry.node);
              } else {
                print("DOUBLE TAP");
              }
            },
            // onDoubleTap: () => print("DOUBLE TAP"),
            child: TreeIndentation(
              guide: IndentGuide.connectingLines(
                indent: 40,
                color: Theme.of(context).colorScheme.outline,
                thickness: 1,
                origin: 0.5,
                strokeCap: StrokeCap.round,
                pathModifier: (Path path) => dashPath(
                  path,
                  dashArray: CircularIntervalList(const [6, 4]),
                  dashOffset: const DashOffset.absolute(6 / 4),
                ),
              ),
              entry: entry,
              child: HoveredTreeNode(
                  child: Row(
                children: [
                  Icon(size: 20, entry.node.icon),
                  const SizedBox(height: 24, width: 8),
                  Flexible(
                    child: Text(entry.node.title),
                  ),
                ],
              )),
            ),
          );
        },
      )),
    );
  }
}

// class CUIProjectView extends StatelessWidget {
//   const CUIProjectView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return ColoredBox(
//       color: Theme.of(context).colorScheme.surfaceContainer,
//       child: Center(
//         child: Text("PROJECT_VIEW"),
//       ),
//     );
//   }
// }

class HoveredTreeNode extends StatefulWidget {
  final Widget child;

  const HoveredTreeNode({super.key, required this.child});

  @override
  State<HoveredTreeNode> createState() => _HoveredTreeNodeState();
}

class _HoveredTreeNodeState extends State<HoveredTreeNode> {
  bool isHovered = false;

  @override
  void didChangeDependencies() {
    // print(isHovered);
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      child: DecoratedBox(
          decoration: BoxDecoration(
              color: isHovered
                  ? Theme.of(context).colorScheme.outlineVariant
                  : null),
          child: widget.child),
      onEnter: (e) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (e) {
        setState(() {
          isHovered = false;
        });
      },
    );
  }
}
