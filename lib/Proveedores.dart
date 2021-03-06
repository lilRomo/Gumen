import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gumen/CrearProveedor.dart';
import 'package:gumen/Menu.dart';
import 'package:intl/intl.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'MenuProveedores.dart';


class Proveedores extends StatefulWidget {


  @override
  _ProveedoresState createState() => _ProveedoresState();
}
var selectedCurrency, selectedType;
var selectedCurrency1, selectedType1;
final db = Firestore.instance;
  String id;

  String descripcion;
  double cantidadInventario;
String productoInventario;
int cont;
  DateTime now = DateTime.now();
String fecha = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
  double cantidad, pago, abono;
  TextEditingController _textFieldController = TextEditingController();

  TextEditingController _textDescripcion = TextEditingController();
  TextEditingController _textPago = TextEditingController();
  TextEditingController _textAbono = TextEditingController();
  bool pendiente;
  
  

class _ProveedoresState extends State<Proveedores> {

  @override
  void initState() {
    pendiente = Global.shared.pendiente;
    super.initState();
    
  }


  TextFormField descripcionProveedor() {
    return TextFormField(
    controller: _textDescripcion,  
    keyboardType: TextInputType.multiline,
    minLines: 1,//Normal textInputField will be displayed
    maxLines: 5,// when user presses enter it will adapt to it
    
      decoration: InputDecoration(
        icon: Icon(
          Icons.description,
          color: Colors.black,
        ),
        labelText: 'Descripciòn',
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        filled: true,
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'No deje Campos Vacios';
        }
      },
      onSaved: (value) => descripcion = value,
    );
  }
  TextFormField cantidadProveedor() {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: _textFieldController,
      decoration: InputDecoration(
        icon: Icon(
          Icons.add,
          color: Colors.black,
        ),
         labelText: 'Cantidad',
         fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        filled: true,
      ),
      
      validator: (value) {
        if (value.isEmpty) {
          return 'No deje Campos Vacios';
        }
      }, 
      onSaved: (value) => cantidad = double.tryParse(value),
    );
    
  }
  TextFormField pagoProveedor() {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: _textPago,
      decoration: InputDecoration(
        icon: Icon(
          Icons.attach_money,
          color: Colors.black,
        ),
         labelText: 'Pago',
         fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        filled: true,
      ),
      
      validator: (value) {
        if (value.isEmpty) {
          return 'No deje Campos Vacios';
        }
      }, 
      onSaved: (value) => pago = double.tryParse(value),
    );
    
  }
  TextFormField abonoProveedor() {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: _textAbono,
      decoration: InputDecoration(
        icon: Icon(
          Icons.attach_money,
          color: Colors.black,
        ),
         labelText: 'Abono',
         fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        filled: true,
      ),
      
      validator: (value) {
        if (value.isEmpty) {
          return 'No deje Campos Vacios';
        }
      }, 
      onSaved: (value) => abono = double.tryParse(value),
    );
    
  }


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
       backgroundColor: Colors.white,
      appBar: _getCustomAppBar(),
       body: ListView(
       
        padding: EdgeInsets.all(8),
        children: <Widget>[
          SizedBox(height: 50.0),
          Form(
            //Nombre
            child:  ListView(
              scrollDirection: Axis.vertical,
    shrinkWrap: true,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.person, color: Colors.black),
                    SizedBox(width: 55.0,),
                     StreamBuilder<QuerySnapshot>(
                       
                  stream: db.collection('NombresProveedores').snapshots(),
                  
                  builder: (context, snapshot) {
                    
                    if (!snapshot.hasData)

                      const Text("Loading.....");
                    else {
                      List<DropdownMenuItem> currencyItems = [];
                      for (int i = 0; i < snapshot.data.documents.length; i++) {
                        DocumentSnapshot snap = snapshot.data.documents[i];
                        currencyItems.add(
                          DropdownMenuItem(
                            child: Text(
                              
                              snap.reference.documentID,
                              style: TextStyle(color: Color.fromARGB(255,98,97,97)),
                            ),
                            value: "${snap.documentID}",
                          ),
                        );
                      }return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          
                          
                          DropdownButton(
                            
                            items: currencyItems,
                            onChanged: (currencyValue) {
                              final snackBar = SnackBar(
                                backgroundColor: Colors.black,
                                content: Text(
                                  'Proveedor: $currencyValue',
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                              Scaffold.of(context).showSnackBar(snackBar);
                              setState(() {
                                selectedCurrency1 = currencyValue;
                              });
                            },
                            value: selectedCurrency1,
                            isExpanded: false,
                            hint: new Text(
                              "Seleccione Proveedor",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      );
                    }
                  }),
                  SizedBox(width: 10.0,),
                   Container(
        height: 40.0,
        width: 40.0,
        child: FittedBox(
        
         child: FloatingActionButton(
           
            child: Icon( Icons.add ),
            backgroundColor: Color(0xFF64DD17),
      
      onPressed: (){
                               
         Route route = MaterialPageRoute(builder: (bc) => CrearProveedor());
         
         Navigator.of(context).push(route);
         },
    ),
        ),
                  ),
                  SizedBox(width: 10.0,),
                  ],
                  
                ),
                
              ],
            ),
          ),
          SizedBox(height: 20.0),
          Form(
            child: descripcionProveedor(),
          ),
          SizedBox(height: 20.0),
          Form(
             child:  ListView(
              scrollDirection: Axis.vertical,
    shrinkWrap: true,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.storage, color: Colors.black),
                    SizedBox(width: 55.0,),
                     StreamBuilder<QuerySnapshot>(
                       
                  stream: db.collection('VentasProducto').snapshots(),
                  
                  builder: (context, snapshot) {
                    
                    if (!snapshot.hasData)

                      const Text("Loading.....");
                    else {
                      List<DropdownMenuItem> currencyItems = [];
                      for (int i = 0; i < snapshot.data.documents.length; i++) {
                        DocumentSnapshot snap = snapshot.data.documents[i];
                        currencyItems.add(
                          DropdownMenuItem(
                            child: Text(
                              
                              snap.reference.documentID,
                              style: TextStyle(color: Color.fromARGB(255,98,97,97)),
                            ),
                            value: "${snap.documentID}",
                          ),
                        );
                      }return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          
                          
                          DropdownButton(
                            
                            items: currencyItems,
                            onChanged: (currencyValue) {
                              final snackBar = SnackBar(
                                backgroundColor: Colors.black,
                                content: Text(
                                  'Producto: $currencyValue',
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                              Scaffold.of(context).showSnackBar(snackBar);
                              setState(() {
                                selectedCurrency = currencyValue;
                              });
                            },
                            value: selectedCurrency,
                            isExpanded: false,
                            hint: new Text(
                              "Seleccione Producto",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      );
                    }
                  }),
                  
                  
                  SizedBox(width: 10.0,),
                  ],
                  
                ),
                
              ],
            ),
          ),
          SizedBox(height: 20.0),
          Form(
            
            child: cantidadProveedor(),
          ),
          SizedBox(height: 20.0),
          Form(
            child: pagoProveedor(),
          ),
          SizedBox(height: 20.0),
          Form(
            child: abonoProveedor(),
          ),
          SizedBox(height: 20.0),
          Form(
             child:LiteRollingSwitch(
    //initial value
     
    value: false,
    textOn: 'Pagado',
    textOff: 'Pendiente',
    colorOn: Colors.greenAccent[700],
    colorOff: Colors.redAccent[700],
    iconOn: Icons.done,
    iconOff: Icons.remove_circle_outline,
    textSize: 16.0,
    
    onChanged: (bool isOn) {
      
            pendiente = isOn;
             Global.shared.pendiente = isOn;
             isOn = isOn;
        print(isOn); 
    },
    
    
), 
          ),
          SizedBox(height: 40.0),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              
              ButtonTheme(
                
                minWidth: 250.0,
                height: 50.0,
                child: RaisedButton(
    color: Color(0xFF64DD17), 
    child: Row( 
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.max, 
    children: <Widget>[
        Padding(
          padding: EdgeInsets.all(5.0),
          child: Text(
              "Generar",
              style: TextStyle(
                fontSize: 18, 
                color: Colors.white, 
              ),
          ),
        ),
        Icon(
          Icons.send, 
          color: Colors.white,
          size: 18, 
        ),
    ],
    ),
            onPressed: () {
                 Route route = MaterialPageRoute(builder: (bc) => HomeScreen());
                               Navigator.of(context).push(route);
                              
                               createData();  
                               actualizarInventario();
                                
     _textDescripcion.text = "";
     _textFieldController.text = "";
     _textPago.text = "";            
            },
),
              ),
              
            ],
            
          ),
        
        ],
  
        
       ),
    );
  }

   _getCustomAppBar(){
  return PreferredSize(
    preferredSize: Size.fromHeight(60),
    child: Container(
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFFFFC107),
            Color(0xFF64DD17),
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
        IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
          Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => MenuProveedor()),
    
  );

        }),
        Text('Proveedores', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),),
        IconButton(icon: Icon(Icons.store), onPressed: (){}),
      ],),
    ),
  );
}
void createData() async {
    
      
      descripcion = _textDescripcion.text;
      cantidad = double.parse(_textFieldController.text);
      pago = double.parse(_textPago.text);
      abono = double.parse(_textAbono.text);
      String fecha = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
      
      if(pendiente == false)
      {
        pendiente = true;
        DocumentReference ref = await db.collection('Proveedores').add({'NombreProveedor': '$selectedCurrency1', 'Cantidad': cantidad,'Abono': abono, 'Pago': pago, 'Fecha': '$fecha','Producto': '$selectedCurrency', 'Pendiente': pendiente, 'Descripcion': descripcion});
        
      setState(() => id = ref.documentID);


      }

      else {
        pendiente = false;
        DocumentReference ref = await db.collection('Ventas').add({'NombreProveedor': '$selectedCurrency1', 'Cantidad': cantidad,'Abono': abono, 'Pago': pago, 'Fecha': '$fecha','Producto': '$selectedCurrency', 'Pendiente': pendiente, 'Descripcion': descripcion});
       
      setState(() => id = ref.documentID); 
      }
  }
   void actualizarInventario() async
 {
   cont = 0;
   db
      .collection("VentasProducto")
      .where("Producto", isEqualTo: selectedCurrency)
      .snapshots()
      .listen((result) {
    result.documents.forEach((result) {
      productoInventario = result.data['Cantidad'].toString();
      cantidadInventario = double.parse(productoInventario);
   if(pendiente==true)
   {
     cantidadInventario += cantidad;
     cont++;
     if(cont == 1)
     {
         db.collection('VentasProducto').document('$selectedCurrency').updateData({'Cantidad': cantidadInventario});
     }
   }
   else
   {
    cantidadInventario += cantidad;
     cont++;
     if(cont == 1)
     {
         db.collection('VentasProducto').document('$selectedCurrency').updateData({'Cantidad': cantidadInventario});
     }
   }
    });
  });
  
 }

}
class Global{
  static final shared =Global();
  bool pendiente = false;
}