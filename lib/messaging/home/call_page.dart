import 'package:flutter/material.dart';
import 'package:halo/messaging/call_details.dart';

class CallUser {
  String name;
  IconData iconData;
  String time;
  String callType;
  bool isMissed;

  CallUser(this.name, this.iconData, this.time, this.callType, this.isMissed);
}

class CallPage extends StatefulWidget {
  const CallPage({Key? key}) : super(key: key);

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  List<CallUser> callUSer = [
    CallUser(
        "Vikas Suthar", Icons.call_received, "10:00 AM", "Incoming", false),
    CallUser("Vikas Suthar", Icons.call_made, "10:00 AM", "Outgoing", false),
    CallUser(
        "Vikas Suthar", Icons.call_received, "10:00 AM", "Incoming", false),
    CallUser("Vikas Suthar", Icons.call_missed, "10:00 AM", "Missed", true),
    CallUser("Vikas Suthar", Icons.call_missed, "10:00 AM", "Missed", true),
    CallUser("Vikas Suthar", Icons.call_made, "10:00 AM", "Outgoing", false),
    CallUser("Vikas Suthar", Icons.call_missed, "10:00 AM", "Missed", false),
    CallUser("Vikas Suthar", Icons.call_made, "10:00 AM", "Outgoing", false),
    CallUser(
        "Vikas Suthar", Icons.call_received, "10:00 AM", "Incoming", false),
    CallUser(
        "Vikas Suthar", Icons.call_received, "10:00 AM", "Incoming", false),
    CallUser("Vikas Suthar", Icons.call_made, "10:00 AM", "Outgoing", false),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: callUSer.length,
        itemBuilder: (context, index) {
          return singleUser(callUSer[index]);
        });
  }

  Widget singleUser(CallUser callUser) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Theme.of(context).colorScheme.secondary,
                child: const Icon(Icons.person),
              ),
              const SizedBox(width: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return CallDetailsPage();
                        }));
                      },

                   
                      child: Text(
                        callUser.name,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                   
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            callUser.iconData,
                            size: 16,
                            color:
                                callUser.isMissed == true ? Colors.red : null,
                          ),
                          const SizedBox(width: 10),
                          Text(callUser.callType,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      color: callUser.isMissed == true
                                          ? Colors.red
                                          : null)),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
          Text(callUser.time,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall)
        ],
      ),
    );
  }
}
