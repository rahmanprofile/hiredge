import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class JobOverview extends StatefulWidget {
  final String id;
  final String imageUrl;
  final String jobName;
  final String company;
  final String newSalary;
  final String endSalary;
  final String quantity;
  final String type;
  final String jobFor;
  final String address;
  final String requirement;
  final String responsibility;
  final VoidCallback onDelete;

  const JobOverview({
    required this.id,
    required this.imageUrl,
    required this.company,
    required this.type,
    required this.jobName,
    required this.endSalary,
    required this.newSalary,
    required this.address,
    required this.jobFor,
    required this.quantity,
    required this.requirement,
    required this.responsibility,
    required this.onDelete,
    Key? key,
  }) : super(key: key);

  @override
  State<JobOverview> createState() => _JobOverviewState();
}

class _JobOverviewState extends State<JobOverview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          widget.company,
          style: GoogleFonts.roboto(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.black12)
                    ),
                    child: widget.imageUrl == null
                        ? const Center(
                            child: Icon(LineAwesomeIcons.user),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.network(
                              widget.imageUrl.toString(),
                              height: 60,
                              width: 60,
                              scale: 1.0,
                            ),
                          ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.jobName,
                        style: GoogleFonts.roboto(
                            fontSize: 17, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        widget.company,
                        style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black54),
                      ),
                      Text(
                        "Verified Post",
                        style: GoogleFonts.roboto(
                            fontSize: 13, color: Colors.green),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey[100]),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Start-Up Salary",
                            style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          const Spacer(),
                          Text(
                            "₹${widget.newSalary}",
                            style: GoogleFonts.roboto(
                                fontSize: 23, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                          height: 1,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "Up-To Salary",
                            style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          const Spacer(),
                          Text(
                            "₹${widget.endSalary}",
                            style: GoogleFonts.roboto(
                                fontSize: 23, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(LineAwesomeIcons.user_tie, size: 18),
                  const SizedBox(width: 6),
                  Text(
                    "Quantity",
                    style: GoogleFonts.actor(
                        fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(5)),
                child: Text(
                  "${widget.quantity} Person",
                  style: GoogleFonts.roboto(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(LineAwesomeIcons.windows, size: 18),
                  const SizedBox(width: 6),
                  Text(
                    "Type",
                    style: GoogleFonts.actor(
                        fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(5)),
                child: Text(
                  widget.type,
                  style: GoogleFonts.roboto(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54),
                ),
              ),
              const SizedBox(height: 8.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(LineAwesomeIcons.etsy, size: 18),
                  const SizedBox(width: 6),
                  Text(
                    "Experience",
                    style: GoogleFonts.actor(
                        fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(5)),
                child: Text(
                  widget.jobFor,
                  style: GoogleFonts.roboto(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54),
                ),
              ),
              const SizedBox(height: 8.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(LineAwesomeIcons.building, size: 18),
                  const SizedBox(width: 6),
                  Text(
                    "Address",
                    style: GoogleFonts.actor(
                        fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(5)),
                child: Text(
                  widget.address,
                  style: GoogleFonts.roboto(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54),
                ),
              ),
              const SizedBox(height: 8.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(LineAwesomeIcons.redo, size: 18),
                  const SizedBox(width: 6),
                  Text(
                    "Requirement",
                    style: GoogleFonts.actor(
                        fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(5)),
                child: Text(
                  widget.requirement,
                  style: GoogleFonts.roboto(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(LineAwesomeIcons.redo, size: 18),
                  const SizedBox(width: 6),
                  Text(
                    "Responsibility",
                    style: GoogleFonts.actor(
                        fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(5)),
                child: Text(
                  widget.responsibility,
                  style: GoogleFonts.roboto(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              GestureDetector(
                onTap: widget.onDelete,
                child: Container(
                  height: 45,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(color: Colors.black12)),
                  child: Center(
                    child: Text(
                      "Delete",
                      style: GoogleFonts.roboto(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
