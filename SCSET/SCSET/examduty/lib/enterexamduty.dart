import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

class EnterExamDuty extends StatefulWidget {
  const EnterExamDuty({Key? key}) : super(key: key);

  @override
  State<EnterExamDuty> createState() => _EnterExamDutyState();
}

class _EnterExamDutyState extends State<EnterExamDuty> {
  final form=GlobalKey<FormState>();
TextEditingController enddate=TextEditingController(),startdate=TextEditingController(),label=TextEditingController();

  PlatformFile? file1,file2,file3,file4;

  

  Future<void> enterexamsubmit(BuildContext context) async {
    String dataurl = "http://127.0.0.1:8000/createExamDuty/";
    var req = http.MultipartRequest('POST', Uri.parse(dataurl));
    // Map<String, String> headers = {"Authorisation": 'Token '};
    // req.headers.addAll(headers);
    req.fields['label'] = label.text;
    req.fields['startdate'] = startdate.text;
    req.fields['enddate'] = enddate.text;

    if (file1 != null) {
      var fileReadStream = file1!.readStream;
      var filem = http.MultipartFile('file1', fileReadStream!, file1!.size,
          filename: file1!.name);
      req.files.add(filem);
    }

    if (file2 != null) {
      var fileReadStream = file2!.readStream;
      var filem = http.MultipartFile('file2', fileReadStream!, file2!.size,
          filename: file2!.name);
      req.files.add(filem);
    }

    if (file3 != null) {
      var fileReadStream = file3!.readStream;
      var filem = http.MultipartFile('file3', fileReadStream!, file3!.size,
          filename: file3!.name);
      req.files.add(filem);
    }

    if (file4 != null) {
      var fileReadStream = file4!.readStream;
      var filem = http.MultipartFile('file4', fileReadStream!, file4!.size,
          filename: file4!.name);
      req.files.add(filem);
    }

    // if (file5 != null) {
    //   var fileReadStream = file5!.readStream;
    //   var filem = http.MultipartFile('file_upload', fileReadStream!, file5!.size,
    //       filename: file5!.name);
    //   req.files.add(filem);
    // }

    var response = await req.send();
  String msg="";
    if (response.statusCode == 200) {
      msg="Form Submitted";
      
    } else {
      form.currentState!.reset();  
      msg= "Form Not Submitted, Contact Support or try again";
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg))); 
                      

  }










  void selectfile(x) async {
    FilePickerResult? picked = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
      withReadStream: true,
    );
    if (picked == null) {
      return null;
    }
    setState(() {
      if(x=="file1") {
        file1 = picked.files.first;
      }

      if(x=="file2") {
        file2 = picked.files.first;
      }

      if(x=="file3") {
        file3 = picked.files.first;
      }

      if(x=="file4") {
        file4 = picked.files.first;
      }

      // if(x=="file5") {
      //   file5 = picked.files.first;
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TextEditingController dateInput = TextEditingController();
    return Scaffold(
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
                TextFormField(
                  controller: label,
                validator: (value) {
                  if(value=="") {
                  return "Label Mandetory";
                }
                return null;
                },
                decoration: const InputDecoration(
                  label:Text("Label"),
                  ),
                ),

                TextFormField(
          
                   controller: startdate,
                validator: (value) {
                  if(value=="") {
                  return "Start Date Mandetory";
                }
                return null;
                },
                decoration: const InputDecoration(
                  label:Text("Start Date"),
                  ),
                onTap: () async {
                    DateTime? pickedDate = await showDatePicker(initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(2300),fieldHintText: "Enter Start Date",keyboardType: TextInputType.datetime,fieldLabelText: "StartDate", context: context,);
                  startdate.text=pickedDate.toString().substring(0,10);
              
                },
                ),

             TextFormField( 
              controller: enddate,
              validator: (value) {
                if(value=="") {
                  return "End Date Mandetory";
                }
                if(startdate.text=="" ||  startdate.text.compareTo(value!)>=0){
                  return "Please Enter Correct End Date";
                }
                return null;
              },
                decoration: const InputDecoration(
                  label:Text("End Date"),
                  ),
                onTap: () async {
                    DateTime? pickedDate = await showDatePicker(initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(2300),fieldHintText: "Enter End Date",keyboardType: TextInputType.datetime,fieldLabelText: "EndDate",context: context);
                  enddate.text=pickedDate.toString().substring(0,10);
               
                },
                ),
           
                


// const Spacer(),
Flex(direction: Axis.horizontal,
mainAxisAlignment: MainAxisAlignment.center,

children: [ElevatedButton(
                child: const Text('Faculty Leave'),
                
                onPressed: () async {
                  selectfile("file1");
                },
              ),
              (file1 == null) ? Container() : Text(file1!.name),
              if (file1 != null)
                OutlinedButton(
                    onPressed: () => {
                          setState(() {
                            file1 = null;
                          })
                        },
                    child: Stack(
                      alignment: Alignment.topLeft,
                      children: const <Widget>[
                        Icon(Icons.delete),
                      ],
                    )),],),
               
  Flex(
    direction: Axis.horizontal,
    mainAxisAlignment: MainAxisAlignment.center,
    children:[ElevatedButton(
                  child: const Text('Faculty Limits'),
                  onPressed: () async {
                    selectfile("file2");
                  },
                ),

                (file2 == null) ? Container() : Text(file2!.name),
              if (file2 != null)
                OutlinedButton(
                    onPressed: () => {
                          setState(() {
                            file2 = null;
                          })
                        },
                    child: Stack(
                      alignment: Alignment.topLeft,
                      children: const <Widget>[
                        Icon(Icons.delete),
                      ],
                    )),
              ]),

   Flex(
    direction: Axis.horizontal,
    mainAxisAlignment: MainAxisAlignment.center,
    children:[ElevatedButton(
                child: const Text('Faculty Subject'),
                onPressed: () async {
                  selectfile("file3");
                },
              ),

                    (file3 == null) ? Container() : Text(file3!.name),
              if (file3 != null)
                OutlinedButton(
                    onPressed: () => {
                          setState(() {
                            file3 = null;
                          })
                        },
                    child: Stack(
                      alignment: Alignment.topLeft,
                      children: const <Widget>[
                        Icon(Icons.delete),
                      ],
                    )),
                    ]),
 Flex(
    direction: Axis.horizontal,
    mainAxisAlignment: MainAxisAlignment.center,
    children:[
  ElevatedButton(
                child: const Text('Exam Rooms'),
                onPressed: () async {
                  selectfile("file4");
                },
              ),
                    (file4 == null) ? Container() : Text(file4!.name),
              if (file4 != null)
                OutlinedButton(
                    onPressed: () => {
                          setState(() {
                            file4 = null;
                          })
                        },
                    child: Stack(
                      alignment: Alignment.topLeft,
                      children: const <Widget>[
                        Icon(Icons.delete),
                      ],
                    )),
]), 
// Flex(
//     direction: Axis.horizontal,
//     mainAxisAlignment: MainAxisAlignment.center,
//     children:[
//   ElevatedButton(
//                 child: const Text('UPLOAD FILE'),
//                 onPressed: () async {
//                   selectfile("file5");
//                 },
//               ),

//                 (file5 == null) ? Container() : Text(file5!.name),
//               if (file5 != null)
//                 OutlinedButton(
//                     onPressed: () => {
//                           setState(() {
//                             file5 = null;
//                           })
//                         },
//                     child: Stack(
//                       alignment: Alignment.topLeft,
//                       children: const <Widget>[
//                         Icon(Icons.delete),
//                       ],
//                     )),
// ]),
 Flex(
    direction: Axis.horizontal,
    mainAxisAlignment: MainAxisAlignment.center,
    children:[



              ElevatedButton(
                    onPressed: () {
                  
                    
                      if (form.currentState!.validate()) {  
                         if(file1==null ||file2==null ||file3==null ||file4==null  ){
                         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Fill All Files"))); 
                      
                      }
                      else{
                       enterexamsubmit(context);
                       
                       Navigator.pop(context); 
                      } } 
                    },
                    child: const Text('Submit!'),
                  ),
                  ]),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

