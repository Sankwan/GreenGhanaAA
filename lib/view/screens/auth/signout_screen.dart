import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_yt/view/widgets/text_input.dart';

import '../../../controller/auth_controller.dart';

class SignoutScreen extends StatelessWidget {
   SignoutScreen({super.key});
  final TextEditingController _numberController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade50,
        foregroundColor: Colors.black,
        elevation: 0,
        title: Text(
          'Settings and more',
          style: TextStyle(fontSize: 15),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  'Hello, ',
                  style: TextStyle(fontSize: 25, color: Colors.black),
                ),
                Text(
                  'User',
                  style: TextStyle(fontSize: 25, color: Colors.black),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              color: Colors.grey,
              thickness: 0.5,
            ),
           
            Text(
              'Edit Profile',
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),

            SizedBox(
              height: 20,
            ),
            Center(
              child: InkWell(
                  onTap: () {
                    AuthController.instance.pickImage();
                  },
                  child: Stack(
                    children: [
                      const CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://st3.depositphotos.com/1767687/16607/v/450/depositphotos_166074422-stock-illustration-default-avatar-profile-icon-grey.jpg"),
                        radius: 60,
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50)),
                              child: const Icon(
                                Icons.edit,
                                size: 20,
                                color: Colors.black,
                              )))
                    ],
                  ),
                ),
            ),
              const SizedBox(
                height: 25,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                  controller: _numberController,
                  myLabelText: "new name",
                  myIcon: Icons.person,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                  controller: _numberController,
                  myLabelText: "phone number",
                  myIcon: Icons.phone,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 120, right: 120),
                child: ElevatedButton(
                    onPressed: () {
                      
                    },
                    child: Container(  
                        child: const Text("Tap to Edit")
                        )
                        ),
              ),
            
            SizedBox(
              height: 20,
            ),
            
              Divider(
              color: Colors.grey,
              thickness: 0.5,
            ),
            Text(
              'Support',
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(
                  FontAwesomeIcons.book,
                  size: 14,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 20,
                ),
                TextButton(
                  onPressed: () {
                    
                  },
                  child: Text('About Green Ghana', style: TextStyle(color: Colors.black45),),
                ),
              ],
            ),
            
           
            Row(
              children: [
                Icon(
                  FontAwesomeIcons.pencil,
                  size: 14,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 20,
                ),
                TextButton(
                  onPressed: () {
                    
                  },
                  child: Text('Report a problem', style: TextStyle(color: Colors.black45),),
                ),
                Divider(
              color: Colors.grey,
              thickness: 0.5,
            ),
              ],
            ),
                      ],
        ),
      ),      
    );
  }
}
