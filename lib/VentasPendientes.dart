import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'Menu.dart';
import 'package:intl/intl.dart';


  String id;
  final db = Firestore.instance;
  String nombre;
  DateTime now = DateTime.now();
  String fecha = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
  String tcosto;
  dynamic obtcosto;
  dynamic total;
  dynamic total2;
class VentasPendientes extends StatefulWidget {
 @override
  _VentasPendientesState createState() => _VentasPendientesState();
    
}




class _VentasPendientesState extends State<VentasPendientes> {

TextEditingController _textFieldController = TextEditingController();
  _displayDialog(BuildContext context, DocumentSnapshot doc) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Editar Total'),
            content: TextField(
              keyboardType: TextInputType.number,
              controller: _textFieldController,
              decoration: InputDecoration(suffixText:'${doc.data['Saldo']}'), 
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Guardar'),
                onPressed: () {
                  obtcosto = double.parse(_textFieldController.text);
                  print(obtcosto);
                  Navigator.of(context).pop();
                  
                  updateCantidad(doc);
                },
              
              )
            ],
          );
        });
  }

  
  Card buildItem(DocumentSnapshot doc) {
    
    nombre = doc.data['Nombre'];
    
    return Card(
      
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    color: Colors.black,
      child: Padding(
        
        padding: const EdgeInsets.all(8.0),
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          
          children: <Widget>[
            
           const ListTile(
            title: Text('           Pendiente', style: TextStyle(color: Colors.white)),
            leading: Icon(Icons.timer, size: 30, color: Colors.white),
          ),
            Text(
              
              'Nombre: ${doc.data['Nombre']}            ${doc.data['Producto']} ',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            Text(
              'Cantidad: ${doc.data['Cantidad']} Kg',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            Text(
              'Saldo: ${doc.data['Saldo']} \$',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(height: 10.0),
            new Container(
  margin: const EdgeInsets.all(15.0),
  padding: const EdgeInsets.all(3.0),
  decoration: BoxDecoration(
    
    border: Border.all(color: Colors.yellowAccent)
  ),
  child: Text('          ${doc.data['Fecha']}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
),
            
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SizedBox.fromSize(
  size: Size(100, 40), // button width and height
  child: ClipRRect(
    child: Material(
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0),
    ),
      color: Colors.green, // button color
      child: InkWell(
        splashColor: Colors.blue, // splash color
        onTap:  () => updateData(doc), // button pressed
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.payment), // icon
            Text("Pagar", style: TextStyle(color: Colors.white)), // text
          ],
        ),
      ),
    ),
  ),
),
                SizedBox(width: 8),
               SizedBox.fromSize(
  size: Size(100, 40), // button width and height
  child: ClipRRect(
    child: Material(
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0),
    ),
      color: Colors.blue, // button color
      child: InkWell(
        splashColor: Colors.green, // splash color
        onTap:  () {
          _displayDialog(context, doc);
        }, // button pressed
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.edit), // icon
            Text("Editar", style: TextStyle(color: Colors.white)), // text
          ],
        ),
      ),
    ),
  ),
),
SizedBox(width: 8),
               SizedBox.fromSize(
  size: Size(100, 40), // button width and height
  child: ClipRRect(
    child: Material(
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0),
    ),
      color: Colors.red, // button color
      child: InkWell(
        splashColor: Colors.green, // splash color
        onTap:  () => showAlertDialog(context, doc), // button pressed
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.delete), // icon
            Text("Borrar", style: TextStyle(color: Colors.white)), // text
          ],
        ),
      ),
    ),
  ),
)
              ],
            )
          ],
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: _getCustomAppBar(),
        body: ListView(
        padding: EdgeInsets.all(8),
        children: <Widget>[
          
             StreamBuilder<QuerySnapshot>(
            stream: db.collection('Ventas').where("Pendiente", isEqualTo: true).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(children: snapshot.data.documents.map((doc) => buildItem(doc)).toList());
              } else {
                return SizedBox();
              }
            },
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
            Color(0xFFFFE57F),
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
        IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
          Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => HomeScreen()),
  );

        }),
        Text('Ventas Pendientes', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),),
        IconButton(icon: Icon(Icons.access_time), onPressed: (){}),
      ],),
    ),
  );
}


  void updateData(DocumentSnapshot doc) async {
    total = doc.data['Saldo'];
    total2 = doc.data['Costo'];

    total2 += total;
    await db.collection('Ventas').document(doc.documentID).updateData({'Pendiente': false, 'Costo':total2, 'Saldo': 0});
  }

  void updateCantidad(DocumentSnapshot doc) async {
    total = doc.data['Saldo'];
    total2 = doc.data['Costo'];
    
    total -= obtcosto;
    total2 += obtcosto;
    await db.collection('Ventas').document(doc.documentID).updateData({'Saldo': total, 'Costo':total2});
  
    
  }

  void deleteData(DocumentSnapshot doc) async {
    await db.collection('Ventas').document(doc.documentID).delete();
    setState(() => id = null);
  }

showAlertDialog(BuildContext context, DocumentSnapshot doc) {

  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text("Cancelar"),
    onPressed:  () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = FlatButton(
    child: Text("Borrar"),
    onPressed:  () {
      deleteData(doc);
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Alerta!"),
    content: Text("¿Estás seguro de que quieres eliminar esta venta?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}


  
}




