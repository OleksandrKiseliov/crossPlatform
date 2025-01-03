/*
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:to_bee/constants/theme.dart';
import 'package:to_bee/views/setting.dart';
import'package:http/http.dart';
final List<Map> profileInfo = [

  {
    "icon": AppIcons.settings,
    "info": "Setting",
    "page": const Setting(),
  },
  {
    "icon": Icon(Icons.add_location_alt_rounded),
    "info": "Address",
    "page": const Address(),
  },
  {
    "icon": AppIcons.help,
    "info": "Help",
    "page": const Help(),
  },
  {
    "icon": Icon(Icons.),
    "info": "Privacy",
    "page": const Privacy(),
  },

  {
    "icon": AppIcons.logout,
    "info": "Logout",
    "page": const LogOut(),
  }
];

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final navKey = GlobalKey<CurvedNavigationBarState>();
  bool circular = true;

  getProfileData() async {
    var response = await http.get(
        Uri.parse('http://rootics.runasp.net/Authentications/current'),
        headers: {
          //'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        });
    var jsonData = jsonDecode(response.body);
    print(jsonData);

    return jsonData;
  }

  String? token;

  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token");
  }

  @override
  initState() {
   // getToken();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("lib/assets/background.png"),
                fit: BoxFit.cover)),
        child: Column(
          children: [
            FutureBuilder(
                future: getProfileData(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Color(0xff30B786),
                            borderRadius: BorderRadius.circular(15),
                            border: Border(
                                right: BorderSide(
                                    color: Color(0xff204338), width: 3.32),
                                bottom: BorderSide(
                                    color: Color(0xff204338), width: 3.32),
                                top: BorderSide(
                                    color: Color(0xff204338), width: 3.32),
                                left: BorderSide(
                                    color: Color(0xff204338), width: 3.32))),
                        child: Text("loading..."));
                  } else {
                    return Padding(
                        padding: const EdgeInsets.only(
                            top: 200, left: 10, right: 10),
                        child: Container(
                            width: double.infinity,
                            height: 110,
                            decoration: BoxDecoration(
                                color: Color(0xff204338),
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(children: [
                              SizedBox(
                                width: 5,
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 1,
                                    ),
                                    CircleAvatar(
                                      radius: 40,
                                      child: Image.network(
                                        "https://ccute.cc/wp-content/uploads/2018/06/6210-4.jpg",
                                        fit: BoxFit.fill,
                                      ),
                                    ),

                                    //  child: Image(image:  AssetImage("lib/assets/images/logo.png"),

                                    // fit:BoxFit.fill

                                    Text(snapshot.data["email"],
                                        style: TextStyle(
                                            color: Color(0xff90E9C9),
                                            fontSize: 20)),
                                  ]),
                              SizedBox(width: 7),
                              Text(snapshot.data["username"],
                                  style: TextStyle(
                                      color: Color(0xff90E9C9), fontSize: 30)),
                              SizedBox(width: 30),
                              SizedBox(height: 30),
                              Container(
                                width: 70,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.white24,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Center(
                                    child: TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditProfile()));
                                        },
                                        child: Text(
                                          "edit",
                                          style: TextStyle(color: Colors.black),
                                        ))),
                              )
                            ])));
                  }
                }),
            SizedBox(
              height: 90,
            ),
            Directionality(
                textDirection: TextDirection.rtl,
                child: Expanded(
                  child: ListView.builder(
                    itemCount: profileInfo.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          // onTap: () {
                          //   final navState = Variables().navKey.currentState!;
                          //   navState.setPage(0);
                          // },
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  profileInfo.elementAt(index)['page'])),
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColors().darkGreen3,
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                    color: AppColors().lightGreen, width: 5)),
                            child: ListTile(
                              contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                              leading:
                              Icon(profileInfo.elementAt(index)['icon']),
                              title: Text(
                                "${profileInfo.elementAt(index)['info']}",
                                style: TextStyle(
                                    color: AppColors().lightGreen,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              trailing: const Icon(AppIcons.leftarrow),
                              iconColor: AppColors().lightGreen,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
      //bottomNavigationBar: const AppNavBar()
    );
  }*/

