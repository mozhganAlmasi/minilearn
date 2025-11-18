import 'package:educationofchildren/config/theme/theme.dart';
import 'package:educationofchildren/feature/lessons/presentation/pages/select_quiz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'config/theme/colors.dart';
import 'core/utils/app_size.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Mozhgan Almasi',
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if(constraints.maxWidth <constraints.maxHeight)
          {
            AppSize.width = constraints.maxWidth;
            AppSize.height = constraints.maxHeight;
          }else{
          AppSize.width = constraints.maxHeight;
          AppSize.height = constraints.maxWidth;
        }

        AppSize.applySizes();

        return const SafeArea(
          child: SelectQuiz(),
        );
      },
    );
  }
}
