import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
 
}
class MyApp extends StatelessWidget{
  const MyApp({super.key});
  @override
  Widget build(BuildContext context){
    return MaterialApp (
      title: 'Login Page',
      home: const ProfilePage(),
      debugShowCheckedModeBanner: false,
    );
    }
  }

  class ProfilePage extends StatefulWidget{
    const ProfilePage({super.key});

    @override
    State<ProfilePage> createState() => _ProfilePageState();
  }

  class _ProfilePageState extends State<ProfilePage> {
    bool rememberMe = false;

    @override
    Widget build(BuildContext context){
      return Scaffold(
        body: Center(
          child:Container(
            width: 320,
            padding:const EdgeInsets.all(20),
            decoration:BoxDecoration(
              color:Colors.deepOrange,
              borderRadius:BorderRadius.circular(20),
              boxShadow:const[
                BoxShadow(
                  color :Colors.black12,
                  blurRadius:10,
                  offset: Offset(0,4),
                )
              ]

            ),
            child: Column(
              mainAxisSize:MainAxisSize.min,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('images/image.png'),
                
                  ),
                  const Text(
                    "Login",
                    style:TextStyle(fontSize:28,fontWeight:FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      labelText:"Username",
                      border:OutlineInputBorder()

                    )
                  ),
                  const SizedBox (height:12),
                  TextField (
                    decoration:InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      labelText:"Password",
                      border:OutlineInputBorder()
                    )
                  ),
                  const SizedBox(height:12),
                  Row(
                    children: [
                      Checkbox(
                        value: rememberMe,
                        onChanged: (value) {
                          setState(() {
                            rememberMe = value ?? false;
                          });
                        },
                      ),
                      const Text("Remember me"),
                    ],
                  ),
                  const SizedBox(height:18),
                  SizedBox(
                    width:double.infinity,//what is this for?
                    child :ElevatedButton(
                      onPressed: (){},
                       child: const Text("Login")
                      )
                  )


              ],
          )
          )
        )
      );
    }
  }





