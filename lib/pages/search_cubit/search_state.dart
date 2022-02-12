part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchSuccess extends SearchState {
  final Search search;

  SearchSuccess(this.search);
}

class SearchError extends SearchState {
  final String error;

  SearchError(this.error);
}
