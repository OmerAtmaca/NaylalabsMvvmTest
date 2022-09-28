import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tryproject/core/shared_manager.dart';
import 'package:tryproject/services/login_service.dart';
import 'package:tryproject/view/action_view.dart';
import 'package:tryproject/view/profile_view.dart';
import 'package:tryproject/view/stories_view.dart';
import 'network_view.dart';

class MainManuView extends StatefulWidget {
  const MainManuView({super.key});

  @override
  State<MainManuView> createState() => _MainManuViewState();
}

class _MainManuViewState extends State<MainManuView> {
  int tabIndex = 0;
  List<Widget> viewScreen = [];
  String? profPicture;
  String? token;
  int _selectedPage=0;


  
late LoginService loginService;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginService=LoginService();

    getUserProfPicture();
  }

  getUserProfPicture() async {
    var dataPicture=await SharedManager.instance.getStringValue(SharedKeys.PICTURE);
    setState(() {
      profPicture=dataPicture;
    });
  } 
 PageController _myPage = PageController(initialPage: 0);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        
        notchMargin: 6,
        elevation: 10,
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 75,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                color: _selectedPage==0?Colors.green:Colors.grey,
                iconSize: 30.0,
          
                icon: FaIcon(FontAwesomeIcons.film, size: 30),
                onPressed: () {
                  setState(() {
                    _myPage.jumpToPage(0);
                  });
                },
              ),
              IconButton(
                color: _selectedPage==1?Colors.green:Colors.grey,
                iconSize: 30.0,
         
                icon: FaIcon(FontAwesomeIcons.clapperboard, size: 30),
                onPressed: () {
                  setState(() {
                    _myPage.jumpToPage(1);
                  });
                },
              ),
              IconButton(
                color: _selectedPage==2?Colors.green:Colors.grey,
                iconSize: 50.0,
                icon: FaIcon(FontAwesomeIcons.networkWired, size: 30),
                onPressed: () {
                  setState(() {
                    _myPage.jumpToPage(2);
                    
                  });
                },
              ),
            InkWell(
              onTap: (){
                setState(() {
                    _myPage.jumpToPage(3);
                    
                  });
              },
              child: Column(
                children: [
                  Stack(
                        children: [
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: _selectedPage==3?Colors.green:Colors.grey,
                          child:   
                          CircleAvatar(
                            radius: 15,
                            backgroundImage:NetworkImage(profPicture??"",scale: 0.5) ,
                            
                      ),)
                        
                        ],
                      ),
                      Text("Me")
                ],
              ),
            ),
             
            ],
          ),
        ),
      ),
      body: PageView(
        
      
        scrollDirection: Axis.horizontal, 
        controller: _myPage,

        onPageChanged: (int index) {
         setState(() {
              _selectedPage=index;
         });
         

        },
        children: [
        StoriesView(),
        ActionView(),
        NetworkView(),
        ProfileView(),
        ],
      // Comment this if you need to use Swipe.
      ),
      floatingActionButton: Container(
        height: 60.0,
        width: 60.0,
        
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: Colors.green,
            onPressed: () {},
            child: Icon(
              Icons.camera_alt_sharp,
              color: Colors.white,
            ),
            // elevation: 5.0,
          ),
        ),
      ),
    );
   
  
  }


}


