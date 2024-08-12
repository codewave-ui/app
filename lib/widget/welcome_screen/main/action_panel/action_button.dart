part of '../main.dart';

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final void Function() onPressed;

  const ActionButton(
      {super.key,
      required this.icon,
      required this.text,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Column(
        children: [
          ElevatedButton(
              onPressed: onPressed,
              style: const ButtonStyle(
                  padding: WidgetStatePropertyAll(
                      EdgeInsets.symmetric(vertical: 4, horizontal: 2)),
                  fixedSize: WidgetStatePropertyAll(Size(60, 60)),
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(10, 10))))),
              child: Icon(
                icon,
                size: 30,
              )),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            width: 60,
            child: Text(
              text,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
