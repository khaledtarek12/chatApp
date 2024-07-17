// ignore_for_file: depend_on_referenced_packages, avoid_print, avoid_single_cascade_in_expression_statements

import 'package:khaled/constants.dart';
import 'package:khaled/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:khaled/models/user.dart';

Future<String?> getDocumentId({required Message localMessage}) async {
  try {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection(kMessagesCollection);

    QuerySnapshot querySnapshot = await collectionRef
        .where(kMessage, isEqualTo: localMessage.text)
        .where(kTime, isEqualTo: localMessage.time)
        .where(kId, isEqualTo: localMessage.id)
        .where(kFriendId, isEqualTo: localMessage.friendId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.id;
    } else {
      return 'Document not found'; // Document not found
    }
  } catch (e) {
    // Handle errors here
    print('Error getting document ID: $e');
    return 'Error getting document ID: $e';
  }
}

deleteMessage(CollectionReference messages, String id) async {
  messages.doc(id).delete()
    ..then((_) => print('Deleted'))
        .catchError((error) => print('Delete failed: $error'));
}

updateMessage(CollectionReference messages, String id, String text) {
  messages.doc(id).update({kMessage: text})
    ..then((_) => print('${messages.doc(id).toString()}Edited'))
        .catchError((error) => print('Edit failed: $error'));
}

String findUserName(List<User> list, String email) {
  for (int i = 0; i < list.length; i++) {
    if (list[i].email == email) {
      return list[i].name;
    }
  }
  return 'User Name';
}

String findUserPhoto(List<User> list, String email) {
  for (int i = 0; i < list.length; i++) {
    if (list[i].email == email) {
      return list[i].photo;
    }
  }
  return 'User Photo';
}

String findUserStatues(List<User> list, String email) {
  for (int i = 0; i < list.length; i++) {
    if (list[i].email == email) {
      return list[i].statues;
    }
  }
  return 'User Statues';
}
