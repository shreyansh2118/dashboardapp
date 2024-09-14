import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:math';

import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UI Layout',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true, // Enable Material You
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              // Sidebar
              if (constraints.maxWidth >
                  600) // Only show sidebar if width is sufficient
                Container(
                  width: 250,
                  color: Colors.white,
                  child: Column(
                    children: [
                      UserProfile(),
                      SidebarItem(
                          icon: Icons.home, label: 'Home', isActive: true),
                      SidebarItem(icon: Icons.person, label: 'Employees'),
                      SidebarItem(
                          icon: Icons.calendar_today, label: 'Attendance'),
                      SidebarItem(icon: Icons.book, label: 'Summary'),
                      SidebarItem(icon: Icons.info, label: 'Information'),
                      SidebarSection(label: 'WORKSPACES'),
                      SidebarItem(icon: Icons.workspaces, label: 'Adstacks'),
                      SidebarItem(
                          icon: Icons.account_balance, label: 'Finance'),
                      const Spacer(),
                      SidebarItem(icon: Icons.settings, label: 'Settings'),
                      SidebarItem(icon: Icons.logout, label: 'Logout'),
                    ],
                  ),
                ),
              // Main content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // Top bar with search and profile
                      TopBar(),
                      const SizedBox(height: 16),
                      // Middle content with projects, creators, and charts
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              flex: constraints.maxWidth > 600 ? 2 : 1,
                              child: Column(
                                children: [
                                  ProjectCard(),
                                  ProjectList(),
                                  PerformanceChart(),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            if (constraints.maxWidth > 600)
                              Expanded(
                                flex: 1,
                                child: Container(
                                  color: const Color.fromARGB(255, 40, 2, 105),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 5,),
                                      Text("General 10:00 AM to 7:00 PM",style: TextStyle(color: Colors.white),),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, left: 15.0, right: 15),
                                        child: CalendarWidget(),
                                      ),
                                      const SizedBox(height: 16),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15.0, right: 15),
                                        child: BirthdayCard(),
                                      ),
                                      const SizedBox(height: 16),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15.0, right: 15),
                                        child: AnniversaryCard(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// Widgets

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage("img2.png"),
          ),
          const SizedBox(height: 10),
          const Text(
            'xyz',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.purple),
                  borderRadius: const BorderRadius.all(Radius.circular(15))),
              child: const Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                child: Text('Admin', style: TextStyle(color: Colors.grey)),
              )),
        ],
      ),
    );
  }
}

class SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;

  SidebarItem({required this.icon, required this.label, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isActive ? Colors.blue[50] : null,
      child: ListTile(
        leading: Icon(icon, color: isActive ? Colors.blue : Colors.black),
        title: Text(label,
            style: TextStyle(color: isActive ? Colors.blue : Colors.black)),
      ),
    );
  }
}

class SidebarSection extends StatelessWidget {
  final String label;

  SidebarSection({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(label,
            style: const TextStyle(fontSize: 12, color: Colors.grey)),
        trailing: const Icon(Icons.add, color: Colors.grey),
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Home',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        Row(
          children: [
          
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.logout)),
            const CircleAvatar(
              backgroundImage: AssetImage("img3.png"),
            ),
          ],
        ),
      ],
    );
  }
}

class ProjectCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.purple[100],
        borderRadius: BorderRadius.circular(10),
        image: const DecorationImage(
          image: AssetImage('assets/header.webp'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Top Rating Project',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'This project has been rated highly by users',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Learn More'),
          ),
        ],
      ),
    );
  }
}

class ProjectList extends StatefulWidget {
  @override
  _ProjectListState createState() => _ProjectListState();
}

class _ProjectListState extends State<ProjectList> {
  // Variable to track the selected index
  int selectedIndex = 0;

  // Function to handle selection
  void _handleSelection(int index) {
    setState(() {
      selectedIndex = index; // Update to the selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1b244a),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  const Text(
                    "All Projects",
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 5),
                  _buildProjectListTile(0),
                  _buildProjectListTile(1),
                  _buildProjectListTile(2),
                ],
              ),
            ),
          ),
          const SizedBox(width: 20),
          Flexible(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color(0xFF1b244a),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  const Text(
                    "Top Creators",
                    style: TextStyle(color: Colors.white),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Name',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Artworks',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        "Rating",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  _buildCreatorRow(),
                  _buildCreatorRow(),
                  _buildCreatorRow(),
                  _buildCreatorRow(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Method to build Project ListTile
  Widget _buildProjectListTile(int index) {
    return GestureDetector(
      onTap: () {
        _handleSelection(index); // Handle selection on tap
      },
      child: Container(
        color: selectedIndex == index
            ? Colors.red
            : Colors.transparent, // Change color only for selected index
        child: ListTile(
          leading: Container(
            height: 30,
            width: 25,
            child: Image.asset("img.jpg"),
          ),
          title: const Text(
            'Technology behind the blockchain',
            style: TextStyle(color: Colors.white),
          ),
          subtitle: const Text(
            'Project #1 This project discusses...',
            style: TextStyle(color: Colors.white),
          ),
          trailing: const Icon(
            Icons.edit,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // Method to build Creator Row
  Widget _buildCreatorRow() {
    return Row(
      children: [
        Container(
          height: 30,
          width: 25,
          child: const CircleAvatar(
            radius: 12.5,
            backgroundImage: AssetImage('assets/img.jpg'),
          ),
        ),
        const SizedBox(width: 10),
        const Text(
          'user@example.com',
          style: TextStyle(color: Colors.white),
        ),
        const SizedBox(width: 20),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            '9821',
            style: TextStyle(
                color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 20),
        SizedBox(
          width: 60,
          child: LinearProgressIndicator(
            value: 0.7,
            backgroundColor: Colors.grey[300],
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}

class PerformanceChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<ChartData> Data1 = _generateData1();
    List<ChartData> Data2 = _generateData2();

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Overall Performance of the Year",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 150,
            child: SfCartesianChart(
              primaryXAxis: const NumericAxis(
                majorTickLines: MajorTickLines(color: Colors.purple),
                axisLine: AxisLine(color: Colors.purple),
                majorGridLines: MajorGridLines(color: Colors.purple),
                labelStyle: TextStyle(color: Colors.purple),
              ),
              primaryYAxis: const NumericAxis(
                majorTickLines: MajorTickLines(color: Colors.purple),
                axisLine: AxisLine(color: Colors.purple),
                majorGridLines: MajorGridLines(color: Colors.purple),
                labelStyle: TextStyle(color: Colors.purple),
              ),
              legend: const Legend(isVisible: true),
              series: <CartesianSeries<ChartData, double>>[
                LineSeries<ChartData, double>(
                  name: 'Pending done',
                  dataSource: Data1,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                ),
                LineSeries<ChartData, double>(
                  name: 'Project done',
                  dataSource: Data2,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  color: Colors.orange, // Set the graph color to orange
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<ChartData> _generateData1() {
    return List.generate(360, (index) {
      double radians = index * pi / 180;
      return ChartData(index.toDouble(), sin(radians));
    });
  }

  List<ChartData> _generateData2() {
    return List.generate(360, (index) {
      double radians = index * pi / 180;
      return ChartData(index.toDouble(), cos(radians));
    });
  }
}

class ChartData {
  final double x;
  final double y;

  ChartData(this.x, this.y);
}

class CalendarWidget extends StatefulWidget {
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 210, // Adjust height to avoid overflow
            width: double.infinity, // Full width of the container
            child: TableCalendar(
              firstDay: DateTime.utc(2020, 01, 01),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) =>
                  _selectedDay != null && isSameDay(_selectedDay, day),
              calendarStyle: const CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.blueAccent,
                  shape: BoxShape.circle,
                ),

                selectedTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 14), // Font size for selected day
                todayTextStyle: TextStyle(
                    color: Colors.white, fontSize: 14), // Font size for today
                // Font size for other dates
                outsideTextStyle: TextStyle(
                    fontSize: 14,
                    color: Colors
                        .grey), // Font size for dates outside the current month
              ),
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12), // Font size for the header
                leftChevronIcon: Icon(Icons.chevron_left, size: 14),
                rightChevronIcon: Icon(Icons.chevron_right, size: 14),
              ),
              daysOfWeekStyle: const DaysOfWeekStyle(
                weekdayStyle: TextStyle(fontSize: 14), // Font size for weekdays
                weekendStyle: TextStyle(fontSize: 14), // Font size for weekends
              ),

              rowHeight:
                  27, // Adjust row height to control the calendar's overall size
              availableGestures:
                  AvailableGestures.all, // Ensure gestures are not restricted
            ),
          ),
          if (_selectedDay != null) ...[
            const SizedBox(height: 12),
            Text(
              'Selected Date: ${_selectedDay!.toLocal()}'.split(' ')[0],
              style: const TextStyle(
                fontSize: 14, // Font size for the selected date text
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class BirthdayCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF3c354a),
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Heading
          const Center(
            child: Text(
              'Today Birthday',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18, // Adjust font size as needed
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Column with CircleAvatars and Text
          Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  SizedBox(width: 36),
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.red,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Text with lines and number
              const Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Total',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(
                        width: 38,
                      ),
                      Text('|  2  |',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 8),
                ],
              ),
              const SizedBox(height: 12),

              // Celebrate button
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(
                      0xFFb97df5), // Set background color using hexadecimal code
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.send,
                      size: 18,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Birthday Wishing',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class AnniversaryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF3c354a),
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Heading
          const Center(
            child: Text(
              'Anniversary',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18, // Adjust font size as needed
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Column with CircleAvatars and Text
          Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  SizedBox(width: 36),
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.red,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  SizedBox(width: 36),
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.red,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Text with lines and number
              const Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Total',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(
                        width: 38,
                      ),
                      Text('|  3  |',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 8),
                ],
              ),
              const SizedBox(height: 12),

              // Celebrate button
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(
                      0xFFb97df5), // Set background color using hexadecimal code
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.send,
                      size: 18,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Anniversary Wishing',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
