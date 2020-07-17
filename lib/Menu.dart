import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gumen/Empleados.dart';
import 'package:gumen/Gastos.dart';
import 'package:gumen/Grafica_Gastos/venta_grafica_gastos.dart';
import 'package:gumen/Meta/Grafica_Meta.dart';
import 'Grafica_Ventas/venta_grafica.dart';
import 'Ventas.dart';
import 'VentasPendientes.dart';
import 'Gastos.dart';
import 'Proveedores.dart';
import 'Inventario.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

bool _debugLocked = false;

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{

  AnimationController animationController;
  Animation degOneTranlationAnimation,degTwoTranlationAnimation,degthreeTranlationAnimation;
  Animation rotationAnimation;

  double getRadiansFromDegree(double degree)
  {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
      }

  @override
  void initState(){
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    degOneTranlationAnimation = TweenSequence([
      TweenSequenceItem<double>(tween: Tween<double> (begin: 0.0,end: 1.2),weight: 75.0),
      TweenSequenceItem<double>(tween: Tween<double> (begin: 1.2,end: 1.0),weight: 25.0),

    ]).animate(animationController);
    degTwoTranlationAnimation = TweenSequence([
      TweenSequenceItem<double>(tween: Tween<double> (begin: 0.0,end: 1.4),weight: 55.0),
      TweenSequenceItem<double>(tween: Tween<double> (begin: 1.4,end: 1.0),weight: 45.0),

    ]).animate(animationController);
    degthreeTranlationAnimation = TweenSequence([
      TweenSequenceItem<double>(tween: Tween<double> (begin: 0.0,end: 1.75),weight: 35.0),
      TweenSequenceItem<double>(tween: Tween<double> (begin: 1.75,end: 1.0),weight: 65.0),

    ]).animate(animationController);
    rotationAnimation = Tween<double>(begin: 180.0, end: 0.0).animate(CurvedAnimation(parent: animationController,
    curve: Curves.easeOut));
    super.initState();
    animationController.addListener((){
      setState(() {
        
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    assert(!_debugLocked);
    
    // to get size
    var size = MediaQuery.of(context).size;
    // style
    var cardTextStyle = TextStyle(
        fontFamily: "Montserrat Regular",
        fontSize: 14,
        
        color: Color.fromRGBO(63, 63, 63, 1));

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(

        

        children: <Widget>[
         
         

          Container(
            height: size.height * .3,
            decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),

             gradient: new LinearGradient(colors: [const Color(0xFFba8d13), const Color(0xFFffffff)],
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight,
                stops: [0.0,1.0],
                tileMode: TileMode.clamp
                
             
             
             )
            ),
          ),
           Positioned(
            
            
            right: 30,
            bottom: 630,
            child: Stack(
              
              children: <Widget>[

                 Transform.translate(
                   offset: Offset.fromDirection(getRadiansFromDegree(200), degOneTranlationAnimation.value *100),
                   child: Transform(
                      transform:Matrix4.rotationZ(getRadiansFromDegree(rotationAnimation.value))..scale(degOneTranlationAnimation.value),
                      alignment: Alignment.center,

                      child: CircularButton(
                      
                      color: Colors.orangeAccent,
                      width: 50,
                      height: 50,
                      icon: Icon(
                        Icons.person,
                        color:Colors.white
                      ),
                ),
                   ),
                 ),
                Transform.translate
                (
                   offset: Offset.fromDirection(getRadiansFromDegree(170),degTwoTranlationAnimation.value *100),
                  child: Transform(
                     transform:Matrix4.rotationZ(getRadiansFromDegree(rotationAnimation.value))..scale(degTwoTranlationAnimation.value),
                      alignment: Alignment.center,
                                      child: CircularButton(
                      
                      color: Colors.blue,
                      width: 50,
                      height: 50,
                      icon: Icon(
                        Icons.add,
                        color:Colors.white
                      ),
                    ),
                  ),
                ),
                Transform.translate(
                                  
                     offset: Offset.fromDirection(getRadiansFromDegree(140),  degthreeTranlationAnimation.value *100),
                    child: Transform(
                     transform:Matrix4.rotationZ(getRadiansFromDegree(rotationAnimation.value))..scale(degthreeTranlationAnimation.value),
                      alignment: Alignment.center,
                     child: CircularButton(
                      
                      color: Colors.black,
                      
                      width: 50,
                      height: 50,
                      icon: Icon(
                        Icons.camera_alt,
                        color:Colors.white
                      ),
                  ),
                    ),
                ),
                Transform(
                   transform:Matrix4.rotationZ(getRadiansFromDegree(rotationAnimation.value)),
                      alignment: Alignment.center,
                                  child: CircularButton(
                    
                   
                    color: Colors.red,
                    
                    width: 60,
                    height: 60,
                    icon: Icon(
                      Icons.menu,
                      color:Colors.white
                    ),
                    onClick: (){
                      if(animationController.isCompleted){
                        animationController.reverse();
                      }
                      else{
                        animationController.forward();
                      }
                    },
                  ),
                )
              ],
            ),
          ),
          SafeArea(
            
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 84,
                    margin: EdgeInsets.only(bottom: 30),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 42,
                          backgroundColor: Colors.yellow,
                          backgroundImage: AssetImage(
                              'assets/logogumen.png'),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                       
                      ],
                    ),
                  ),
                  Expanded(
                    child: GridView.count(
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      primary: false,
                      crossAxisCount: 2,
                      children: <Widget>[

                        Card(
                          shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                          child: RaisedButton(
                              shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                            color: Colors.white,
                            
                            child: Ink.image(image: AssetImage('images/carrito1.png'), height: 100, alignment: Alignment.center, 
                           ) , 

                            
                             onPressed: (){
                               
                               Route route = MaterialPageRoute(builder: (bc) => Ventas());
                               Navigator.of(context).push(route);
                              
                             },
                            ),

                           
                          
                        ),

                        Card(
                            shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                          child: RaisedButton(
                             shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                            color: Colors.white,
                            
                            child: Ink.image(image: AssetImage('images/pendientes.png'), height: 100, alignment: Alignment.center, 
                           ) , 

                            
                             onPressed: (){
                               
                               Route route = MaterialPageRoute(builder: (bc) => VentasPendientes());
                               Navigator.of(context).push(route);
                              
                             },
                            ),

                           
                          
                        ),
                        

                        Card(
                          shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                          child: RaisedButton(
                             shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                            color: Colors.white,
                            
                            child: Ink.image(image: AssetImage('images/nomina1.png'), height: 100, alignment: Alignment.center, 
                           ) , 

                            
                             onPressed: (){
                               
                               Route route = MaterialPageRoute(builder: (bc) => Empleados());
                               Navigator.of(context).push(route);
                              
                             },
                             
                            ),
                            
                            
                        ),

                        Card(
                          shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                          child: RaisedButton(
                             shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                            color: Colors.white,
                            
                            child: Ink.image(image: AssetImage('images/stat.png'), height: 100, alignment: Alignment.center, 

                            
                           ) , 
                            
                            
                             onPressed: (){
                               
                               Route route = MaterialPageRoute(builder: (bc) => venta_grafica());
                               Navigator.of(context).push(route);
                              
                             },
                            ),
                        ),

                        Card(
                          shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                          child: RaisedButton(
                             shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                            color: Colors.white,
                            
                            child: Ink.image(image: AssetImage('images/gasto.png'), height: 100, alignment: Alignment.center, 
                           ) , 
                            
                            
                             onPressed: (){
                               
                               Route route = MaterialPageRoute(builder: (bc) => Gastos());
                               Navigator.of(context).push(route);
                              
                             },
                            ),
                           
                        ),

                        Card(
                          shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                          child: RaisedButton(
                             shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                            color: Colors.white,
                            

                            child: Ink.image(image: AssetImage('images/inventario.png'), height: 100, alignment: Alignment.center, 
                           ) , 
                            
                            
                             onPressed: (){
                               
                               Route route = MaterialPageRoute(builder: (bc) => Inventario());
                               Navigator.of(context).push(route);
                              
                             },
                            ),
                        ),
                        Card(
                          shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                          child: RaisedButton(
                             shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                            color: Colors.white,
                            
                            child: Ink.image(image: AssetImage('images/proveedor.png'), height: 100, alignment: Alignment.center, 
                           ) , 
                            
                            
                             onPressed: (){
                             Route route = MaterialPageRoute(builder: (bc) => Proveedores());
                               Navigator.of(context).push(route);
                              
                             },
                            ),
                        ),
                        Card(
                          shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                          child: RaisedButton(
                             shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                            color: Colors.white,
                            
                            child: Ink.image(image: AssetImage('images/meta.png'), height: 100, alignment: Alignment.center, 

                           ) , 
                            
                            
                             onPressed: (){

                    
                               
                               Route route = MaterialPageRoute(builder: (bc) => Meta());
                               Navigator.of(context).push(route);
                              
                             },
                            ),
                           
                        ),

                        Card(
                          shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                          child: RaisedButton(
                             shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                            color: Colors.white,
                            
                            child: Ink.image(image: AssetImage('images/meta.png'), height: 100, alignment: Alignment.center, 

                           ) , 
                            
                            
                             onPressed: (){
                               
                               
                               Route route = MaterialPageRoute(builder: (bc) => venta_grafica2());
                               Navigator.of(context).push(route);
                              
                             },
                            ),
                           
                        ),
                      ],
                    ),
                  ),
                ],
              ),  
            ),
          ),
        ],
      ),
    );
  }
 
}


class CircularButton extends StatelessWidget {
 final double width;
 final double height;
 final Color color;
 final Icon icon;
 final Function onClick;

  const CircularButton({Key key, this.width, this.height, this.color, this.icon, this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      width: width,
      height: height,
      child: IconButton(icon: icon,enableFeedback: true, onPressed: onClick),
      
    );
  }
}
