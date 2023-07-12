// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:riloi_web/shared/widgets/widgets.dart';
import 'package:riloi_web/shared/utils/send_post.dart';
import 'package:riloi_web/app/app.dart';
import 'dart:js' as js;

class Store extends StatefulWidget {
  const Store({super.key});

  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> {
  var uuid = "";
  String name = "";
  List goodsList = [];
  bool isLogin = false;

  init() {
    Future(() async {
      Response response =
          await sendPostRequest("http://localhost/logincheck", {});
      print(response.data["message"]);
      if (response.data["message"] == "Logged in") {
        setState(() {
          uuid = response.data["uuid"];
          name = response.data["name"];
        });
      } else {
        setState(() {
          uuid = "";
        });
      }
    });
    Future(() async {
      Response response =
          await sendPostRequest("http://localhost/goods_list", {});
      print(response.data["message"]);
      if (response.data["message"] == "success") {
        setState(() {
          goodsList = response.data["goods_list"];
          print(goodsList);
        });
      } else {
        setState(() {
          goodsList = [];
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // int grid = size.height > size.width ? 1 : 2;
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.delta.dx > 18) {
          Navigator.pop(context);
        }
      },
      child: Stack(
        children: [
          backGround(),
          Hero(
              tag: "Store-background",
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).primaryColor.withOpacity(0.8)),
                    color: Theme.of(context).primaryColor.withOpacity(0.4)),
              )),
          Scaffold(
            backgroundColor: const Color(0x00000000),
            body: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  centerTitle: true,
                  pinned: true,
                  leading: const backButton(),
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(0.35),
                  title: Hero(
                    tag: "store-text",
                    child: Text(
                      "STORE",
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PopupMenuButton(
                        onSelected: (value) {},
                        offset: const Offset(0, 35),
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: uuid == "" ? "ゲスト" : name,
                                style: size.height > size.width
                                    ? Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(fontWeight: FontWeight.bold)
                                    : Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                            fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: "さん",
                                style: Theme.of(context).textTheme.labelSmall)
                          ]),
                        ),
                        itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                          PopupMenuItem(
                              child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: uuid == "" ? "ゲスト" : name,
                                  style: size.height > size.width
                                      ? Theme.of(context)
                                          .textTheme
                                          .labelLarge
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold)
                                      : Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: "さん",
                                  style: Theme.of(context).textTheme.labelSmall)
                            ]),
                          )),
                          const PopupMenuItem(
                            value: "logout",
                            child: Text('logout'),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SliverToBoxAdapter(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              if (uuid == "") {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return LoginDialog(
                                        onLogin: (email, password) async {
                                          await sendPostRequest(
                                              "http://localhost/login", {
                                            "email": email,
                                            "password": password
                                          });
                                          init();
                                        },
                                      );
                                    });
                              } else {
                                try {
                                  await sendPostRequest(
                                      "http://localhost/logout", {});
                                } catch (e) {
                                  js.context.callMethod(
                                      'alert', ['Hello from Dart!']);
                                }
                                init();
                              }
                            },
                            child: Text(uuid == "" ? "Login" : "Logout"),
                          ),
                          uuid != ""
                              ? const SizedBox.shrink()
                              : ElevatedButton(
                                  onPressed: () async {},
                                  child: const Text("Sign up"))
                        ],
                      ),
                      Text(uuid)
                    ],
                  ),
                ),
                SliverGrid.extent(
                  childAspectRatio: 350 / 410,
                  maxCrossAxisExtent: 350,
                  children: goodsList.map((e) {
                    return GestureDetector(
                      onTap: () {
                        RiloiWEB.router
                            ?.navigateTo(context, '/store/${e["Id"]}');
                      },
                      child: OnHover(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Theme.of(context).cardColor,
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 8, 8, 0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: e["Img_path"]["Valid"]
                                        ? Image.network(e["Img_path"])
                                        : Image.asset(
                                            "assets/images/noimage.webp"),
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  e["Name"],
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                                Text(
                                    e["Price"] == -1
                                        ? "ユーザーによる選択"
                                        : e["Price"].toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium),
                                const Spacer(
                                  flex: 2,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                )
              ],
            ),
            floatingActionButton: const ActionButton(),
          ),
        ],
      ),
    );
  }
}

class LoginDialog extends StatefulWidget {
  final Function(String email, String password) onLogin;

  const LoginDialog({Key? key, required this.onLogin}) : super(key: key);

  @override
  State<LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('ログイン'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'メールアドレス'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'メールアドレスを入力してください';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(labelText: 'パスワード'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'パスワードを入力してください';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value!;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('キャンセル'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              widget.onLogin(_email, _password);
              Navigator.pop(context);
            }
          },
          child: const Text('ログイン'),
        ),
      ],
    );
  }
}

class RegisterDialog extends StatefulWidget {
  @override
  _RegisterDialogState createState() => _RegisterDialogState();
}

class _RegisterDialogState extends State<RegisterDialog> {
  final _formKey = GlobalKey<FormState>();

  String _firstName = '';
  String _lastName = '';
  String _displayName = '';
  String _email = '';
  String _memberType = '';
  String _password = '';
  String _passwordConfirm = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('会員登録'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: '性',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return '必須項目です';
                  }
                  return null;
                },
                onSaved: (value) {
                  _firstName = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: '名',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return '必須項目です';
                  }
                  return null;
                },
                onSaved: (value) {
                  _lastName = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: '表示名',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return '必須項目です';
                  }
                  return null;
                },
                onSaved: (value) {
                  _displayName = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'メールアドレス',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return '必須項目です';
                  }
                  if (!value.contains('@')) {
                    return '有効なメールアドレスを入力してください';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: '会員タイプ',
                ),
                value: _memberType,
                onChanged: (newValue) {
                  setState(() {
                    _memberType = newValue!;
                  });
                },
                items: const [
                  DropdownMenuItem(
                    value: '一般会員',
                    child: Text('一般会員'),
                  ),
                  DropdownMenuItem(
                    value: 'プレミアム会員',
                    child: Text('プレミアム会員'),
                  ),
                ],
                validator: (value) {
                  if (value == null) {
                    return '必須項目です';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'パスワード',
                ),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return '必須項目です';
                  }
                  if (value.length < 6) {
                    return 'パスワードは6文字以上で入力してください';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'パスワード（確認）',
                ),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return '必須項目です';
                  }
                  if (value != _password) {
                    return 'パスワードが一致しません';
                  }
                  return null;
                },
                onSaved: (value) {
                  _passwordConfirm = value!;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('キャンセル'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();

              // フォームに入力されたデータを使って、会員登録の処理を実行する
              // ...

              Navigator.pop(context);
            }
          },
          child: const Text('登録'),
        ),
      ],
    );
  }
}
