part of 'main.dart';

class MyTreeNode {
  const MyTreeNode({
    this.icon = Icons.file_open_outlined,
    required this.title,
    this.children = const <MyTreeNode>[],
  });

  final String title;
  final List<MyTreeNode> children;
  final IconData? icon;
}
