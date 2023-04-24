class CreateUserData
{
  String name;
  String email;
  String phone;
  String uID;
  String image;
  String cover;
  String bio;
  bool IsEmailVerified;

  CreateUserData({this.name, this.email, this.phone, this.uID, this.IsEmailVerified,this.image,this.bio,this.cover});

  CreateUserData.fromjson(Map<String,dynamic> json)
  {
      name = json['name'];
      email = json['email'];
      phone = json['phone'];
      uID = json['uID'];
      IsEmailVerified = json['IsEmailVerified'];
      image = json['image'];
      bio = json['bio'];
      cover = json['cover'];
  }

  Map<String,dynamic> toMap() {
    return {
    'name' : name,
    'email' : email,
    'phone' : phone,
    'uID' : uID,
      'IsEmailVerified' : IsEmailVerified,
      'image' : image,
      'cover' : cover,
      'bio' : bio,
    };
  }

}