import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
class ApplyOdScreen extends StatefulWidget{
  const ApplyOdScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ApplyOdScreen();
}
class _ApplyOdScreen extends State<ApplyOdScreen>{

TextEditingController dateController = TextEditingController();
TextEditingController odReasonController = TextEditingController();
TextEditingController descriptionController = TextEditingController();

 @override
  void dispose() {
    dateController.dispose();
    odReasonController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),

       builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: Color.fromRGBO(16, 106, 233, 1),
          ),
        ),
        child: child!,
      );
    },
    );

    if (pickedDate != null) {
      setState(() {
        dateController.text =
            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

PlatformFile? selectedOdFile;

  Future<void> pickOdFile() async{
    FilePickerResult? odFileVar = await 
    FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf','jpg','png']
    );

    if(odFileVar!=null){
    setState(() {
      selectedOdFile = odFileVar.files.first;
    });
    }
  }
@override
Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
            appBar: AppBar(
              leading: IconButton(icon: Icon(Icons.arrow_back,color: Color.fromRGBO(16, 106, 233, 1),),
              onPressed:() {
                Navigator.of(context).pop();
              } ,),
              title: const Text("Apply for On Duty",
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold),
              ),
              actions: [
                IconButton( 
                icon: Icon(Icons.question_mark,size: 18,),
                onPressed: (){},
                style: IconButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.zero,
                  minimumSize: Size(25, 25)
                   )
                )
              ],
              
            ),
      
            body: Padding(
              padding: const EdgeInsets.only(left: 19, right: 19),
              
              child: SingleChildScrollView(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 12),
                      child: Text("Please fill out the details below to request On Duty(OD) leave for official college activities",
                      style: TextStyle(color: Color.fromRGBO(104, 130, 156, 1)),),
                    ),
                
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Text("OD Details",
                      style: TextStyle(fontSize: 17,
                      fontWeight: FontWeight.bold),
                      )
                      ),
                
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Text("Select Date",
                        style: TextStyle(fontSize: 15,
                        fontWeight: FontWeight.w600),
                        ),
                      ),
                
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: TextField(
                          controller: dateController,
                          onTap: (){
                             pickDate();
                          },
                          readOnly: true,
                          decoration: const InputDecoration(
                          hintText: "DD/MM/YYYY",
                          hintStyle: TextStyle(color: Color.fromRGBO(188, 196, 196, 1)),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(188, 196, 196, 1),style: BorderStyle.solid,width: 1.5),),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(188, 196, 196, 1),style: BorderStyle.solid,width: 1.5),),
                          suffixIcon: Icon(Icons.calendar_today),
                        ),
                        ),
                      ),
                    
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text("Reason For OD",
                      style: TextStyle(
                        fontWeight:FontWeight.w600,
                        fontSize: 15
                      ),
                      ),
                    ),
                
                    TextField(
                      maxLength: 50,
                      decoration: InputDecoration(
                         enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(188, 196, 196, 1),style: BorderStyle.solid,width: 1.5),),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(188, 196, 196, 1),style: BorderStyle.solid,width: 1.5),),
                      ),
                      controller: odReasonController,
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text("Detailed Description",
                       style: TextStyle(
                          fontWeight:FontWeight.w600,
                          fontSize: 15
                        ),
                      ),
                    ),
                
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: TextField(
                        controller: descriptionController,
                         decoration: InputDecoration(
                          hintText: "Provide more details about the event or duty",
                          hintStyle: TextStyle(color: Color.fromRGBO(188, 196, 196, 1)),
                           enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(188, 196, 196, 1),style: BorderStyle.solid,width: 1.5),),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(188, 196, 196, 1),style: BorderStyle.solid,width: 1.5),),
                          
                        ),
                        maxLines: 4,
                        
                      ),
                    ),
      
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text("Upload Proof / Invitation",
                      style: TextStyle(
                        fontWeight:FontWeight.w600,
                        fontSize: 15 
                      ),),
                    ),
                
      
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 18),
                      child: DottedBorder(
                        options:const RoundedRectDottedBorderOptions(
                        padding: EdgeInsets.zero,
                        radius: Radius.circular(10),
                        dashPattern: [5,5],
                        strokeWidth: 2.5,
                        color: Color.fromRGBO(173, 202, 242, 1)
                        ),
                      
                        child: Container(
                          margin: EdgeInsetsGeometry.only(left: 1, right: 1),
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                          color: Color.fromRGBO(233, 243, 255, 1),
                          borderRadius: BorderRadius.circular(10)
                          ),
                          child:
                          selectedOdFile == null?
                           Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 30, bottom: 10),
                              child: Icon(
                              Icons.cloud_upload, 
                              size: 40, 
                              color: Color.fromRGBO(17, 108, 234, 1),
                              ),
                            ),
                      
                            Padding(
                              padding: const EdgeInsets.only(bottom: 3),
                              child: Text("Click to upload file",
                              style: TextStyle(color: Color.fromRGBO(17, 108, 234, 1)),
                              ),
                            ),
                      
                            Text("PDF, JPG or PNG (Max 5MB)",
                            style: TextStyle(color:  Color.fromRGBO(157, 164, 164, 1))
                            )
                            ],
                          )
                          :
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 30, bottom: 10),
                                child: Icon(Icons.insert_drive_file, color: Color.fromRGBO(17, 108, 234, 1),),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20, right: 20),
                                child: Container(
                                  width: double.infinity,
                      
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(245, 251, 250, 1),
                                    borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                                    child: Text("Selected File : ${selectedOdFile!.name}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color.fromRGBO(17, 108, 234, 1)
                                    ),
                                    textAlign: TextAlign.center,
                                    ),
                                  ),
                                  
                                ),
                              ),
                             IconButton(
                              icon: Icon(Icons.clear_rounded),
                              onPressed: (){
                                setState(() {
                                  selectedOdFile = null;
                                });
                              }),
                             
                            ],
                          )
                        ),
                      ),
                    ),
                    onTap: () {
                      pickOdFile();
                    },
                  ),
                  
                Card(
                    elevation: 0,
                    color: const Color.fromRGBO(241, 244, 249, 1),
                 child: Padding(
                   padding: const EdgeInsets.only(top: 5, bottom: 5),
                   child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 1, right: 5),
                          child: Icon(
                            Icons.info_outline,
                            size: 14,
                            ),
                        ),
                        Expanded(
                          child: Text("Note: Once submitted, your request will be routed \nto the department HOD and Principal for final approval",
                          style: TextStyle(fontSize: 12),
                          ),
                        )
                      ],
                    ),
                 ),),
                  
      
                  ],
                ),
              ),
            ),
           
           bottomNavigationBar: Container(
            padding: EdgeInsets.only(left: 19, right: 19),
            child: ElevatedButton(onPressed: (){},  
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromRGBO(20, 110, 237, 1),
              shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10),),
              
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Submit OD Request  ", style: TextStyle(color: Colors.white),),
                Icon(Icons.send, color: Colors.white,)
              ],
            ),),
           ),
       ),
    );
  }
}