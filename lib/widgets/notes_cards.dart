import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:notes_app/style/app_style.dart";

Widget noteCard(Function()? onTap, QueryDocumentSnapshot doc){
 return InkWell(
  onTap: onTap,
  child: Container(
    padding: EdgeInsets.all(8.0),
    margin: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Appstyle.cardsColor[doc['color_id']],
      borderRadius: BorderRadius.circular(8.0),  
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(doc["notes_title"],style: Appstyle.mainTitle,), SizedBox(height: 4.0,),
        Text(doc["creation_date"].toString(), style: Appstyle.dateTitle,),
        Text(doc["notes_content"],style: Appstyle.mainContent,),
       ],
    )
  
  ),
 );
}




























