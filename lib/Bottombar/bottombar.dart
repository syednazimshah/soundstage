
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

bottombar(){
  return Container(
    padding: EdgeInsets.symmetric(vertical: 15,horizontal: 100),
    child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Soundstage, Inc",
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: FaIcon(
                  FontAwesomeIcons.instagram,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              IconButton(
                onPressed: () {},
                icon: FaIcon(
                  FontAwesomeIcons.facebook,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              IconButton(
                  onPressed: () {},
                  icon: FaIcon(
                    FontAwesomeIcons.twitter,
                    color: Colors.white,
                  )),
            ],
          ) ,
        ]
    ),
  );

}