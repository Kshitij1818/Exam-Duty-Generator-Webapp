import 'dart:convert';
import 'dart:html';
// import 'dart:ffi';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;




class GetData {
  String url = "http://127.0.0.1:8000/getExamDutyFaculty/";
 

   Future<List> getFilterData(String data) async {
    try {
      var response = await http.get(Uri.parse(url+data));
      if (response.statusCode == 200) {
        // print(response.body);
        return jsonDecode(response.body);
      } else {
        return Future.error('No Entry');
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}


class ShowExamDuty extends StatefulWidget {
  final String index;
  const ShowExamDuty({Key? key, required this.index}) : super(key: key);
  @override
  State<ShowExamDuty> createState() => _ShowExamDutyState();
}

class _ShowExamDutyState extends State<ShowExamDuty> {
  final form=GlobalKey<FormState>();
 TextEditingController filtercondi=TextEditingController();

// DropdownButton<String> dropdownmaker(List<String> list,String dropdownValue) {
//   return DropdownButton<String>(
//       value: dropdownValue,
//       icon: const Icon(Icons.arrow_downward),
//       elevation: 16,
//       style: const TextStyle(color: Colors.black),
//       underline: Container(
//         height: 2,
//         color: Colors.deepOrange,
//       ),
//       onChanged: (String? value) {
//         setState(() {
//           dropdownValue = value!;
//         });
//       },
//       items: list.map<DropdownMenuItem<String>>((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//     );
// }









@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
Map<String,int> currentstep = {};
int cur=0;
List<String> emailsList = [];
Map<String,List<Step>> steps={};
GetData getAPIdata = GetData();
  @override
  Widget build(BuildContext context) {
    String data=widget.index;
    return  Scaffold(
      appBar: AppBar(
        title: const Text("SCSET"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Form(
            key: form,
          
            child: Column(
            
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
          Flex(direction: Axis.horizontal,mainAxisAlignment: MainAxisAlignment.center,children: [     
            // TextFormField(),
            // TextFormField( 
            //   controller: filtercondi,
            //     decoration: const InputDecoration(
            //       label:Text("End Date"),
            //       ),
               
            //     ),
           
// dropdownmaker(list1, list1value),
// dropdownmaker(list2, list2value),
// dropdownmaker(list3, list3value),
// dropdownmaker(list4, list4value),

// TextField(
//    controller: filtercondi,
//     decoration: const InputDecoration(
//       label:Text("Bennett Email"),
//       ),
// ) 

// ,

ElevatedButton(onPressed: () async {
  // setState(() {
  //   data="${widget.index}&";
  // });
  return ;
}, child: const Text("Filter")),

ElevatedButton(onPressed: () async {
  GetData gt=GetData();
  var da=await gt.getFilterData(data);
  print(da[0]);
  // String csv = const ListToCsvConverter().convert(da);  
  //   new AnchorElement(href: "data:text/plain;charset=utf-8,$csv")
  //     ..setAttribute("download", "data.csv")
  //     ..click();
  return ;
}, child: const Icon(Icons.download))
          
          
          ],),

Expanded(
            child:
            FutureBuilder<List>(future: getAPIdata.getFilterData(data),builder: (context, snapshot) {
              if(snapshot.hasData){
                
                for(int i=0;i<snapshot.data!.length;i++){
                  if(steps.containsKey(snapshot.data![i]['bennett_email'])){
                    String bennettEmail=snapshot.data![i]['bennett_email'];
                    String examDate=snapshot.data![i]['exam_date'];
                    DateTime dt=DateTime.parse(examDate);
                    StepState ss=StepState.indexed;
                    if(dt.compareTo(DateTime.now())<0){
                      ss=StepState.complete;
                       currentstep[snapshot.data![i]['bennett_email']]=currentstep[snapshot.data![i]['bennett_email']]!+1;
                    }
                   String room=snapshot.data![i]['room_no'];
                    String remark=snapshot.data![i]['exam_date']+"----"+room;
                    
                    steps[snapshot.data![i]['bennett_email']]!.add(Step(
      title: Text(bennettEmail),
      content: Text("Room No--$room"),
       subtitle:Text(remark),
       state: ss,
      isActive: true,
    ),);
                  }
                  else{
                    steps[snapshot.data![i]['bennett_email']]=[];
                    emailsList.add(snapshot.data![i]['bennett_email']);
                    currentstep[snapshot.data![i]['bennett_email']]=0;
                    i--;
                  }
                }
              

                return  ListView.builder
              (
                itemCount: emailsList.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  List<Step> stepps=steps[emailsList[index]]!;
                  if(stepps.length==currentstep[emailsList[index]]!) {
                    currentstep[emailsList[index]]=currentstep[emailsList[index]]!-1;
                  }
                  return Card(
          elevation: 50,
          shadowColor: Colors.black,
          color: Colors.white54,
          child: SizedBox(
            width: 100,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.green[500],
                    radius: 20,
                    // child: const CircleAvatar(
                    //   backgroundImage: NetworkImage(
                    //       ""), //NetworkImage
                    //   radius: 10,
                    // ), //CircleAvatar
                  ), //CircleAvatar
                  const SizedBox(
                    height: 10,
                  ), //SizedBox
                  Text(
                    emailsList[index],
                    style: const TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ), //Textstyle
                  ), //Text
                  const SizedBox(
                    height: 10,
                  ), //SizedBox
                 Stepper(
                  controlsBuilder: (BuildContext ctx, ControlsDetails dtl){
           return Row(
            children: <Widget>[
              TextButton(
                onPressed: dtl.onStepContinue,
                child: const Text(true == true ? '' : 'NEXT'),
              ),
              TextButton(
                onPressed: dtl.onStepCancel,
                child: const Text(true == true ? '' :'CANCEL'),
              ),
            ],
          ); 
        },
   currentStep: currentstep[emailsList[index]]!,
   steps: stepps,
   type: StepperType.vertical,
  //  onStepTapped: (step) {
  //    setState(() {
  //      currentstep[index] = step;
  //    });
  //  },
   
 ), //Text
                  const SizedBox(
                    height: 10,
                  ), //SizedBox
                 
                ],
              ), //Column
            ), //Padding
          ), //SizedBox
        );
                }
            );
        
              }
              else{
                 return const Center(
                child: Text('No DATA FOUND'),
              );
              }


            },)
            
            
            
            ,
 
)
        ],
    ),
          ),
        ),
      ),
    );
   
  }
}



