import 'package:Tipcalculator/Util/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:Tipcalculator/Util/hexcolor.dart';

class Billsplitter extends StatefulWidget {
  @override
  _BillsplitterState createState() => _BillsplitterState();
}

class _BillsplitterState extends State<Billsplitter> {
  int _tippercentage=0;
  int _personcounter=1;
  double _billamount=0;
  Color _purple=hexcolor("#6908D6");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1),
        alignment: Alignment.center,
        color: Colors.white,
        child:ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20.5),
          children: [
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                color: _purple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(23)
              ),
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text("Total for Person is:",style: TextStyle(
                        fontSize: 15,
                        color: _purple,
                        fontWeight: FontWeight.normal
                      ),),
                    ),
                    Text("\$ ${calculateperperson(_billamount,_personcounter,_tippercentage)}",style: TextStyle(
                      color: _purple,
                      fontWeight: FontWeight.bold,
                      fontSize: 34.9
                    ),),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(8.0),
              padding:EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.blueGrey.shade200,
                  style: BorderStyle.solid
                ),
                borderRadius: BorderRadius.circular(12)
              ),
              child: Column(
                children: [
                  TextField(
                    keyboardType: TextInputType.numberWithOptions(decimal:true),
                    style: TextStyle(color:_purple),
                    decoration: InputDecoration(
                      prefixText:"Bill Amount Is:",
                      prefixIcon: Icon(Icons.attach_money_sharp)
                    ),
                    onChanged: (String value){
                      try{
                        _billamount=double.parse(value);
                      }
                      catch(exception){
                        _billamount=0.0;
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Split:",style: TextStyle(color: Colors.grey.shade200),),
                      Row(
                        children: [
                          InkWell(
                            onTap: (){
                              setState(() {
                                if(_personcounter>1)
                                  {
                                    _personcounter--;
                                  }
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.0),
                                color: _purple.withOpacity(0.1),
                              ),
                              child:Center(
                                child: Text(
                                  "-",style: TextStyle(color: _purple,fontWeight: FontWeight.bold,fontSize: 17),
                                ),
                              )
                            ),
                          ),
                          Text("$_personcounter",style: TextStyle(
                            color:_purple,
                            fontWeight: FontWeight.bold,
                            fontSize: 17
                          ),),
                          InkWell(
                            onTap: (){
                              setState(() {
                                _personcounter++;
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: _purple.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Center(
                                child: Text("+",style: TextStyle(
                                  color: _purple,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,

                                ),),
                              ),
                            ),
                          ),

                        ],
                      ),

                    ],                    
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Tip",style: TextStyle(
                          color: Colors.grey.shade700
                      ),),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("\$ ${calculatetotaltip(_billamount, _personcounter, _tippercentage)}",style: TextStyle(
                          color: _purple,
                          fontWeight: FontWeight.bold,
                          fontSize:17.0
                        ),),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text("$_tippercentage\%",style: TextStyle(
                        color: _purple,
                        fontSize: 17,
                        fontWeight:FontWeight.bold
                      ),),
                      Slider(
                        min: 0,
                        max:100,
                        divisions:10,
                        activeColor: _purple,
                        inactiveColor: Colors.grey,
                        value: _tippercentage.toDouble(),onChanged:(double value){
                        setState(() {
                          _tippercentage=value.round();
                        });
                      },)
                    ],
                  )
                ],
              ),
            ),
          ],
        )
      )
    );
  }

  calculateperperson(double billamount,int splitby,int tippercentage){
    var totalperson=(calculatetotaltip(billamount, splitby, tippercentage)+billamount)/splitby;
    return totalperson.toStringAsFixed(2);
  }

  calculatetotaltip(double billamt,int splitby,int tippercentage){
    double totaltip=0;
    if(billamt<0 || billamt.toString().isEmpty || billamt == null){

    }
    else{
      totaltip=(billamt * tippercentage)/100;
    }
    return totaltip;
  }

}
