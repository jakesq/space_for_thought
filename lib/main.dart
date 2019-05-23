import"package:flutter/material.dart";import"package:space_for_thought/nasaparser.dart";import"package:transparent_image/transparent_image.dart";import"package:gradient_app_bar/gradient_app_bar.dart";import'package:share/share.dart';import"package:flutter/cupertino.dart";
void main()=>runApp(MaterialApp(debugShowCheckedModeBanner:false,home:SpaceForThought()));
class SpaceForThought extends StatefulWidget{@override SpaceForThoughtState createState()=>SpaceForThoughtState();}
class SpaceForThoughtState extends State<SpaceForThought>{
NasaApod nasaApod;bool loading=true;DateTime current;
SpaceForThoughtState(){current = DateTime.now();nasaApod=NasaApod(nasaApiUrl);}
@override void initState(){nasaApod.load().then((v)=>setState(()=>loading=false));super.initState();}
@override Widget build(BuildContext context){return Scaffold(
appBar:GradientAppBar(elevation:0.0,title:Text("Space for Thought",textAlign:TextAlign.center,style:TextStyle(fontStyle:FontStyle.italic,fontWeight:FontWeight.bold)),backgroundColorStart:Colors.pink,backgroundColorEnd:Colors.blue),
body:loading==true?Center(child:CircularProgressIndicator()):Apod(apod: nasaApod));}}
class Apod extends StatelessWidget{final NasaApod apod;final Function forward;final Function back;
Apod({this.apod,this.forward,this.back});
@override Widget build(BuildContext context){
return Container(decoration: BoxDecoration(color: Colors.black),
child:ListView(children:<Widget>[
ApodImage(imageUrl:apod.url),
ApodTitle(title:apod.title,date:apod.date,explanation:apod.explanation,imageUrl:apod.url),
ApodExplanation(explanation:apod.explanation)
]));}}
class ApodTitle extends StatelessWidget{final String title;final String date;final String explanation;final String imageUrl;
ApodTitle({@required this.title,this.date,this.explanation,this.imageUrl});
@override Widget build(BuildContext context){
var _width=MediaQuery.of(context).size.width;
return Padding(padding:EdgeInsets.all(16),
child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:<Widget>[
Container(width:_width,decoration:BoxDecoration(gradient:LinearGradient(colors:[Colors.pink,Colors.blue]),borderRadius:BorderRadius.circular(15)),padding:EdgeInsets.all(10),
child:InkWell(onTap:(){showModalBottomSheet<void>(context: context,
builder:(BuildContext context){return Container(width:_width,height:150,color:Colors.black.withAlpha(200),
child:Container(
width:_width,height:150,padding:EdgeInsets.only(left:5,right:5),
child:Column(mainAxisAlignment:MainAxisAlignment.start,
children:<Widget>[
Row(children: <Widget>[
InkWell(
child:Container(width:_width*0.5-5,height:100,color:Colors.pink,
alignment:Alignment.center,
child:Text("Share Article",style: TextStyle(color:Colors.white,fontSize:18,fontWeight:FontWeight.bold))),
onTap:(){Share.share(title+"\n\n"+explanation);}),
Container(height:100,width:2,color:Colors.white,margin:EdgeInsets.only(top:5,bottom:5)),
InkWell(
child:Container(
width:_width*0.5-7,height:100,color:Colors.blue,alignment:Alignment.center,
child:Text("Share Image",style:TextStyle(color:Colors.white,fontSize: 18,fontWeight:FontWeight.bold))),
onTap:(){Share.share(imageUrl);}
)])])));});},
child:Column(crossAxisAlignment:CrossAxisAlignment.start,
children:<Widget>[
Text(title,style:TextStyle(fontSize:24,fontWeight:FontWeight.bold,color:Colors.white)),
Container(height:1,width:50,color:Colors.white54,margin:EdgeInsets.only(top:5,bottom:5)),
Row(mainAxisAlignment:MainAxisAlignment.start,children:<Widget>[
Text("Publsihed "+date,style:TextStyle(fontStyle:FontStyle.italic,color:Colors.white),
)])])))]));}}
class ApodImage extends StatelessWidget{final String imageUrl;
ApodImage({this.imageUrl});
Widget _media(BuildContext context,String imageUrl){
return Container(
child:FadeInImage.memoryNetwork(placeholder:kTransparentImage,image:imageUrl)
);}
@override Widget build(BuildContext context){
return Container(
child:_media(context,imageUrl)
);}}
class ApodExplanation extends StatelessWidget{
final String explanation;
ApodExplanation({this.explanation});
@override Widget build(BuildContext context){
return Container(
child:Padding(padding:EdgeInsets.all(16),
child: Text(explanation,style:TextStyle(fontSize:18,color:Colors.white.withAlpha(200))
)));}}