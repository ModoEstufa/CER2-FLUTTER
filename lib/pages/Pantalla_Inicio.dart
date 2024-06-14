import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PantallaInicio extends StatelessWidget {
  const PantallaInicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 111, 8, 8),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Button(
                    onPressed: () => Navigator.pushNamed(context, '/PartidosTab'),
                    icon: Icons.person_2_rounded,
                  ),
                  Button(
                    onPressed: () => Navigator.pushNamed(context, '/PantallaEquipos'),
                    icon: Icons.assignment,
                  ),
                ],
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Button(
                    onPressed: () => Navigator.pushNamed(context, '/Servicios'),
                    icon: Icons.room_service_outlined,
                  ),
                  Button(
                    onPressed: () => Navigator.pushNamed(context, '/Hoteles'),
                    icon: Icons.home_work,
                  ),
                ],
              ),
              SizedBox(height: 50),
              Image.asset(
                'assets/letras2 (2).png',
                width: 200,
                height: 200,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.earth),
            label: 'Home',
            
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.setAll),
            label: 'Partidos',
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.earth),
            label: 'Equipos',
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.faceMan),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }

  Widget Button({required VoidCallback onPressed, required IconData icon}) {
    return Container(
      width: 150,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 50,
          color: Color.fromARGB(255, 42, 40, 39),
        ),
      ),
    );
  }
}
