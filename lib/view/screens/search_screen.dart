import 'package:flutter/material.dart';
import 'package:tiktok_yt/controller/searchUser_controller.dart';
import 'package:tiktok_yt/model/user.dart';
import 'package:tiktok_yt/view/screens/profile_screen.dart';
import 'package:tiktok_yt/view/widgets/text_input.dart';
import 'package:get/get.dart';
class SearchScreen extends StatelessWidget {
   SearchScreen({Key? key}) : super(key: key);
TextEditingController searchQuery = TextEditingController();

final SearchController searchController = Get.put(SearchController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 70,
            backgroundColor: Colors.grey.shade50,
            foregroundColor: Colors.black,
            elevation: 0,
            title: TextFormField(
              cursorColor: Colors.black,
              style: TextStyle(color: Colors.black),
                decoration: new InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade300,
                
                  prefixIcon: Icon(Icons.search, color: Colors.grey.shade700,),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                    // border: InputBorder.none,
                    // focusedBorder: InputBorder.none,
                    // enabledBorder: InputBorder.none,
                    // errorBorder: InputBorder.none,
                    // disabledBorder: InputBorder.none,
                    contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                    hintText: "Search Username",
                    hintStyle: TextStyle(color: Colors.grey),
                )
            ,controller: searchQuery , onFieldSubmitted: (value){
              searchController.searchUser(value);
            },),


          ),
          body:  searchController.searchedUsers.isEmpty ?   Center(
            child: Text("Search Users!", style: TextStyle(color: Colors.green),),
          ) :
          ListView.builder(
              itemCount: searchController.searchedUsers.length,
              itemBuilder: (context, index){
            myUser user = searchController.searchedUsers[index];

            return ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen(uid: user.uid)));
              },
              leading: CircleAvatar(
                backgroundImage: NetworkImage(

                  user.profilePhoto
                ),
              ),

              title: Text(user.name),

            );
          })
          ,
        );
      }
    );
  }
}
