import 'dart:ui';

import 'package:agrivigilance/app/constants/string.dart';
import 'package:agrivigilance/ui/views/authentication/sign_in/sign_in_view_model.dart';
import 'package:agrivigilance/ui/views/authentication/sign_in/widgets/anonymous_sign_in_button.dart';
import 'package:agrivigilance/ui/views/authentication/sign_in/widgets/google_sign_in_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInView extends StatelessWidget {
  const SignInView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignInViewModel>(
      create: (_) => SignInViewModel(context.read),
      builder: (_, child) {
        return const Scaffold(
          body: SignInViewBody._(),
        );
      },
    );
  }
}

class SignInViewBody extends StatelessWidget {
  const SignInViewBody._({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    precacheImage(
        new AssetImage("assets/images/black-concrete-wall.jpg"), context);
    final isLoading =
        context.select((SignInViewModel viewModel) => viewModel.isLoading);
    return Stack(
      children: [
        Container(
          width: double.infinity,
          child: Image.asset(
            "assets/images/black-concrete-wall.jpg",
            fit: BoxFit.fill,
          ),
        ),
        Center(child: isLoading ? _loadingIndicator() : signInWidget()),
      ],
    );
  }

  Center _loadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  // Column _signInButtons(BuildContext context) {
  //   return Column(
  //     children: <Widget>[
  //       Spacer(),
  //       AnonymousSignInButton(),
  //       SizedBox(
  //         height: 20,
  //       ),
  //       GoogleSignInButton(),
  //       Spacer(),
  //     ],
  //   );
  // }
}

class signInWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: new BackdropFilter(
        filter: new ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: new Container(
            width: 500,
            height: 600,
            decoration: new BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              border:
                  Border.all(width: 1, color: Colors.white.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(75),
                  child: Container(
                    decoration: new BoxDecoration(
                      color: Colors.white12,
                      border: Border.all(
                          width: 1, color: Colors.white.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(75),
                    ),
                    height: 150,
                    width: 150,
                    child: Transform.scale(
                      scale: 0.7,
                      child: Image.asset(
                        "assets/images/graduation.png",
                        color: Colors.white54,
                      ),
                    ),
                  ),
                ),
                inputForm(),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: SizedBox(
                    height: 50,
                    width: 300,
                    child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "LOGIN",
                          style: TextStyle(fontSize: 17),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO(84, 214, 190, 1),
                        )),
                  ),
                ),
                Column(
                  children: [
                    Divider(
                      color: Colors.white,
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        signInButton(GoogleSignInButton()),
                        signInButton(AnonymousSignInButton()),
                      ],
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}

class inputForm extends StatelessWidget {
  final snackBar = SnackBar(
      content:
          Text("乁(ツ゚)ㄏ Try remembering your password... We Won't help you!"));

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextFormField(
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.email_outlined,
                color: Colors.white,
              ),
              hintText: "Email",
              hintStyle: TextStyle(color: Colors.white),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
          TextFormField(
            obscureText: true,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.lock_outline,
                color: Colors.white,
              ),
              hintText: "Password",
              hintStyle: TextStyle(color: Colors.white),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: GestureDetector(
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(snackBar),
              child: Text(
                "Forgot Password?",
                style: TextStyle(color: Colors.grey[400]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class signInButton extends StatelessWidget {
  Widget child;
  signInButton(this.child);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        child: child,
        width: 200,
        height: 40,
      ),
    );
  }
}
