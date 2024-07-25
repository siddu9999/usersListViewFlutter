import 'package:demo_labs_project/user_list_view.dart';
import 'package:demo_labs_project/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';
import 'events.dart';

class UserListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: BlocProvider(
        create: (context) => UserBloc(UserRepository())..add(FetchUsers()),
        child: UserListView(),
      ),
    );
  }
}