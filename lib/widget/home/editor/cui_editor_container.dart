import 'package:codewave_ui/widget/home/editor/active_editor_view/main.dart';
import 'package:codewave_ui/widget/home/editor/log_view/main.dart';
import 'package:codewave_ui/widget/home/editor/project_view/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_resizable_container/flutter_resizable_container.dart';

class CUIEditorContainer extends StatefulWidget {
  const CUIEditorContainer({super.key});

  @override
  State<CUIEditorContainer> createState() => _CUIEditorContainerState();
}

class _CUIEditorContainerState extends State<CUIEditorContainer> {
  bool isVerticalResizeableDividerHovered = false;
  bool isHorizontalResizeableDividerHovered = false;

  @override
  Widget build(BuildContext context) {
    return ResizableContainer(
        divider: ResizableDivider(
            color: isVerticalResizeableDividerHovered
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.inversePrimary,
            thickness: 2,
            size: 14,
            onHoverEnter: () => setState(() {
                  isVerticalResizeableDividerHovered = true;
                }),
            onHoverExit: () => setState(() {
                  isVerticalResizeableDividerHovered = false;
                })),
        children: [
          ResizableChild(
              child: CUIProjectView(), size: ResizableSize.pixels(500)),
          ResizableChild(
              size: ResizableSize.expand(),
              child: ResizableContainer(
                divider: ResizableDivider(
                    thickness: 2,
                    size: 14,
                    color: isHorizontalResizeableDividerHovered
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.inversePrimary,
                    onHoverEnter: () => setState(() {
                          isHorizontalResizeableDividerHovered = true;
                        }),
                    onHoverExit: () => setState(() {
                          isHorizontalResizeableDividerHovered = false;
                        })),
                direction: Axis.vertical,
                children: [
                  ResizableChild(
                      child: CUIActiveEditorView(),
                      size: ResizableSize.expand()),
                  ResizableChild(
                      child: CUILogView(), size: ResizableSize.ratio(0.3))
                ],
              ))
        ],
        direction: Axis.horizontal);
  }
}

// TODO CONTINUE THIS FROM https://pub.dev/packages/flutter_resizable_container https://andyhorn.github.io/flutter_resizable_container/#divider
