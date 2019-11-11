import 'package:flutter/material.dart';
import 'package:todo_project/api/apiservice.dart';
import 'package:todo_project/api/model/model.dart';
import 'package:todo_project/comp/widget/customwidget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ApiService services =ApiService.getInstance();
  List<Post> post=[];

  GlobalKey<FormState> formkey=GlobalKey(debugLabel: 'formkey');

  GlobalKey<RefreshIndicatorState> refresh= GlobalKey<RefreshIndicatorState>();

  TextEditingController controllermalzeme=TextEditingController();
  TextEditingController controllerimage=TextEditingController();
  TextEditingController controllerfiyat=TextEditingController();
  
  Future<Null> newrefresh(){
    return services.getposts().then(
      (value){
        setState(() {
          
        });
      }
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('GET List')),
      ),
      body:FutureBuilder<List<Post>>(
        future: services.getposts(),
        builder: (context,snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.none:
              // TODO: Handle this case.
              break;
            case ConnectionState.waiting:
              // TODO: Handle this case.
              return Center(child: CircularProgressIndicator());
              break;
            case ConnectionState.active:
              // TODO: Handle this case.
              break;
            case ConnectionState.done:
              // TODO: Handle this case.
                post=snapshot.data;
                return listitem;
              break;
          }
        },
      ),
      floatingActionButton: _fabbutton,
    );
  }



  Widget get listitem=>ListView.separated(
    itemCount: post.length,
    separatorBuilder: (BuildContext context, int index) {
      return Divider();
    },
    itemBuilder: (BuildContext context, int index) =>dissmis(
      CustomWidget(
        malzemeismi: post[index].malzemeismi,
        imageURL: post[index].imageURL,
        fiyat: post[index].fiyat,
      ),
    post[index].key
    ),
  );

  Widget dissmis(Widget child,String key){
    return Dismissible(
      child: child,
      key: UniqueKey(),
      secondaryBackground: Center(child:Text('Silmiyorum Kardeşim =D') ,),
      background: Container(
        color: Colors.cyan,
      ),
      onDismissed: (dissimed) async {
        await services.removeposts(key);
      },
    );
  }

 Widget get _fabbutton => FloatingActionButton(
 child: Icon(Icons.add),
  onPressed: fabonporessed,
 );

  void fabonporessed (){
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))
      ),
      context: context,
      builder: (BuildContext context)=> bottomshet,
      );
  }

 Widget get bottomshet => Container(
   height: 400,
   child: Column(
     children: <Widget>[

       Form(
        autovalidate: true,
        key: formkey,
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              
              children: <Widget>[
                TextFormField(
                  controller: controllermalzeme,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Mazleme ismini Girin',
                    hasFloatingPlaceholder: true,
                  ),
                ),
                SizedBox(height: 10.0,),
                TextFormField(
                  controller: controllerfiyat,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Fiyat Giriniz',
                    hasFloatingPlaceholder: true,
                  ),
                ),
                SizedBox(height: 10.0,),
                TextFormField(
                  controller: controllerimage,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Resim URL Girin',
                    hasFloatingPlaceholder: true,
                  ),
                ),
              ],
            ),
          ),
        ),
       ),
       SizedBox(height: 10.0,),
       RaisedButton(
         onPressed:onpressed,
          child:Text('Add Post'),
       ),
     ],
   ),
 );

   onpressed() async {

     var post=Post(
          malzemeismi: controllermalzeme.text,
           imageURL: controllerimage.text,
          fiyat: int.parse(controllerfiyat.text)
           );
           await ApiService.getInstance().addposts(post);

        setState(() {
          
        });

      Navigator.of(context).pop();
    
  }





}