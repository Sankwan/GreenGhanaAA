import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignoutScreen extends StatelessWidget {
  const SignoutScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade50,
                foregroundColor: Colors.black,
                elevation: 0,
        title: Text('Settings and more', style: TextStyle(fontSize: 15),),
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
                Text('Hello, ', style: TextStyle(fontSize: 25, color: Colors.black),),
                Text('User', style: TextStyle(fontSize: 25, color: Colors.black),)
              ],
            ),
             SizedBox(
               height: 20,
             ),
             Divider(
               color: Colors.grey,
               thickness: 0.5,
             ),
             SizedBox(
               height: 20,
             ),
             Text('Edit Profile', style: TextStyle(fontSize: 15, color: Colors.grey),),
            SizedBox(
               height: 20,
             ),
            TextFormField(
              cursorColor: Colors.black,
              style: TextStyle(color: Colors.black),
                decoration: new InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                    contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                    hintText: "edit name",
                    hintStyle: TextStyle(color: Colors.grey),
                ),
            ),
            SizedBox(
               height: 20,
             ),
            TextFormField(
              cursorColor: Colors.black,
              style: TextStyle(color: Colors.black),
                decoration: new InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                    contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                    hintText: "phone number",
                    hintStyle: TextStyle(color: Colors.grey),
                ),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
               color: Colors.grey,
               thickness: 0.5,
             ),
             SizedBox(
               height: 20,
             ),
             Text('Support', style: TextStyle(fontSize: 15, color: Colors.grey),),
             SizedBox(
               height: 20,
             ),
             Row(
              children: [
                Icon(FontAwesomeIcons.pencil, size: 14, color: Colors.grey,),
                SizedBox(
                  width: 20,
                ),
                Text('Report a problem')
              ],
             ),
            SizedBox(
               height: 20,
             ),
             Divider(
               color: Colors.grey,
               thickness: 0.5,
             ),
             SizedBox(
               height: 20,
             ),
             Text('About', style: TextStyle(fontSize: 15, color: Colors.grey),),
             SizedBox(
                  height: 20,
                ),
             Row(
              children: [
                Icon(Icons.error_outline, color: Colors.grey,),
                SizedBox(
                  width: 20,
                ),
                Text('Privacy Policy',)
              ],
              
             ),
             SizedBox(
                  height: 20,
                ),
             Row(
              children: [
                Icon(Icons.copyright, color: Colors.grey,),
                SizedBox(
                  width: 20,
                ),
                Text('Copyright Policy'),
              ],
             ),
            SizedBox(
               height: 20,
             ),
          ],
        ),
        ),
        // child: ListView(
        //   children: [
        //     Text('Hello User', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
        //     SizedBox(
        //       height: 20,
        //     ),
        //     Divider(
        //       color: Colors.amber,
        //       height: 10,
        //     ),
        //     Text('Edit Profile', style: TextStyle(fontSize: 20, color: Colors.grey),),
        //     Row(
        //       children: [
        //         TextFormField(
        //           decoration: InputDecoration(
        //             hintText: 'Edit name',
        //             hintStyle: TextStyle(color: Colors.grey),
        //             filled: true,
        //             fillColor: Colors.grey.shade300,
                  
        //             prefixIcon: Icon(Icons.search, color: Colors.grey.shade700,),
        //             border: OutlineInputBorder(
        //               borderRadius: BorderRadius.circular(10),
        //               borderSide: BorderSide.none,
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ],
        // ),
    );
  }
}