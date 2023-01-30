import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GridForm extends StatefulWidget {
  const GridForm({Key? key}) : super(key: key);

  @override
  State<GridForm> createState() => _GridFormState();
}

class _GridFormState extends State<GridForm> {
  final _formKey = GlobalKey<FormState>();

  int cols = 1;
  int rows = 1;
  var columnsTEC = TextEditingController(text: "1");
  var rowsTEC = TextEditingController(text: "1");

  String? Function(String? value) fieldsValidator = (String? value){
    if (value == null || value.isEmpty) {
      return 'Empty';
    }
    var i = int.tryParse(value);
    if (i == null) {
      return 'non-integer value';
    }
    if (i < 1) {
      return 'lower than 1';
    }
    return null;
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Field grids"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Form(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: _buildGrids(cols, rows),
                ),
              ),
              Container(
                height: 150,
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Text("Enter columns and rows in your field",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            IconButton(
                                onPressed: (){
                                  if(cols>1) setState(() {
                                    cols--;
                                    columnsTEC.text = '$cols';
                                  });
                                },
                                icon: Icon(Icons.remove_circle,
                                    color: Colors.redAccent
                                )
                            ),
                            Container(
                              width: 75,
                              child: TextFormField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                      labelText: "Columns",
                                      fillColor: Colors.grey[200],
                                      filled: true,
                                      contentPadding: const EdgeInsets.all(10.0)
                                  ),
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  controller:     columnsTEC,
                                  validator: fieldsValidator
                              ),
                            ),
                            IconButton(
                                onPressed: (){
                                  setState(() {
                                    cols++;
                                    columnsTEC.text = '$cols';
                                  });
                                },
                                icon: Icon(Icons.add_circle,
                                    color: Colors.green
                                )
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: (){
                                  if(rows>1) setState(() {
                                    rows--;
                                    rowsTEC.text = '$rows';
                                  });
                                },
                                icon: Icon(Icons.remove_circle,
                                    color: Colors.redAccent
                                )
                            ),
                            Container(
                              width: 75,
                              child: TextFormField(
                                enabled: false,
                                decoration: InputDecoration(
                                    labelText: "Rows",
                                    fillColor: Colors.grey[200],
                                    filled: true,
                                    contentPadding: const EdgeInsets.all(10.0)
                                ),
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                controller: rowsTEC,
                                validator: fieldsValidator
                              ),
                            ),
                            IconButton(
                                onPressed: (){
                                  setState(() {
                                    rows++;
                                    rowsTEC.text = '$rows';
                                  });
                                },
                                icon: Icon(Icons.add_circle,
                                    color: Colors.green
                                )
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _onSavePressed,
                        child: Text("Save"),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onSavePressed() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setInt("field-cols", cols);
    prefs.setInt("field-rows", rows);
  }

  List<Widget> _buildGrids(int cols, int rows){
    List<Widget> grids = [];

    double width = MediaQuery.of(context).size.width ;
    double height = MediaQuery.of(context).size.height;
    height -= 300+(rows*5);
    width  -= 50+((cols-1)*5);
    if(height>width) height = width;
    else width = height;

    for(int i=1; i<=rows ;i++){
      List<Widget> itemPerRow = [];
      for(int j=1; j<=cols ;j++){
        double mr = (j==cols) ? 0 : 5;
        itemPerRow.add(Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(right: mr),
          width:  (rows>cols) ? height/rows : width/cols,
          height: (cols>rows) ? width/cols : height/rows,
          decoration: BoxDecoration(
            border: Border.all(width: 1.0),
            color: Colors.green[100]
          ),
          child: Text("$i.$j"),
        ));
      }
      grids.add(Padding(
        padding: const EdgeInsets.only(bottom: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: itemPerRow,
        ),
      ));

    }

    return grids;
  }
}
