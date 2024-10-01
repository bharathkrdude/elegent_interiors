import 'package:elegant_interiors/core/color.dart';
import 'package:elegant_interiors/screens/widgets/primary_button_widget.dart';
import 'package:flutter/material.dart';

class Formdesign extends StatelessWidget {
  const Formdesign({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColorgrey,
      body:Container(
        child: const ProductDetailsWidget())

      ),
    );
  }
}





class ProductDetailsWidget extends StatelessWidget {
  const ProductDetailsWidget({
    super.key,
    
    this.hintTexts = const [],
    this.editPage = false,
  });

  
  final List<String> hintTexts;
  final bool editPage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProductTextFormField(
          hintText: (editPage) ? hintTexts[0] : 'Name',
          iconData: Icons.person_outlined,
          
          name: 'name',
        ),
         ProductTextFormField(
          hintText: (editPage) ? hintTexts[0] : 'Lastname',
          iconData: Icons.person_outlined,
          
          name: 'name',
        ),
        ProductTextFormField(
          hintText: (editPage) ? hintTexts[2] : 'Address',
          iconData: Icons.description_outlined,
          
          name: 'description',
          isMoreLines: true,
        ),
        ProductTextFormField(
          hintText: (editPage) ? hintTexts[3] : 'Enter price',
          iconData: Icons.money_outlined,
         
          name: 'price',
          type: true,
        ),
        ProductTextFormField(
          hintText: (editPage) ? hintTexts[4] : 'Enter quantity',
          iconData: Icons.numbers_outlined,
          
          name: 'quantity',
          type: true,
        ),
        ProductTextFormField(
          hintText: (editPage) ? hintTexts[5] : 'Enter unit',
          iconData: Icons.numbers_outlined,
          
          name: 'unit',
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: PrimaryButtonWidget(
                  title: "Submit",
                  onPressed: (){
                    Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const Formdesign()));
                  }
                ),
        ), 
      
      ],
    );
  }
}





class ProductTextFormField extends StatelessWidget {
  final String name;
  final String hintText;
  final IconData iconData;
  final bool type;
  final bool isMoreLines;

  const ProductTextFormField({
    super.key,
    required this.hintText,
    required this.iconData,
    this.type = false,
    required this.name,
    this.isMoreLines = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        keyboardType: type
            ? const TextInputType.numberWithOptions(decimal: true)
            : TextInputType.text,
        cursorColor: Colors.black,
        maxLines: isMoreLines ? 5 : 1,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.black54, fontSize: 14),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xff388E3C),
            ),
          ),
          border: const OutlineInputBorder(),
          prefixIcon: Icon(iconData),
          prefixIconColor: Colors.black54,
        ),
      ),
    );
  }
}
