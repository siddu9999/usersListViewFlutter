import 'package:demo_labs_project/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';

class UserListView extends StatefulWidget {
  @override
  _UserListViewState createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is UserLoaded) {
          return ListView.builder(
            itemCount: state.users.length,
            itemBuilder: (context, index) {
              final user = state.users[index];
              final animation = Tween<double>(begin: 0, end: 1).animate(
                CurvedAnimation(
                  parent: _controller,
                  curve: Interval(
                    (1 / state.users.length) * index,
                    1.0,
                    curve: Curves.fastOutSlowIn,
                  ),
                ),
              );

              return AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: Transform.translate(
                      offset: Offset(0, 50 * (1 - animation.value)),
                      child: ListTile(
                        leading: Image.network(user.photo),
                        title: Text(user.name),
                        subtitle: Text(user.email),
                      ),
                    ),
                  );
                },
              );
            },
          );
        } else if (state is UserError) {
          return Center(child: Text('An error occurred: ${state.message}'));
        } else {
          return Center(child: Text('No users found'));
        }
      },
    );
  }
}