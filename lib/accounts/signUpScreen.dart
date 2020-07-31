import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpScreen extends StatefulWidget {
  static final String route = "/sign-up";

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isLoading = false;
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;

  String _username;

  String _password;

  var _passwordFocus = FocusNode();

  GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();

  void saveForm() {
    bool isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    print(_username + _password);
    // Sign Up Logic
    signUp(_username, _password);
  }

  void signUp(String username, String password) async {
    AuthResult authResult;
    try {
      setState(() {
        isLoading = true;
      });
      authResult = await _auth.createUserWithEmailAndPassword(
          email: _username, password: _password);
      Firestore.instance
          .collection('users')
          .document(authResult.user.uid)
          .setData({
        "username": authResult.user.uid,
        "email": username,
      });
    } on PlatformException catch (err) {
      setState(() {
        isLoading = false;
      });
      String message = "Please check your credentials!";
      if (err.message != null) {
        message = err.message;
      }
      _scaffold.currentState.showSnackBar(SnackBar(content: Text(message)));
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      body: Container(
        color: Theme.of(context).primaryColor,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Card(
            color: Theme.of(context).backgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        Text(
                          "GO BACK",
                          style: Theme.of(context).textTheme.subtitle1,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    TextFormField(
                      onSaved: (value) => _username = value,
                      decoration: InputDecoration(
                        labelText: "Username",
                      ),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(_passwordFocus),
                    ),
                    TextFormField(
                      onSaved: (value) => _password = value,
                      focusNode: _passwordFocus,
                      validator: (value) {
                        if (value.length < 8) {
                          return "Password must be of at least 8 characters!";
                        }
                      },
                      onFieldSubmitted: (_) => saveForm,
                      decoration: InputDecoration(
                        labelText: "Password",
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                    ),
                    isLoading
                        ? Center(
                            child: Container(
                              padding: EdgeInsets.all(20),
                              child: CircularProgressIndicator(
                                backgroundColor: Theme.of(context).primaryColor,
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: RaisedButton(
                              child: Text(
                                "SIGN UP",
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              color: Theme.of(context).primaryColor,
                              onPressed: () {
                                saveForm();
                              },
                            ),
                          )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
