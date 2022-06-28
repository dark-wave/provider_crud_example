import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlitecrudprovider/src/provider/user_provider.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {

  @override
  void initState() {
    super.initState();

    Provider.of<UserProvider>(context, listen: false).listUsers();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Usuarios'),
      ),
      body: Consumer<UserProvider>(
        builder: (context, data, child){
          var userList = data.userList;

          if(userList.isNotEmpty){
            return ListView.builder(
              itemCount: userList.length,
              itemBuilder: (context, index) {
                var user = userList[index];
                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction){
                    Provider.of<UserProvider>(context, listen: false).deleteUser(user.id!);
                  },
                  child: ListTile(
                    title: Text(user.nombre),
                    leading: const Icon(Icons.person),
                  ),
                );
              },
            );
          }else{
            return const Center(child: Text('No hay usuarios registrados!'));
          }
        } ,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, 'userForm'),
      ),
    );
  }
}