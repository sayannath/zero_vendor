
import 'package:zero_vendor/view/CategorySelect.dart';
import 'package:zero_vendor/view/addItemPage.dart';

class Inventory extends StatefulWidget {
  @override
  _InventoryState createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  bool isLoading = false;
  List<Category> categories = [];
  @override
  void initState() {
    super.initState();
    getCategories();
  }

  getCategories() async {
    setState(() {
      isLoading = true;
    });
    categories = await CategoryService.getAllCategoriesRequest();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: UIConstants.fitToHeight(640, context),
          width: UIConstants.fitToWidth(360, context),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 10.0),
                  child: Text('Inventory',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold)),
                ),
                isLoading
                    ? CircularProgressIndicator()
                    : Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 5.0,
                              mainAxisSpacing: 5.0,
                            ),
                            shrinkWrap: true,
                            itemCount: categories.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  print("Clicked");
                                },
                                child: CategoryCard(
                                  category: categories[index],
                                ),
                              );
                            }),
                      )
              ]),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80.0),
        child: FloatingActionButton(
          child: Container(
            width: 60,
            height: 60,
            child: Icon(
              Icons.add,
              size: 40,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  colors: [Colors.blue[700], Colors.cyan],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomLeft),
            ),
          ),
          onPressed: () {

            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => AddItem(),
            //   ),
            // );

          },
        ),
      ),
    );
  }
}
