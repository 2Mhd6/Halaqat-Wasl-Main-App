// import 'package:bloc/bloc.dart';
// import 'package:halaqat_wasl_main_app/model/request_model/request_model.dart';
// import 'package:halaqat_wasl_main_app/repo/request/request_repo.dart';
// import 'package:meta/meta.dart';

// part 'request_list_event.dart';
// part 'request_list_state.dart';

// class RequestListBloc extends Bloc<RequestListEvent, RequestListState> {
//   RequestListBloc() : super(RequestListInitial()) {
//     on<FetchRequests>(_onFetchRequests);
//   }

//   Future<void> _onFetchRequests(
//     FetchRequests event,
//     Emitter<RequestListState> emit,
//   ) async {
//     emit(RequestListLoading());
//     try {
//       final requests = await RequestRepo.getAllRequests();
//       emit(RequestListLoaded(requests));
//     } catch (e) {
//       emit(RequestListError('Failed to load requests'));
//     }
//   }
// }
