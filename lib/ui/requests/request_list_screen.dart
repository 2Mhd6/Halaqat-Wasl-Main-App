import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:halaqat_wasl_main_app/helpers/format_date_time.dart';
import 'package:halaqat_wasl_main_app/helpers/readable_address.dart';
import 'package:halaqat_wasl_main_app/repo/request/complaint_repo.dart';
import 'package:halaqat_wasl_main_app/repo/request/request_repo.dart';
import 'package:halaqat_wasl_main_app/theme/app_colors.dart';
import 'package:halaqat_wasl_main_app/theme/app_text_style.dart';
import 'package:halaqat_wasl_main_app/ui/requests/bloc/request_details_bloc.dart';
import 'package:halaqat_wasl_main_app/ui/requests/bloc/request_list_bloc.dart';
import 'package:halaqat_wasl_main_app/ui/requests/request_details_screen.dart';
import 'package:halaqat_wasl_main_app/ui/requests/widgets/request_info_card.dart';
import 'package:halaqat_wasl_main_app/shared/widgets/gap.dart';
// import 'package:halaqat_wasl_main_app/model/request_model/request_model.dart';
// import 'package:halaqat_wasl_main_app/model/complaint_model/complaint_model.dart';

class RequestListScreen extends StatelessWidget {
  const RequestListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RequestListBloc()..add(FetchRequests()),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'my_request_screen.my_request'.tr(),
              style: AppTextStyle.sfProBold20,
            ),
            centerTitle: false,
            bottom: TabBar(
              indicatorColor: AppColors.primaryButtonColor,
              labelColor: AppColors.primaryButtonColor,
              unselectedLabelColor: Colors.black,
              tabs: [
                Tab(text: 'my_request_screen.all'.tr()),
                Tab(text: 'my_request_screen.completed'.tr()),
                Tab(text: 'my_request_screen.cancelled'.tr()),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              _RequestsListView(filter: 'all'),
              _RequestsListView(filter: 'completed'),
              _RequestsListView(filter: 'cancelled'),
            ],
          ),
        ),
      ),
    );
  }
}

//Filter determine what will be displayed.
class _RequestsListView extends StatelessWidget {
  final String filter;

  const _RequestsListView({required this.filter});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestListBloc, RequestListState>(
      //Fetching requests from the subabase
      builder: (context, state) {
        //If the data has not arrived yet, a loading circle is displayed.
        if (state is RequestListLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is RequestListLoaded) {
          final requests = state
              .requests; //All requests received from Supabase are included.

          final filteredRequests =
              filter ==
                  'all' //Filters requests by the selected tab
              ? requests
              : requests
                    .where((r) => r.status.toLowerCase() == filter)
                    .toList();

          log('-------\n$filteredRequests');

          return ListView.separated(
            //Display list
            padding: const EdgeInsets.all(16),
            itemCount: filteredRequests.length,
            separatorBuilder: (_, __) => Gap.gapH16,
            itemBuilder: (context, index) {
              final request = filteredRequests[index];
              String? readableAddress;
              return InkWell(
                onTap: () async =>
                    readableAddress = await ReadableLocation.readableAddress(
                      request.pickupLat,
                      request.pickupLong,
                    ),
                child: InkWell(
                  onTap: () async {
                    final readableAddress =
                        await ReadableLocation.readableAddress(
                          request.pickupLat,
                          request.pickupLong,
                        );
                    //Fetches details of the selected order from Supabase, fetches order complaint (if present).
                    final requestDetails = await RequestRepo.getRequestById(
                      request.requestId,
                    );

                    final complaint =
                        await ComplaintRepo.getComplaintByRequestId(
                          request.requestId,
                        );
                    //If the request is modified, the previous screen returns with true and the page is updated.
                    if (requestDetails != null && context.mounted) {
                      final updated = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider(
                            create: (_) => RequestDetailsBloc()
                              ..add(
                                LoadRequestDetails(
                                  request: requestDetails,
                                  complaint: complaint,
                                ),
                              ),
                            child: RequestDetailsScreen(
                              request: requestDetails,
                              complaint: complaint,
                            ),
                          ),
                        ),
                      );

                      //refresh the list
                      if (updated == true && context.mounted) {
                        context.read<RequestListBloc>().add(FetchRequests());
                      }
                    }
                  },
                  //Data for each order is inside a special card.
                  child: RequestInfoCard(
                    requestId: request.requestId,
                    pickup: readableAddress ?? 'hf',
                    destination: request.hospital?.hospitalName ?? 'gt',
                    time: formattedRequest(request.requestDate),
                    status: request.status,
                  ),
                ),
              );
            },
          );
        }

        //Displays a "No requests found" message if there are no requests or an error occurred while fetching.
        return Center(child: Text('my_request_screen.noـrequestsـfound'.tr()));
      },
    );
  }
}
