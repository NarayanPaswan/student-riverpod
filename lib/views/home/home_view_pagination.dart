import 'package:dio/dio.dart';
import '../../utils/exports.dart';
import '../auth/controller/auth_controller.dart';
import '../auth/login_view.dart';

class HomeViewPagination extends StatefulWidget {
  const HomeViewPagination({Key? key}) : super(key: key);

  @override
  State<HomeViewPagination> createState() => _HomeViewPaginationState();
}

class _HomeViewPaginationState extends State<HomeViewPagination> {
  final authcontroll = AuthController();
  final scrollController = ScrollController();
  bool isLoadingMore = false;
  int pageNo = 1;
  List students = [];
  bool hasMoreData = true;
    showSnackBar (BuildContext context){
    final snackBar = SnackBar(content: Text("hi"));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
    fetchAllStudents();
  }

  final dio = Dio();

  Future<void> fetchAllStudents() async {
    String token = await authcontroll.getToken();
    final url = 'http://192.168.16.104:8000/api/auth/all-students?page=$pageNo';
    print(url);
    final response = await dio.get(
      url,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );

    final json = response.data['data']['data'] as List;
    setState(() {
      students = students + json;
      hasMoreData = response.data['data']['next_page_url'] != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          IconButton(
              onPressed: () async {
                await authcontroll.logout();
                // ignore: use_build_context_synchronously
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginView()),
                    (route) => false);
              },
              icon: const Icon(Icons.logout_outlined)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: students.isNotEmpty ?
            ListView.builder(
              controller: scrollController,
              shrinkWrap: true,
              itemCount: isLoadingMore ? students.length + 1 : students.length,
              itemBuilder: (context, index) {
                if (index < students.length) {
                  return ListTile(
                    title: Text(students[index]['name'].toString()),
                  );
                } else {
                  return const Center(
                      child: CircularProgressIndicator());
                }
              },
            ): const Center(child: CircularProgressIndicator()),
          ),
          if (!hasMoreData)
            const Text("No more data available")
       
        ],
      ),
    );
  }

  Future<void> _scrollListener() async {
    if (isLoadingMore || !hasMoreData) return;
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      setState(() {
        isLoadingMore = true;
      });
      pageNo = pageNo + 1;
      await fetchAllStudents();
      setState(() {
        isLoadingMore = false;
      });
      print('we reach in last position. so call');
      
    }
  }
}
