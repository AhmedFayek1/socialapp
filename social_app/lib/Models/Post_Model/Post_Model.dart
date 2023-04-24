class PostModel {
  String name;
  String datetime;
  String uId;
  String image;
  String text;
  String postImage;

  PostModel({this.image,this.text,this.name,this.datetime,this.postImage,this.uId});

  PostModel.fromjson(Map<String,dynamic> json)
  {
    name = json['name'];
    datetime = json['datetime'];
    uId = json['uID'];
    image = json['image'];
    text = json['text'];
    postImage = json['postImage'];
  }

  Map<String,dynamic> toMap()
  {
   return {
      'name': name,
      'datetime': datetime,
      'uID': uId,
      'image': image,
      'text': text,
      'postImage': postImage,
  };
  }
}