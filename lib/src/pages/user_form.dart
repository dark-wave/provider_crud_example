import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlitecrudprovider/src/model/user.dart';
import 'package:sqlitecrudprovider/src/provider/user_provider.dart';

class UserFormPage extends StatefulWidget {
  const UserFormPage({Key? key}) : super(key: key);

  @override
  State<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _inputNameController = TextEditingController();
  final _inputLastNameController = TextEditingController();
  final _inputEmailController = TextEditingController();

  @override
  void dispose() {
    _inputNameController.dispose();
    _inputLastNameController.dispose();
    _inputEmailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Obtenemos el usuario si viene informado
    User? _objUser = ModalRoute.of(context)?.settings.arguments as User?;

    if(_objUser != null){
      _inputNameController.text = _objUser.nombre;
      _inputLastNameController.text = ((_objUser.apellidos != null) ? _objUser.apellidos : '')!;
      _inputEmailController.text = _objUser.email;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text((_objUser != null) ? 'Edit User' : 'New User'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _inputNameController,
                  decoration: const InputDecoration(
                    hintText: 'Introduce nombre',
                    labelText: 'Nombre'
                  ),
                  validator: (value){
                    if(value!.isEmpty){
                      return 'El nombre es obligatorio';
                    }
      
                    return null;
                  },
                ),
                TextFormField(
                  controller: _inputLastNameController,
                  decoration: const InputDecoration(
                    hintText: 'Introduce apellidos',
                    labelText: 'Apellidos'
                  ),
                ),
                TextFormField(
                  controller: _inputEmailController,
                  decoration: const InputDecoration(
                    hintText: 'Introduce email',
                    labelText: 'Email'
                  ),
                  validator: (value){
                    if(value!.isEmpty){
                      return 'El email es obligatorio';
                    }
      
                    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
                    if(!emailValid){
                      return 'El formato del email no es válido';
                    }
                    
                    return null;
                  },
                ),
                Expanded(child: Container()),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(40),
                  ),
                  onPressed: (){
                    if(_formKey.currentState!.validate()){
                      final userService = Provider.of<UserProvider>(context, listen: false);

                      if(_objUser != null){
                        _objUser.nombre = _inputNameController.text;
                        _objUser.apellidos = _inputLastNameController.text;
                        _objUser.email = _inputEmailController.text;

                        
                        userService.updateUser(_objUser);
                      }else{
                        userService.addUser(_inputNameController.text, _inputLastNameController.text, _inputEmailController.text);
                      }
      
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text(
                    (_objUser != null) ? 'Modificar' : 'Agregar',
                    style: const TextStyle(fontSize: 20.0),
                  )
                )
              ],
            )
          ),
        ),
      )
    );
  }
}