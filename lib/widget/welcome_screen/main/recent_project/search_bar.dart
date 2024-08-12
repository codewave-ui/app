part of '../main.dart';

class RecentProjectSearchBar extends StatefulWidget {
  final void Function(String value) onChanged;

  const RecentProjectSearchBar({super.key, required this.onChanged});

  @override
  State<RecentProjectSearchBar> createState() => _RecentProjectSearchBarState();
}

class _RecentProjectSearchBarState extends State<RecentProjectSearchBar> {
  final CUIDebouncer debouncer = CUIDebouncer(milliseconds: 350);

  _RecentProjectSearchBarState();

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      onChanged: (value) => debouncer.run(() => widget.onChanged(value)),
      autoFocus: true,
      leading: const Icon(Icons.search),
      padding: const WidgetStatePropertyAll<EdgeInsets>(
          EdgeInsets.symmetric(horizontal: 16.0)),
      elevation: const WidgetStatePropertyAll(0.0),
      constraints: BoxConstraints.tight(const Size(390, 35)),
      shape: const WidgetStatePropertyAll(RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.elliptical(10, 10)))),
    );
  }
}
