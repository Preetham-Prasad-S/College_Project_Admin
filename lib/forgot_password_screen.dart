import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(246, 247, 249, 1),
      body: Center(
        child: SizedBox(
          height:500   ,
          width: 380   ,
          child: Card(
             color: Colors.white,
             shadowColor: Color.fromRGBO(63, 136, 255, 0.444),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.only(left: 18,top: 22,right: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [     
                
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: IconButton(icon: Icon(Icons.arrow_back),
                  iconSize:25 ,
                  color: Color.fromRGBO(16, 106, 233, 1),
                  
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text("Reset Password",
                  style: TextStyle(color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w900),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text("Enter your registered email to receive a reset link",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromRGBO(104, 130, 156, 1)
                   ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text("EMAIL ADDRESS",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: TextField(
                    style: TextStyle(
                      color: Colors.black
                    ),
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.mail,color: Color.fromRGBO(98, 114, 137, 1),),
                      hintText: "staff.name@college.edu",
                      enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: const Color.fromARGB(255, 219, 217, 217),
                        style: BorderStyle.solid,
                        width: 1.2
                      ),
                      borderRadius: BorderRadius.circular(8)

                      ),
                      focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: 1.2,
                      ),
                       borderRadius: BorderRadius.circular(8)
                      )
                    ),
                    
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 70),
                  child: ElevatedButton(onPressed: (){
                    
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(8)),
                    fixedSize: Size(350, 50),
                    backgroundColor: const Color.fromRGBO(20, 109, 237, 1)
                  )
                  ,child: Text("Send Reset Link",
                  style: TextStyle(color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
                  )
                  ),
                ),
                Center(
                  child: RichText(
                    text: TextSpan(
                    style: TextStyle(color: Colors.black,
                    fontSize: 15.5),
                    
                    children: [
                      TextSpan(text: "Having trouble? ",
                      style: TextStyle(color: Color.fromRGBO(93, 105, 117, 1),
                      fontWeight: FontWeight.bold)
                      ),
                      TextSpan(text: "Contact IT Support",
                      style: TextStyle(color: const Color.fromARGB(255, 0, 94, 255),
                      fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                      ..onTap = (){
                       print("navigate");
                      }
                      ),
                    ]
                  ),
                                ),
                ),

                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}
