import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const DashboardApp());
}

// ============================================================
// APP
// ============================================================

class DashboardApp extends StatelessWidget {
  const DashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Responsive Adaptive Dashboard',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
      ),
      home: const DashboardPage(),
    );
  }
}

// ============================================================
// RESPONSIVE PAGE
// ============================================================

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int selectedIndex = 0;

  void changePage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        // MOBILE
        if (width < 600) {
          return ResponsiveScaffold(
            columns: 1,
            layoutName: 'Mobile Layout',
            selectedIndex: selectedIndex,
            onNavigationChanged: changePage,
          );
        }

        // TABLET / IPAD
        if (width < 1024) {
          return ResponsiveScaffold(
            columns: 2,
            layoutName: 'Tablet / iPad Layout',
            selectedIndex: selectedIndex,
            onNavigationChanged: changePage,
          );
        }

        // DESKTOP
        return DesktopDashboard(
          selectedIndex: selectedIndex,
          onNavigationChanged: changePage,
        );
      },
    );
  }
}

// ============================================================
// MOBILE + TABLET
// COLLAPSIBLE SIDEBAR
// ============================================================

class ResponsiveScaffold extends StatelessWidget {
  final int columns;
  final String layoutName;
  final int selectedIndex;
  final ValueChanged<int> onNavigationChanged;

  const ResponsiveScaffold({
    super.key,
    required this.columns,
    required this.layoutName,
    required this.selectedIndex,
    required this.onNavigationChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(
        selectedIndex: selectedIndex,
        onChanged: (index) {
          Navigator.pop(context);
          onNavigationChanged(index);
        },
      ),

      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: DashboardContent(
        columns: columns,
        layoutName: layoutName,
      ),

      bottomNavigationBar: AdaptiveBottomNavigation(
        selectedIndex: selectedIndex,
        onChanged: onNavigationChanged,
      ),
    );
  }
}

// ============================================================
// DESKTOP
// PERMANENT SIDEBAR
// ============================================================

class DesktopDashboard extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onNavigationChanged;

  const DesktopDashboard({
    super.key,
    required this.selectedIndex,
    required this.onNavigationChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SizedBox(
            width: 230,
            child: AppSidebar(
              selectedIndex: selectedIndex,
              onChanged: onNavigationChanged,
            ),
          ),
          const Expanded(
            child: DashboardContent(
              columns: 3,
              layoutName: 'Desktop Layout',
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// DASHBOARD CONTENT
// ============================================================

class DashboardContent extends StatelessWidget {
  final int columns;
  final String layoutName;

  const DashboardContent({
    super.key,
    required this.columns,
    required this.layoutName,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ------------------------------------------------
            // TITLE
            // ------------------------------------------------

            Text(
              layoutName,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),

            const SizedBox(height: 6),

            Text(
              getPlatformName(),
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 24),

            // ------------------------------------------------
            // DASHBOARD CARDS
            // ------------------------------------------------

            GridView.count(
              crossAxisCount: columns,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),

              // FIX FOR RENDERFLEX OVERFLOW
              mainAxisExtent: columns == 1 ? 135 : 150,

              children: const [
                DashboardCard(
                  title: 'Users',
                  value: '1,240',
                  icon: Icons.people_outline,
                ),
                DashboardCard(
                  title: 'Sales',
                  value: '₱25,400',
                  icon: Icons.payments_outlined,
                ),
                DashboardCard(
                  title: 'Orders',
                  value: '320',
                  icon: Icons.shopping_bag_outlined,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ------------------------------------------------
            // ACTIVITY AREA
            // ------------------------------------------------

            Text(
              'Overview',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),

            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.bar_chart,
                      size: 44,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Chart / Activity Area',
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 28),

            // ------------------------------------------------
            // ADAPTIVE UI EXAMPLE
            // ------------------------------------------------

            Text(
              'Adaptive UI',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),

            const SizedBox(height: 6),

            Text(
              'The control below changes depending on the platform.',
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 16),

            const AdaptiveButton(),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// DASHBOARD CARD
// ============================================================

class DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const DashboardCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 28,
              color: Theme.of(context).colorScheme.primary,
            ),

            const SizedBox(height: 8),

            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.grey.shade700,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// DESKTOP SIDEBAR
// ============================================================

class AppSidebar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const AppSidebar({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue.shade50,
      child: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(24),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.dashboard,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Dashboard',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SidebarItem(
              icon: Icons.home_outlined,
              label: 'Home',
              selected: selectedIndex == 0,
              onTap: () => onChanged(0),
            ),

            SidebarItem(
              icon: Icons.person_outline,
              label: 'Profile',
              selected: selectedIndex == 1,
              onTap: () => onChanged(1),
            ),

            SidebarItem(
              icon: Icons.search,
              label: 'Search',
              selected: selectedIndex == 2,
              onTap: () => onChanged(2),
            ),

            SidebarItem(
              icon: Icons.analytics_outlined,
              label: 'Analytics',
              selected: selectedIndex == 3,
              onTap: () => onChanged(3),
            ),

            const Spacer(),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Responsive + Adaptive UI',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// SIDEBAR ITEM
// ============================================================

class SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const SidebarItem({
    super.key,
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 3,
      ),
      child: ListTile(
        selected: selected,
        selectedTileColor: Colors.blue.shade100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        leading: Icon(icon),
        title: Text(label),
        onTap: onTap,
      ),
    );
  }
}

// ============================================================
// MOBILE / TABLET DRAWER
// ============================================================

class AppDrawer extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const AppDrawer({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: AppSidebar(
        selectedIndex: selectedIndex,
        onChanged: onChanged,
      ),
    );
  }
}

// ============================================================
// ADAPTIVE BOTTOM NAVIGATION
// ============================================================

class AdaptiveBottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const AdaptiveBottomNavigation({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    // --------------------------------------------------------
    // IOS
    // --------------------------------------------------------

    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.iOS) {
      return CupertinoTabBar(
        currentIndex: selectedIndex > 2 ? 0 : selectedIndex,
        onTap: onChanged,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            label: 'Search',
          ),
        ],
      );
    }

    // --------------------------------------------------------
    // ANDROID + WEB
    // --------------------------------------------------------

    return NavigationBar(
      selectedIndex: selectedIndex > 2 ? 0 : selectedIndex,
      onDestinationSelected: onChanged,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline),
          selectedIcon: Icon(Icons.person),
          label: 'Profile',
        ),
        NavigationDestination(
          icon: Icon(Icons.search),
          selectedIcon: Icon(Icons.search),
          label: 'Search',
        ),
      ],
    );
  }
}

// ============================================================
// ADAPTIVE BUTTON
// ============================================================

class AdaptiveButton extends StatelessWidget {
  const AdaptiveButton({super.key});

  @override
  Widget build(BuildContext context) {
    // --------------------------------------------------------
    // WEB
    // --------------------------------------------------------

    if (kIsWeb) {
      return ElevatedButton.icon(
        onPressed: () {
          showMessage(context, 'Web button pressed');
        },
        icon: const Icon(Icons.language),
        label: const Text('Web Action'),
      );
    }

    // --------------------------------------------------------
    // IOS
    // --------------------------------------------------------

    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return CupertinoButton.filled(
        onPressed: () {
          showMessage(context, 'iOS button pressed');
        },
        child: const Text('iOS Action'),
      );
    }

    // --------------------------------------------------------
    // ANDROID
    // --------------------------------------------------------

    if (defaultTargetPlatform == TargetPlatform.android) {
      return FilledButton.icon(
        onPressed: () {
          showMessage(context, 'Android button pressed');
        },
        icon: const Icon(Icons.android),
        label: const Text('Android Action'),
      );
    }

    // --------------------------------------------------------
    // OTHER DESKTOP PLATFORMS
    // --------------------------------------------------------

    return FilledButton.icon(
      onPressed: () {
        showMessage(context, 'Desktop button pressed');
      },
      icon: const Icon(Icons.computer),
      label: const Text('Desktop Action'),
    );
  }
}

// ============================================================
// MESSAGE
// ============================================================

void showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}

// ============================================================
// PLATFORM DETECTION
// ============================================================

String getPlatformName() {
  if (kIsWeb) {
    return 'Platform: Web';
  }

  switch (defaultTargetPlatform) {
    case TargetPlatform.iOS:
      return 'Platform: iOS';

    case TargetPlatform.android:
      return 'Platform: Android';

    case TargetPlatform.windows:
      return 'Platform: Windows';

    case TargetPlatform.macOS:
      return 'Platform: macOS';

    case TargetPlatform.linux:
      return 'Platform: Linux';

    case TargetPlatform.fuchsia:
      return 'Platform: Fuchsia';
  }
}