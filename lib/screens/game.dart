import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plataform_channel_game/constants/colors.dart';
import 'package:plataform_channel_game/constants/styles.dart';
import 'package:plataform_channel_game/models/creator.dart';

class GameWidget extends StatefulWidget {
  const GameWidget({Key? key}) : super(key: key);

  @override
  State<GameWidget> createState() => _GameWidgetState();
}

class _GameWidgetState extends State<GameWidget> {
  Creator? creator;
  bool minhaVez = false;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(700, 1400));

    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Container(
                    width: ScreenUtil().setWidth(550),
                    height: ScreenUtil().setHeight(550),
                    color: colorLightBlue1,
                  ),
                  Container(
                    width: ScreenUtil().setWidth(150),
                    height: ScreenUtil().setHeight(550),
                    color: colorMediumBlue2,
                  ),
                ],
              ),
              Container(
                width: ScreenUtil().setWidth(700),
                height: ScreenUtil().setHeight(850),
                color: colorDarkBlue3,
              )
            ],
          ),
          Container(
            height: ScreenUtil().setHeight(1400),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                creator == null
                    ? Row(mainAxisSize: MainAxisSize.min, children: [
                        buildButton("Criar", true),
                        SizedBox(width: 10),
                        buildButton("Entrar", false),
                      ])
                    : InkWell(
                        child: Text(
                            minhaVez == true
                                ? "Faça sua jogada"
                                : "Aguarde sua vez",
                            style: textStyle36),
                      )
              ],
            )),
          )
        ],
      ),
    ));
  }

  Widget buildButton(String label, bool owner) => Container(
        width: ScreenUtil().setWidth(300),
        child: ElevatedButton(
          child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(label, style: textStyle36)),
          onPressed: () {
            createGame(owner);
          },
        ),
      );

  Future createGame(bool owner) async {
    TextEditingController controller = TextEditingController();
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Qual o nome do jogo?"),
            content: TextField(controller: controller),
            actions: [
              ElevatedButton(
                  child: const Text("Jogar"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _sendAction('subscribe', {'channel': controller.text});
                    //.then((value))
                    setState(() {
                      creator = Creator(owner, controller.text);
                      minhaVez = owner;
                    });
                  })
            ],
          );
        });
  }

  Future _sendAction(String action, Map<String, dynamic> arguments) async {}
}
