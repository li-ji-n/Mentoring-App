class MentorMapArgs {
  int id;
  String admission_no;
  String name;
  int mentorId;

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "admission_no": this.admission_no,
      "name": this.name,
      "mentorId": this.mentorId,
    };
  }

  static List fromJson(List<dynamic> list) {
    List<dynamic> jsonList = List();
    list.map((item) => jsonList.add(item.toJson())).toList();
    return jsonList;
  }

  MentorMapArgs({this.id, this.admission_no, this.name, this.mentorId});
}

class GraphModel {
   int id;
   String month;
   String behaviourRate;
     String attendanceRate;
       String marksRate;
   String comments;

  GraphModel(this.id,this.month, this.behaviourRate,this.attendanceRate,this.marksRate,this.comments);
}


class MapObj{
  String name;
  bool isDone;
  MapObj({this.name,this.isDone});
}