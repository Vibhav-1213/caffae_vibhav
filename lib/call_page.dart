import 'package:caffae_vibhav/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

class CallPage extends StatefulWidget {
  final String callID, guru_name_call, guru_email_call, user_id;
  const CallPage({super.key, required this.callID, required this.guru_name_call, required this.guru_email_call, required this.user_id});

  @override
  State<CallPage> createState() => _CallPageState();
}

List Guru_List = [];
List User_List = [];

var guru_data = FirebaseFirestore.instance.collection('Guru_details');
var user_data = FirebaseFirestore.instance.collection('Users');


class _CallPageState extends State<CallPage> {
  @override
  Widget build(BuildContext context) {
    
    return ZegoUIKitPrebuiltCall(
      appID: 1646658394, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
      appSign: '17b92edf3bd05057774c11f369cc8fc6efa850cc8bf61fc4cfa219c9fc2a6f7f', // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
      userID: widget.user_id,
      userName: widget.guru_name_call,
      plugins: [ZegoUIKitSignalingPlugin()],
      callID: widget.callID,
      // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
    );
  }
}