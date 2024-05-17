// DUMP VERIFICATION PAGE
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:kmrapp/screens/login.dart';
// import 'package:kmrapp/screens/root.dart';

// //tsssst
// class VerificationPage extends StatefulWidget {
//   final String verificationId;
//   final String phoneNumber;

//   const VerificationPage(
//       {super.key, this.verificationId = "dad", required this.phoneNumber});

//   @override
//   _VerificationPageState createState() => _VerificationPageState();
// }

// class _VerificationPageState extends State<VerificationPage> {
//   TextEditingController codeController = TextEditingController();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   String _verificationId = '';
//   void _verifyPhoneNumber() async {
//     await _auth.verifyPhoneNumber(
//       phoneNumber: '+60 17 671 7767',
//       verificationCompleted: (PhoneAuthCredential credential) async {
//         // Auto-retrieval or instant verification
//         await _auth.signInWithCredential(credential);
//         print(
//             "Phone number automatically verified and user signed in: ${_auth.currentUser}");
//       },
//       verificationFailed: (FirebaseAuthException e) {
//         if (e.code == 'invalid-phone-number') {
//           print('The provided phone number is not valid.');
//         } else {
//           print(
//               'Phone number verification failed. Code: ${e.code}. Message: ${e.message}');
//         }
//       },
//       codeSent: (String verificationId, int? resendToken) {
//         setState(() {
//           _verificationId = verificationId;
//         });
//         print('Verification code sent to number: bla bla');
//       },
//       codeAutoRetrievalTimeout: (String verificationId) {
//         setState(() {
//           _verificationId = verificationId;
//         });
//         print('Auto retrieval timeout for verification ID: $verificationId');
//       },
//     );
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _verifyPhoneNumber();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Verify Phone Number'),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               TextField(
//                 controller: codeController,
//                 keyboardType: TextInputType.number,
//                 decoration: const InputDecoration(
//                   hintText: 'Enter verification code',
//                 ),
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () async {
//                   // Get the verification code from the text field
//                   String verificationCode = codeController.text.trim();
//                   try {
//                     // Create a PhoneAuthCredential with the verification code
//                     // PhoneAuthCredential credential =
//                     //     PhoneAuthProvider.credential(
//                     //         verificationId: widget.verificationId,
//                     //         smsCode: verificationCode);
//                     // Sign in the user with the credential
//                     // await FirebaseAuth.instance
//                     //     .signInWithCredential(credential);
//                     await FirebaseAuth.instance.verifyPhoneNumber(
//                       phoneNumber: '+60 17 671 7767',
//                       verificationCompleted: (PhoneAuthCredential credential) {
//                         print('complete');
//                       },
//                       verificationFailed: (FirebaseAuthException e) {
//                         // if (e.code == 'invalid-phone-number') {
//                         print('The provided phone number is not valid.');
//                         // }
//                       },
//                       codeSent: (String verificationId, int? resendToken) {
//                         print('code sent');
//                       },
//                       codeAutoRetrievalTimeout: (String verificationId) {},
//                     );
//                     // If successful, navigate to home page or any other desired page

//                     // Navigator.push(context,
//                     //     MaterialPageRoute(builder: (context) => LoginPage()));
//                   } catch (e) {
//                     // Handle errors, e.g., invalid verification code
//                     print('Verification failed: $e');
//                     // You can show an error message to the user if needed
//                   }
//                 },
//                 child: const Text('Verify'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
