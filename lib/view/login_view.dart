import 'package:flutter/material.dart';
import 'package:tryproject/view/login_view_model.dart';




class LoginView extends LoginViewModel {
    final EdgeInsets _paddinLow = EdgeInsets.all(8);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: _paddinLow,
        child: Center(
          child: Column(
            children: [
              Container(
          height: 70,
          width: 70,
          color: Colors.transparent,
          child:  Container(
            child: Column(
              children:[
                Text("SUPER",style: TextStyle(color: Colors.white,fontSize: 12),),
                Text("STARS",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15 ))
              ],
               mainAxisAlignment: MainAxisAlignment.center,
            ),
            decoration:  BoxDecoration(
              color: Colors.black,
              borderRadius:  BorderRadius.circular(8),

            ),),
            
            ),
          const  SizedBox(
              height: 15,
            ),
          const  Text("Login",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
          const  Text("Choose option",style: TextStyle(fontSize: 15,color: Colors.black38),),
          const  SizedBox(
              height: 100,
            ),
              Form(
                  key: _formKey,
                  child: Wrap(
                    runSpacing: 20,
                    alignment: WrapAlignment.center,
                    children: [
                      TextFormField(
                        controller: controllerEmail,
                        decoration:const InputDecoration(
                            labelText: "email", border: OutlineInputBorder()),
                      ),
                      TextFormField(
                        controller: controllerPassword,
                        decoration:const InputDecoration(
                            labelText: "password", border: OutlineInputBorder()),
                      ),
                     ElevatedButton(
                      
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.only(left: 150,right: 150,top:20 ,bottom:20 )),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            ))),
                onPressed: () {
                   if (_formKey.currentState!.validate()) {
                          
                         
                          fetchUserLogin(controllerEmail.text, controllerPassword.text);
                        
                          
                        }
                },
                child:const Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                )),
                     

                      
                    ],
                  )),
                  SizedBox(height: 50,),
                  Text("Don't have an accaunt?",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                  ElevatedButton(
                    
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(const EdgeInsets.only(left: 30,right: 30)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            )),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)
                    ),
                    onPressed: (){},
                   child: Text("Sign up"),)
            ],
          ),
        ),
      ),
    );
  }
}

