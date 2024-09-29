import 'package:ecommerce_app/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AttributesScreen extends StatefulWidget {
  AttributesScreen({super.key});

  @override
  State<AttributesScreen> createState() => _AttributesScreenState();
}

class _AttributesScreenState extends State<AttributesScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final TextEditingController _sizedController = TextEditingController();
  bool _isEnterSized = false;
  bool _isSaved = false;
  List<String> _sizedList = [];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProdcutProvider _productProvider =
        Provider.of<ProdcutProvider>(context);
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(children: [
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'Enter Brand Name';
            } else {
              return null;
            }
          },
          onChanged: (value) {
            _productProvider.getFormData(brandName: value);
          },
          decoration: const InputDecoration(
              hintText: 'Enter Brand Name',
              labelText: 'Brand',
              labelStyle:
                  TextStyle(fontWeight: FontWeight.bold, letterSpacing: 3)),
        ),
        SizedBox(
          height: 15,
        ),
        Row(children: [
          Flexible(
            child: Container(
              width: 130,
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Product Size';
                  } else {
                    return null;
                  }
                },
                controller: _sizedController,
                onChanged: (value) {
                  setState(() {
                    _isEnterSized = true;
                  });
                },
                decoration: const InputDecoration(
                    hintText: 'Enter Product Size',
                    labelText: 'Size',
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold, letterSpacing: 3)),
              ),
            ),
          ),
          _isEnterSized == true
              ? ElevatedButton(
                  onPressed: () {
                    _sizedList.add(_sizedController.text);
                    _sizedController.clear();
                    print(_sizedList);
                    setState(() {
                      _isEnterSized = false;
                    });
                  },
                  child: Text('Add Size'))
              : Text('')
        ]),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 50,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _sizedList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _sizedList.removeAt(index);
                        });
                        _productProvider.getFormData(sizeList: _sizedList);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.pink,
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            _sizedList[index],
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ),
        if (_sizedList.isNotEmpty)
          ElevatedButton(
              onPressed: () {
                setState() {
                  _isSaved = true;
                }

                _productProvider.getFormData(sizeList: _sizedList);
              },
              child: _isSaved == true ? Text('Saved') : Text('Save'))
      ]),
    ));
  }
}
