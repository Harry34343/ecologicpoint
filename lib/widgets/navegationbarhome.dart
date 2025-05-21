import 'package:flutter/material.dart';
// Remove SvgPicture import if not used for icons here

class CustomBottomNavBar extends StatefulWidget {
  // Keep StatefulWidget if you have local animations for icons
  final int currentIndex;
  final ValueChanged<int> onItemSelected;

  const CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  // No local _selectedIndex needed here, it's controlled by widget.currentIndex

  @override
  Widget build(BuildContext context) {
    double relWidth(double w) => MediaQuery.of(context).size.width * (w / 440);
    double relHeight(double h) =>
        MediaQuery.of(context).size.height * (h / 900);

    // THIS WIDGET RETURNS A BottomAppBar, NOT A SCAFFOLD
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      elevation: 8.0,
      color: Colors.white,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(relWidth(24)),
          topRight: Radius.circular(relWidth(24)),
        ),
        child: SizedBox(
          height: relHeight(70),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildNavIcon(context, Icons.home, 'Inicio', 0, relWidth),
              _buildNavIcon(
                context,
                Icons.pin_drop_rounded,
                'Mapa',
                1,
                relWidth,
              ),
              SizedBox(width: relWidth(60)), // Placeholder for FAB notch
              _buildNavIcon(
                context,
                Icons.list,
                'Retos',
                3,
                relWidth,
              ), // Index 2 is FAB
              _buildNavIcon(context, Icons.person, 'Perfil', 4, relWidth),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavIcon(
    BuildContext context,
    IconData icon,
    String label,
    int index,
    double Function(double) relWidth,
  ) {
    final isSelected = widget.currentIndex == index;
    // Use MediaQuery directly in relHeight if needed here, or pass screenHeight
    double relHeightLocal(double h) =>
        MediaQuery.of(context).size.height * (h / 900);

    return Expanded(
      child: InkWell(
        onTap: () {
          widget.onItemSelected(index); // This calls the callback in Plant1
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? const Color(0xFF355E3B) : Colors.grey,
              size: relWidth(24),
            ),
            SizedBox(
              height: relHeightLocal(4),
            ), // Use local relHeight or pass from parent
            Text(
              label,
              style: TextStyle(
                fontSize: relWidth(10),
                color: isSelected ? const Color(0xFF355E3B) : Colors.grey,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
