import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enhud/pages/homescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AccountinfoPage extends StatefulWidget {
  const AccountinfoPage({super.key});

  @override
  State<AccountinfoPage> createState() => _AccountinfoPageState();
}

class _AccountinfoPageState extends State<AccountinfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('user')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('No user data found.'));
          } else {
            var userData = snapshot.data!.data() as Map<String, dynamic>;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //upper container
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color(0xFF5f8cf8)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //image
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundImage:
                                NetworkImage(" ${userData['url']}"),
                          ),
                          Text(
                            ' Hi, ${userData['name'].toString().trimLeft()}',
                            style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      //line
                      const Text(
                        '  Come on, you can do it.',
                        style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Divider(
                  thickness: 2,
                ),
                //else

                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        ' Full name',
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        child: TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                              hintText: '${userData['name']}',
                              hintStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xFFededed)),
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                      ),

                      //

                      const Text(
                        ' E-mail',
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        child: TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                              hintText: '${userData['email']}',
                              hintStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xFFededed)),
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                      ),

                      //
                      const Text(
                        ' Acdemic year',
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        width: 100,
                        child: TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                              hintText: '3rd year',
                              hintStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xFFededed)),
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                      ),
                      //

                      const Text(
                        ' Gender',
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        width: 70,
                        child: TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                              hintText: "${userData['gender']}",
                              hintStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xFFededed)),
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
      bottomNavigationBar: bottmbar(context),
    );
  }

  Container bottmbar(BuildContext context) {
    return Container(
      height: 60,
      color: const Color(0xFFd9d9d9),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => const HomeScreen(
                            homeindex: 0,
                          )),
                  (route) => false,
                );
              },
              child: SvgPicture.asset('images/Home.svg')),
          InkWell(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => const HomeScreen(
                            homeindex: 1,
                          )),
                  (route) => false,
                );
              },
              child: SvgPicture.asset('images/Timetable.svg')),
          InkWell(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => const HomeScreen(
                            homeindex: 2,
                          )),
                  (route) => false,
                );
              },
              child: SvgPicture.asset('images/Add.svg')),
          InkWell(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => const HomeScreen(
                            homeindex: 3,
                          )),
                  (route) => false,
                );
              },
              child: SvgPicture.asset('images/Exam.svg')),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SvgPicture.asset('images/Settings.svg'),
              Container(
                padding: const EdgeInsets.all(0),
                width: 9,
                height: 9,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF5f8cf8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
