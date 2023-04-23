import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
import 'package:riloi_web/shared/widgets/widgets.dart';
// import 'package:riloi_web/shared/utils/send_post.dart';
// import 'package:riloi_web/app/app.dart';
// import 'dart:js' as js;

class Store extends StatefulWidget {
  const Store({super.key});

  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> {
  @override
  Widget build(BuildContext context) {
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
              tag: "store-background",
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
                ),
                SliverToBoxAdapter(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("ストアは現在作成中です。"),
                      Text("急ピッチで作成していますので今しばらくお持ちください。")
                    ],
                  ),
                )
              ],
            ),
            floatingActionButton: const ActionButton(),
          ),
        ],
      ),
    );
  }
  // var uuid = "";
  // String name = "";
  // List goods_list = [];
  // bool isLogin = false;

  // init() {
  //   Future(() async {
  //     Response response =
  //         await sendPostRequest("http://localhost/logincheck", {});
  //     print(response.data["message"]);
  //     if (response.data["message"] == "Logged in") {
  //       setState(() {
  //         uuid = response.data["uuid"];
  //         name = response.data["name"];
  //       });
  //     } else {
  //       setState(() {
  //         uuid = "";
  //       });
  //     }
  //   });
  //   Future(() async {
  //     Response response =
  //         await sendPostRequest("http://localhost/goods_list", {});
  //     print(response.data["message"]);
  //     if (response.data["message"] == "success") {
  //       setState(() {
  //         goods_list = response.data["goods_list"];
  //         print(goods_list);
  //       });
  //     } else {
  //       setState(() {
  //         goods_list = [];
  //       });
  //     }
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   init();
  // }

  // @override
  // Widget build(BuildContext context) {
  //   final Size size = MediaQuery.of(context).size;
  //   // int grid = size.height > size.width ? 1 : 2;
  //   return GestureDetector(
  //     onHorizontalDragUpdate: (details) {
  //       if (details.delta.dx > 18) {
  //         Navigator.pop(context);
  //       }
  //     },
  //     child: Stack(
  //       children: [
  //         backGround(),
  //         Hero(
  //             tag: "Store-background",
  //             child: Container(
  //               decoration: BoxDecoration(
  //                   border: Border.all(
  //                       color: Theme.of(context).primaryColor.withOpacity(0.8)),
  //                   color: Theme.of(context).primaryColor.withOpacity(0.4)),
  //             )),
  //         Scaffold(
  //           backgroundColor: const Color(0x00000000),
  //           body: CustomScrollView(
  //             physics: const BouncingScrollPhysics(),
  //             slivers: [
  //               SliverAppBar(
  //                 centerTitle: true,
  //                 pinned: true,
  //                 leading: const backButton(),
  //                 backgroundColor:
  //                     Theme.of(context).primaryColor.withOpacity(0.35),
  //                 title: Hero(
  //                   tag: "store-text",
  //                   child: Text(
  //                     "STORE",
  //                     style: Theme.of(context).textTheme.displaySmall,
  //                   ),
  //                 ),
  //                 actions: [
  //                   Padding(
  //                     padding: const EdgeInsets.all(8.0),
  //                     child: PopupMenuButton(
  //                       onSelected: (value) {},
  //                       offset: const Offset(0, 35),
  //                       child: RichText(
  //                         text: TextSpan(children: [
  //                           TextSpan(
  //                               text: uuid == "" ? "ゲスト" : name,
  //                               style: size.height > size.width
  //                                   ? Theme.of(context)
  //                                       .textTheme
  //                                       .labelLarge
  //                                       ?.copyWith(fontWeight: FontWeight.bold)
  //                                   : Theme.of(context)
  //                                       .textTheme
  //                                       .titleLarge
  //                                       ?.copyWith(
  //                                           fontWeight: FontWeight.bold)),
  //                           TextSpan(
  //                               text: "さん",
  //                               style: Theme.of(context).textTheme.labelSmall)
  //                         ]),
  //                       ),
  //                       itemBuilder: (BuildContext context) => <PopupMenuEntry>[
  //                         PopupMenuItem(
  //                             child: RichText(
  //                           text: TextSpan(children: [
  //                             TextSpan(
  //                                 text: uuid == "" ? "ゲスト" : name,
  //                                 style: size.height > size.width
  //                                     ? Theme.of(context)
  //                                         .textTheme
  //                                         .labelLarge
  //                                         ?.copyWith(
  //                                             fontWeight: FontWeight.bold)
  //                                     : Theme.of(context)
  //                                         .textTheme
  //                                         .titleLarge
  //                                         ?.copyWith(
  //                                             fontWeight: FontWeight.bold)),
  //                             TextSpan(
  //                                 text: "さん",
  //                                 style: Theme.of(context).textTheme.labelSmall)
  //                           ]),
  //                         )),
  //                         const PopupMenuItem(
  //                           value: "logout",
  //                           child: Text('logout'),
  //                         ),
  //                       ],
  //                     ),
  //                   )
  //                 ],
  //               ),
  //               SliverToBoxAdapter(
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     ElevatedButton(
  //                       onPressed: () async {
  //                         if (uuid == "") {
  //                           showDialog(
  //                               context: context,
  //                               builder: (context) {
  //                                 return LoginDialog(
  //                                   onLogin: (email, password) async {
  //                                     await sendPostRequest(
  //                                         "http://localhost/login", {
  //                                       "email": email,
  //                                       "password": password
  //                                     });
  //                                     init();
  //                                   },
  //                                 );
  //                               });
  //                         } else {
  //                           try {
  //                             await sendPostRequest(
  //                                 "http://localhost/logout", {});
  //                           } catch (e) {
  //                             js.context
  //                                 .callMethod('alert', ['Hello from Dart!']);
  //                           }
  //                           init();
  //                         }
  //                       },
  //                       child: Text(uuid == "" ? "Login" : "Logout"),
  //                     ),
  //                     Text(uuid)
  //                   ],
  //                 ),
  //               ),
  //               SliverGrid.extent(
  //                 childAspectRatio: 350 / 410,
  //                 maxCrossAxisExtent: 350,
  //                 children: goods_list.map((e) {
  //                   return GestureDetector(
  //                     onTap: () {
  //                       RiloiWEB.router
  //                           ?.navigateTo(context, '/store/${e["Id"]}');
  //                     },
  //                     child: OnHover(
  //                       child: Padding(
  //                         padding: const EdgeInsets.all(8.0),
  //                         child: Container(
  //                           decoration: BoxDecoration(
  //                             borderRadius: BorderRadius.circular(8),
  //                             color: Theme.of(context).cardColor,
  //                           ),
  //                           child: Column(
  //                             children: [
  //                               Padding(
  //                                 padding:
  //                                     const EdgeInsets.fromLTRB(8, 8, 8, 0),
  //                                 child: ClipRRect(
  //                                   borderRadius: BorderRadius.circular(8),
  //                                   child: e["Img_path"]["Valid"]
  //                                       ? Image.network(e["Img_path"])
  //                                       : Image.asset(
  //                                           "assets/images/noimage.webp"),
  //                                 ),
  //                               ),
  //                               const Spacer(),
  //                               Text(
  //                                 e["Name"],
  //                                 style:
  //                                     Theme.of(context).textTheme.headlineSmall,
  //                               ),
  //                               Text(
  //                                   e["Price"] == -1
  //                                       ? "ユーザーによる選択"
  //                                       : e["Price"].toString(),
  //                                   style: Theme.of(context)
  //                                       .textTheme
  //                                       .titleMedium),
  //                               const Spacer(
  //                                 flex: 2,
  //                               )
  //                             ],
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   );
  //                 }).toList(),
  //               )
  //             ],
  //           ),
  //           floatingActionButton: const ActionButton(),
  //         ),
  //       ],
  //     ),
  //   );
  // }
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
