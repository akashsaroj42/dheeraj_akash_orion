import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_01/sccreen/home_screen.dart';
import 'package:project_01/sccreen/item_detail.dart';

class AllItem extends StatelessWidget {
  final Map<String, dynamic> snap;

  const AllItem({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 10),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color(0xFFF5F9FD),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF475269).withOpacity(0.3),
            blurRadius: 5,
            spreadRadius: 1,
          )
        ],
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.push((context),
                  MaterialPageRoute(builder: (context) => Itemdetail()));
            },
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Image.network(
                snap['imagelink'] ??
                    '', // Provide a default value or handle null
                height: 160,
                width: 160,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                snap['itemname'] ??
                    '', // Provide a default value or handle null
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF475269).withOpacity(0.9),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  snap['RentailAmount'] ??
                      '', // Provide a default value or handle null
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 240, 241, 242),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: InkWell(
                    onTap: () {},
                    child: Icon(
                      CupertinoIcons.heart,
                      color: Color.fromARGB(255, 211, 17, 17),
                      size: 28,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
