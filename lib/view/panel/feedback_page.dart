import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobkar_pro/controller/constant.dart';
import 'package:jobkar_pro/view/components/round_button.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final __formKey = GlobalKey<FormState>();
  bool __isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 15.0),
          child: Form(
            key: __formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(LineAwesomeIcons.caret_square_up),
                    const SizedBox(width: 5),
                    Text("TITLE",style: GoogleFonts.roboto(fontSize: 16,fontWeight: FontWeight.w600),),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: Colors.white,
                    border: Border.all(color: Colors.black12)
                  ),
                  child: Padding(
                    padding:const EdgeInsets.only(left: 12),
                    child: TextFormField(
                      controller: titleController,
                      decoration:const InputDecoration(
                        hintText: "About title",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Icon(LineAwesomeIcons.caret_square_up),
                    const SizedBox(width: 5),
                    Text("DESCRIPTION",style: GoogleFonts.roboto(fontSize: 16,fontWeight: FontWeight.w600),),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: Colors.white,
                      border: Border.all(color: Colors.black12)
                  ),
                  child: Padding(
                    padding:const EdgeInsets.only(left: 12),
                    child: TextFormField(
                      controller: descController,
                      decoration:const InputDecoration(
                        hintText: "Describe your thought",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
               __isLoading ? Center(
                 child: CircularProgressIndicator(color: blueColor),
               ) : RoundButton(
                    text: "Submit",
                    onTap: () async {
                      if (__formKey.currentState!.validate()) {
                        setState(() {
                          __isLoading = true;
                        });
                      }else {
                        setState(() {
                          __isLoading = false;
                        });
                      }
                    },
                    textColor: Colors.white,
                    color: Colors.cyan,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
