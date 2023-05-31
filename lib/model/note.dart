class Note{
  String id;
  String notes_title;
  String notes_content;
  String creation_date;
  int color_id;


  Note({ required this.id,required this.notes_title,required this.notes_content,required this.creation_date, required this.color_id, });


  Map<String,dynamic>toMap(){
    return({
      "id":id,
      "notes_title": notes_title,
      "notes_content":notes_content,
      "creation_date": creation_date,
      "color_id":color_id
    });
  }

}
