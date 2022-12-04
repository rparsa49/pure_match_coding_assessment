import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// admin class for the purpose of dummy data to test out the search function with

// photo: profile photo to be displayed
// name: user's first and last name
// date: member since
// status: online or offline (false) to display either red or green outline around their profile photo

class Admin{
  late String name;
  late String date;
  late bool status;
  late AssetImage photo;

  Admin(this.name, this.date, this.status, this.photo);

  // getter for the admin name
  getName(){
    return name;
  }

  // getter for the date
  getDate(){
    return date;
  }

  // getter for the status
  getStatus(){
    return status;
  }

  // getter for the photo
  getPhoto(){
    return photo;
  }

}

