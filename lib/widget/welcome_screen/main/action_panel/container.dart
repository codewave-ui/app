part of '../main.dart';

class WelcomeScreenActionPanelContainer extends StatelessWidget {
  const WelcomeScreenActionPanelContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: AssetImage("assets/logo.png"),
          height: 150,
          width: 150,
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          "Codewave UI",
          textScaler: TextScaler.linear(2),
        ),
        Text("Version 2024.0.1"),
        SizedBox(
          height: 25,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ActionButton(
                icon: Icons.add,
                text: "New Project",
                onPressed: () {
                  Navigator.of(context).pushNamed('/welcome/new');
                }),
            ActionButton(
                icon: Icons.folder_open,
                text: "Open Project",
                onPressed: () async {
                  Navigator.of(context).pushNamed('/welcome/open');
                }),
            ActionButton(
                icon: Icons.code,
                text: "Git",
                onPressed: () {
                  context.read<ThemeCubit>().toggleBrightness();
                }),
          ],
        ),
      ],
    ));
  }
}
