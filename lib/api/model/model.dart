class Post{

  String key;
  String malzemeismi;
  String imageURL;
  var fiyat;


  Post({this.malzemeismi,this.imageURL,this.fiyat});

  Post.fromJson(Map<String,dynamic>json){
    malzemeismi=json['malzemeismi'];
    fiyat=json['fiyat'];
    imageURL=json['imageURL'];
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data=new Map<String,dynamic>();

    data['malzemeismi']=this.malzemeismi;
    data['fiyat']=this.fiyat;
    data['imageURL']=this.imageURL;

    return data;
  }

}

class PostList{

  List<Post> posts=[];

  PostList.fromJsonList(Map value){
    value.forEach((key,value){
      var post=Post.fromJson(value);
      post.key=key;
      posts.add(post);
    });

  }

}