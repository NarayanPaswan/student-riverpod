import 'package:dio/dio.dart';
import 'package:student_riverpod/models/student_model.dart';
import '../../utils/exports.dart';
import '../auth/controller/auth_controller.dart';
import '../auth/login_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final authcontroll = AuthController();
  final scrollController = ScrollController();
  bool isLoadingMore = false;
  int pageNo = 1;
  List students = [];
  bool hasMoreData = true;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
    // fetchAllStudents();
  }

  final dio = Dio();

  Future<StudentModel> fetchAllStudents() async {
     
    String token = await authcontroll.getToken();
    final url = 'http://192.168.16.104:8000/api/auth/all-students?page=$pageNo';
    // print(url);
    final response = await dio.get(
      url,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );

   return StudentModel.fromJson(response.data);
    
   
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
            child: FutureBuilder(
                  future: fetchAllStudents(),
                  builder: (context, AsyncSnapshot<StudentModel> snapshot){
            if(!snapshot.hasData){
              return const Center(
                    child: CircularProgressIndicator(),
                  );
            }else if (snapshot.hasError){
              return Center(
                    child: Text(snapshot.error.toString()),
                  );
            }else{
               if (snapshot.data!.data!.data!.isEmpty) {
                  return const Center(
                    child: Text("Data not available !"),
                  );
                }
            return  ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.data!.data!.length,
                itemBuilder: (context, index) {
                   StudentData student = snapshot.data!.data!.data![index];
                    return ListTile(
                      title: Text(student.name ?? ''),
                    );
                  
                },
              );
                  }
                }),
          ),

        
       
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
      // print('we reach in last position. so call');
      
    }
  }
}
