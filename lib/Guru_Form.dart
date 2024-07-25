import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

// This is the link I used for implementing the stepper widget : https://www.youtube.com/watch?v=MpQTNW5woVI

// The registration form for guru onboarding
class GuruFormPage extends StatefulWidget {
  const GuruFormPage({super.key});

  @override
  State<GuruFormPage> createState() => _GuruFormPageState();
}

class _GuruFormPageState extends State<GuruFormPage> {

  int currentStep = 0;
  bool isCompleted = false;
  bool ischecked1 = false;
  bool ischecked2 = false;
  bool ischecked3 = false;
  bool ischecked4 = false;
  bool ischecked5 = false;
  bool ischecked6 = false;
  bool ischecked7 = false;

  final gurufullnamecontroller = new TextEditingController();
  final guruemailcontroller = new TextEditingController();
  final guruphonenumbercontroller = new TextEditingController();
  final gurustreetaddresscontroller = new TextEditingController();
  final gurucitycontroller = new TextEditingController();
  final gurustatecontroller = new TextEditingController();
  final gurupostalcodecontroller = new TextEditingController();
  final gurucountrycontroller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:  NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification notification){
          notification.disallowIndicator();
          return false;
        },
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('images/bg.png'), fit: BoxFit.fill)
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, top: 30),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          IconButton(
                            icon: Image.asset('images/back.png', height: 22,),
                            onPressed: (){
                              Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Become a GURU!", style: TextStyle(color: Colors.white, fontSize: 25, fontFamily: "Chivo"),)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                ],
              ),
            ),
            Container(
              color: Colors.black,
              height: 645,
              width: 900,
              child: Theme(
                data: ThemeData(
                canvasColor: Colors.black, 
                colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: Colors.blue,
                  background: Colors.green,
                  secondary: Colors.purple
                ),),
                child: Stepper(
                  physics: ScrollPhysics(),
                  type: StepperType.horizontal,
                  steps: getSteps(),
                  currentStep: currentStep,
                  onStepContinue: (){
                    final isLastStep = currentStep == getSteps().length - 1;
                    if (isLastStep){
                      setState(() {
                        isCompleted = true;
                      });
                      print('Complete');
                    } else {
                    setState(() => currentStep += 1);}
                  },
                  onStepTapped: (step) => setState(() => currentStep = step),
                  onStepCancel: 
                  currentStep == 0 ? null : () => setState(() => currentStep -= 1),  
                  controlsBuilder: (BuildContext context, ControlsDetails controls){
                    final isLastStep = currentStep == getSteps().length-1;
                    return Container(
                      margin: EdgeInsets.only(top: 50),
                      child: Row(
                        children: [
                          if (currentStep != 0)
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white
                              ),
                              onPressed: controls.onStepCancel, 
                              child: Text('Previous')
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: controls.onStepContinue, 
                              child: Text(isLastStep ? 'Confirm' : 'Next')
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  List <Step> getSteps() => [
    Step(
      state: currentStep > 0 ? StepState.complete : StepState.indexed,
      isActive: currentStep >= 0,
      title: Text(' '),
      content: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("Your Details : ", style: TextStyle(color: Colors.grey[200], fontSize: 20),)),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              color: Colors.green,
              width: 1000,
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: gurufullnamecontroller,
                obscureText: false,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.white),
                ),
                fillColor: Colors.white24,
                filled: true,
                hintText: 'Full Name',
                hintStyle: TextStyle(color: Colors.grey[300])
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: guruemailcontroller,
                      obscureText: false,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        fillColor: Colors.white24,
                        filled: true,
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Colors.grey[300])
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: guruphonenumbercontroller,
                      obscureText: false,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        fillColor: Colors.white24,
                        filled: true,
                        hintText: 'Phone Number',
                        hintStyle: TextStyle(color: Colors.grey[300])
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Address : ", style: TextStyle(color: Colors.grey[200], fontSize: 20),)),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only( bottom: 10),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: gurustreetaddresscontroller,
                      obscureText: false,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        fillColor: Colors.white24,
                        filled: true,
                        hintText: 'Street Address',
                        hintStyle: TextStyle(color: Colors.grey[300])
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: gurucitycontroller,
                      obscureText: false,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        fillColor: Colors.white24,
                        filled: true,
                        hintText: 'City',
                        hintStyle: TextStyle(color: Colors.grey[300])
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: gurustatecontroller,
                      obscureText: false,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        fillColor: Colors.white24,
                        filled: true,
                        hintText: 'State',
                        hintStyle: TextStyle(color: Colors.grey[300])
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: gurupostalcodecontroller,
                      obscureText: false,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        fillColor: Colors.white24,
                        filled: true,
                        hintText: 'Postal Code',
                        hintStyle: TextStyle(color: Colors.grey[300])
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: gurucountrycontroller,
                      obscureText: false,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        fillColor: Colors.white24,
                        filled: true,
                        hintText: 'Country',
                        hintStyle: TextStyle(color: Colors.grey[300])
                      ),
                    ),
                  ),
        ],
      )
    ),
    Step(
      state: currentStep > 1 ? StepState.complete : StepState.indexed,
      isActive: currentStep >= 1,
      title: Text(' '),
      content: Column(
        children: [
              const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: gurupostalcodecontroller,
                      obscureText: false,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        fillColor: Colors.white24,
                        filled: true,
                        hintText: 'LinkedIn Profile URL (Optional)',
                        hintStyle: TextStyle(color: Colors.grey[300])
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Educational Background :", style: TextStyle(color: Colors.grey[200], fontSize: 20),)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: gurupostalcodecontroller,
                      obscureText: false,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        fillColor: Colors.white24,
                        filled: true,
                        hintText: 'Highest Degree Obtained',
                        hintStyle: TextStyle(color: Colors.grey[300])
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: gurupostalcodecontroller,
                      obscureText: false,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        fillColor: Colors.white24,
                        filled: true,
                        hintText: 'University/Institute Name',
                        hintStyle: TextStyle(color: Colors.grey[300])
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: gurupostalcodecontroller,
                      obscureText: false,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        fillColor: Colors.white24,
                        filled: true,
                        hintText: 'Year of Graduation',
                        hintStyle: TextStyle(color: Colors.grey[300])
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Professional Experience : ", style: TextStyle(color: Colors.grey[200], fontSize: 20),)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: gurupostalcodecontroller,
                      obscureText: false,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        fillColor: Colors.white24,
                        filled: true,
                        hintText: 'Current Job Title',
                        hintStyle: TextStyle(color: Colors.grey[300])
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: gurupostalcodecontroller,
                      obscureText: false,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        fillColor: Colors.white24,
                        filled: true,
                        hintText: 'Current Employer',
                        hintStyle: TextStyle(color: Colors.grey[300])
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: gurupostalcodecontroller,
                      obscureText: false,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        fillColor: Colors.white24,
                        filled: true,
                        hintText: 'Previous relevant roles',
                        hintStyle: TextStyle(color: Colors.grey[300])
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: gurupostalcodecontroller,
                      obscureText: false,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        fillColor: Colors.white24,
                        filled: true,
                        hintText: 'Total years of experience',
                        hintStyle: TextStyle(color: Colors.grey[300])
                      ),
                    ),
                  ),
        ],
      )
    ),
    Step(
      state: currentStep > 2 ? StepState.complete : StepState.indexed,
      isActive: currentStep >= 2,
      title: Text(' '),
      content: Column(
        children: [
          
        ],
      )
    ),
    Step(
      state: currentStep > 3 ? StepState.complete : StepState.indexed,
      isActive: currentStep >= 3,
      title: Text(' '),
      content: Container()
    ),
    Step(
      state: currentStep > 4 ? StepState.complete : StepState.indexed,
      isActive: currentStep >= 4,
      title: Text(' '),
      content: Container()
    ),
    Step(
      state: currentStep > 5 ? StepState.complete : StepState.indexed,
      isActive: currentStep >= 5,
      title: Text(' '),
      content: Container()
    ),
    Step(
      state: currentStep > 6 ? StepState.complete : StepState.indexed,
      isActive: currentStep >= 6,
      title: Text(' '),
      content: Container()
    ),
    Step(
      state: currentStep > 7 ? StepState.complete : StepState.indexed,
      isActive: currentStep >= 7,
      title: Text(' '),
      content: Container()
    ),
  ];
}