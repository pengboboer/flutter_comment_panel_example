import 'package:flutter/material.dart';
import 'package:flutter_comment_panel_example/content_page.dart';
import 'package:provider/provider.dart';

import 'comment/detail/model.dart';
import 'comment/list/model.dart';
import 'comment/panel/model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CommentPanelModel()),
        ChangeNotifierProvider(create: (_) => CommentListModel()),
        ChangeNotifierProvider(create: (_) => CommentDetailModel()),
      ],
      child: MaterialApp(
        title: 'Flutter Comment Panel Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        navigatorKey: AppGlobal.navigationKey,
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main Page"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return const ContentPage();
            }));
          },
          child: const Text("to content page"),
        ),
      ),
    );
  }
}

class AppGlobal {
  static GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  static BuildContext get context => navigationKey.currentState!.context;

  static T read<T>() {
    return context.read<T>();
  }
}
