import 'dart:convert';

import 'package:examduty/showexamduty.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;


// class GetData11 {
//   String url = "http://127.0.0.1:8000/gett/";
//   Future<List> getAllData11() async {
//     try {
//       var response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         return jsonDecode(response.body);
//       } else {
//         return Future.error('Missing Entry');
//       }
//     } catch (e) {
//       return Future.error(e);
//     }
//   }
// }




class GetData {
  String url = "http://127.0.0.1:8000/getExamDutyGroup/";
  Future<List> getAllData() async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return Future.error('Missing Entry');
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}















class ShowExamGroup extends StatefulWidget {
  const ShowExamGroup({Key? key}) : super(key: key);

  @override
  State<ShowExamGroup> createState() => _ShowExamGroupState();


}


class _ShowExamGroupState extends State<ShowExamGroup> {
final form=GlobalKey<FormState>();
//  late List<String> label;
//  late List<String> startdate;
//  late List<String> enddate;

// Card cardbuilder(int index){
//   return Card(
//           elevation: 50,
//           shadowColor: Colors.black,
//           color: Colors.white54,
//           child: SizedBox(
//             width: 100,
//             height: 200,
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   CircleAvatar(
//                     backgroundColor: Colors.green[500],
//                     radius: 20,
//                     // child: const CircleAvatar(
//                     //   backgroundImage: NetworkImage(
//                     //       ""), //NetworkImage
//                     //   radius: 10,
//                     // ), //CircleAvatar
//                   ), //CircleAvatar
//                   const SizedBox(
//                     height: 10,
//                   ), //SizedBox
//                   Text(
//                     label[index],
//                     style: const TextStyle(
//                       fontSize: 30,
//                       color: Colors.black,
//                       fontWeight: FontWeight.w500,
//                     ), //Textstyle
//                   ), //Text
//                   const SizedBox(
//                     height: 10,
//                   ), //SizedBox
//                   Text(
//                     "${startdate[index]} - ${enddate[index]}",
//                     style: const TextStyle(
//                       fontSize: 15,
//                       color: Colors.black,
//                     ), //Textstyle
//                   ), //Text
//                   const SizedBox(
//                     height: 10,
//                   ), //SizedBox
//                   SizedBox(
//                     width: 100,
 
//                     child: ElevatedButton(
//                       onPressed: () {
//                          Navigator.push(context,MaterialPageRoute(builder: (context)=>ShowExamDuty(index: index,)));
//                       },
//                       style: ButtonStyle(
//                           backgroundColor:
//                               MaterialStateProperty.all(Colors.deepOrange)),
//                       child: Padding(
//                         padding: const EdgeInsets.all(4),
//                         child: Row(
//                           children: const [
//                             Icon(Icons.touch_app),
//                             Text('Open')
//                           ],
//                         ),
//                       ),
//                     ),
                  
//                   ) //SizedBox
//                 ],
//               ), //Column
//             ), //Padding
//           ), //SizedBox
//         );//Card;
// }









//  Future<String> fetchLabels() async {
//   http.Response data=await http.get(Uri.parse('http://127.0.0.1:8000/getExamDutyGroup/'));
//   return data.body;
//   }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Future<String> data=fetchLabels();
    
    // label=["label1","label2","label3","label4","label5","label6"];
    // startdate=['2000-12-12','2000-12-17','2000-12-15','2000-12-16','2000-12-14','2000-12-13'];
    // enddate=['2000-12-22','2000-12-27','2000-12-25','2000-12-26','2000-12-24','2000-12-23'];
      }

GetData getAPIdata = GetData();
// GetData11 getAPIdata11 = GetData11();
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(appBar: AppBar(
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
                
Expanded(
            child: 







            // FutureBuilder<List>(future: getAPIdata11.getAllData11(),builder: (context, snapshot) {
            //       if(snapshot.hasData){
            //         return ListView.builder(
            //           itemCount: snapshot.data!.length,
            //           itemBuilder: (context, index) {
                        
            //           return Text("C:/Users/KSHITIJ/Desktop/SCSET/examdutyback${snapshot.data![index]['img']}");
            //         },);
                    
            //       }
            //       else{
            //          return const Center(
            //     child: Text('No DATA FOUND'),
            //   );
            //       }
            //     },)
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            FutureBuilder<List>(future:getAPIdata.getAllData(),builder: (context, snapshot) {
              if(snapshot.hasData){
                return ListView.builder
              (
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return Card(
          elevation: 50,
          shadowColor: Colors.black,
          color: Colors.white54,
          child: SizedBox(
            width: 100,
            height: 200,
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
                    snapshot.data![index]['label'],
                    style: const TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ), //Textstyle
                  ), //Text
                  const SizedBox(
                    height: 10,
                  ), //SizedBox
                  Text(
                    "${snapshot.data![index]['start_date']} ---- ${snapshot.data![index]['end_date']}",
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ), //Textstyle
                  ), //Text
                  const SizedBox(
                    height: 10,
                  ), //SizedBox
                  SizedBox(
                    width: 100,
 
                    child: ElevatedButton(
                      onPressed: () {
                         Navigator.push(context,MaterialPageRoute(builder: (context)=>ShowExamDuty(index: "?label=${snapshot.data![index]['label']}",)));
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.deepOrange)),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Row(
                          children: const [
                            Icon(Icons.touch_app),
                            Text('Open')
                          ],
                        ),
                      ),
                    ),
                  
                  ) //SizedBox
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




































        ),


                           ],
    ),
          ),
        ),
      ),);
  }
  
 

}