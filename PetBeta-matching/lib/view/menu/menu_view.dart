import 'package:flutter/material.dart';
import 'package:pettakecare/view/menu/PetOwner_view.dart';
import 'package:pettakecare/view/menu/PetSitter_view.dart';
import 'package:pettakecare/view/profile/PetSitter_page.dart';

class MenuView extends StatefulWidget {
  const MenuView({Key? key}) : super(key: key);

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  void _navigateToDepositPage() {
    // ใส่โค้ดเพื่อนำไปยังหน้าที่ต้องการ
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => PetSitterPage()));
  }

  void _navigateToPetOwnerPage() {
    // ใส่โค้ดเพื่อนำไปยังหน้าที่ต้องการ
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => PetOwnerView()));
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/img/app_logo.png",
                width: media.width * 0.55,
                height: media.width * 0.55,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 20), // เพิ่มระยะห่าง
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _navigateToDepositPage, // กำหนดฟังก์ชันเมื่อกด
                    child: Container(
                      width: media.width * 0.4,
                      height: media.width * 0.4,
                      color: Colors.blue,
                      margin: EdgeInsets.all(20),
                      child: Center(
                        child: Text(
                          "ผู้รับฝาก",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _navigateToPetOwnerPage, // กำหนดฟังก์ชันเมื่อกด
                    child: Container(
                      width: media.width * 0.4,
                      height: media.width * 0.4,
                      color: Colors.red,
                      margin: EdgeInsets.all(20),
                      child: Center(
                        child: Text(
                          "เจ้าของสัตว์เลี้ยง",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MenuView(),
  ));
}
