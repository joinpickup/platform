import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'home_drawer_bloc_event.dart';
part 'home_drawer_bloc_state.dart';

class HomeDrawerBlocBloc
    extends Bloc<HomeDrawerBlocEvent, HomeDrawerBlocState> {
  HomeDrawerBlocBloc() : super(const HomeDrawerBlocInitial()) {
    on<HomeDrawerBlocEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<ChangeFeed>((ChangeFeed event, emit) {
      emit(HomeDrawerBlocFeedChange(
        drawerFeed: event.drawerFeed,
      ));
    });
  }
}
