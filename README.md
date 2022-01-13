# Smart Garbage Management System

This is just a project demo i created. This app doesnot validate user creadientials from server side Hence if you are using this in production , make sure you do everything from serverside. If it's just a project demo or assignment you can change the **admin email** and **admin password** from  
>lib/screens/adminlogin.dart

Change these variables to your required credientials .
> String adminemail = "admin@admin.com";
  String adminpassword = "admin@123";

  As You can see, those are the default admin details.Make sure to create a database and then create a **collections name** as
  > pickups
  
  and then place a **google-services.json** file from firebase to

  > android/app/google-services.json

## Setup

go to directery you want to copy and paste these commands in terminal

``git clone https://github.com/samirlure161/smartgarbagemanagementsystem.git sgms``

`cd sgms`

`flutter pub get`

`flutter run`
