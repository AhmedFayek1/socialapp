void PrintFullText(String text)
{
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String uID = '';




// void getPosts()
// {
//   posts = [];
//   emit(SocialGetPostsLoadingState());
//
//   FirebaseFirestore.instance.
//   collection('posts').
//   get().
//   then((value)
//   {
//
//     value.docs.forEach((element) {
//       element.reference.collection('likes').get().
//       then((value) {
//         likes.add(value.docs.length);
//         id.add(element.id);
//         posts.add(PostModel.fromjson(element.data()));
//       }).catchError((error) {
//
//       });
//
//     });
//     emit(SocialGetPostsSuccessState());
//   }).catchError((onError)
//   {
//     print(onError.toString());
//     emit(SocialGetPostsErrorState(onError.toString()));
//   });
//
// }
