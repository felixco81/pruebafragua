import 'package:flutter/material.dart';
import '../theme/colors.dart';



class ImageScreen extends StatelessWidget {
  final String imageUrl; // parámetro que recibirá la URL

  // Constructor obligatorio con required
  const ImageScreen({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
  color: Colors.black,
  child:
     Stack( 
          children: [ 
          
            Positioned(
              top: 60, 
              left: 0,
              right: 0,
              bottom: 0,
              child: InteractiveViewer(
              panEnabled: true, // permite mover la imagen
              minScale: 1.0,    // escala mínima
              maxScale: 4.0,    // escala máxima
              child: Image.network(
                imageUrl,
                fit: BoxFit.contain,
              ),
            ),
            ), 
              Positioned(
              top: 60, 
              right: 0,
              child: Column(
                children: [
                  IconButton(
                    style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(const Color.fromARGB(78, 0, 0, 0))),
                    onPressed: (){
                      Navigator.pop(context);
                  }, icon:  Icon(
                    Icons.close, // ícono que quieras
                    color: AppColors.lightGreen,
                    size: 40,
                  ), )
                ],
              ),
            ),

          ],
     )
        );
  }
}
