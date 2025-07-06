import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halaqat_wasl_main_app/repo/request/complaint_repo.dart';
import 'package:halaqat_wasl_main_app/repo/request/request_repo.dart';
import 'package:halaqat_wasl_main_app/theme/app_colors.dart';
import 'package:halaqat_wasl_main_app/theme/app_text_style.dart';
import 'package:halaqat_wasl_main_app/ui/requests/bloc/request_details_bloc.dart';
import 'package:halaqat_wasl_main_app/ui/requests/request_details_screen.dart';
import 'package:halaqat_wasl_main_app/ui/requests/widgets/request_info_card.dart';
import 'package:halaqat_wasl_main_app/shared/widgets/gap.dart';
import 'package:halaqat_wasl_main_app/model/request_model/request_model.dart';
import 'package:halaqat_wasl_main_app/model/complaint_model/complaint_model.dart';

class RequestListScreen extends StatelessWidget {
  const RequestListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Requests', style: AppTextStyle.sfProBold20),
          centerTitle: false,
          bottom: const TabBar(
            indicatorColor: AppColors.primaryButtonColor,
            labelColor: AppColors.primaryButtonColor,
            unselectedLabelColor: Colors.black,
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'Completed'),
              Tab(text: 'Cancelled'),
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
    );
  }
}

//Filter determine what will be displayed.
class _RequestsListView extends StatelessWidget {
  final String filter;

  const _RequestsListView({required this.filter});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<RequestModel>>(
      //Fetching requests from the subabase
      future: RequestRepo.getAllRequests(),
      builder: (context, snapshot) {
        //If the data has not arrived yet, a loading circle is displayed.
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          //Displays a "No requests found" message if there are no requests or an error occurred while fetching.
          return const Center(child: Text('No requests found.'));
        }

        final requests =
            snapshot.data!; //All requests received from Supabase are included.
        final filteredRequests =
            filter ==
                'all' //Filters requests by the selected tab
            ? requests
            : requests.where((r) => r.status.toLowerCase() == filter).toList();

        return ListView.separated(
          //Display list
          padding: const EdgeInsets.all(16),
          itemCount: filteredRequests.length,
          separatorBuilder: (_, __) => Gap.gapH16,
          itemBuilder: (context, index) {
            final request = filteredRequests[index];

            return InkWell(
              onTap: () async {
                //Fetches details of the selected order from Supabase, fetches order complaint (if present).
                final requestDetails = await RequestRepo.getRequestById(
                  request.requestId,
                );

                final complaint = await ComplaintRepo.getComplaintByRequestId(
                  request.requestId,
                );

                if (requestDetails != null && context.mounted) {
                  Navigator.push(
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
                }
              },
              //Data for each order is inside a special card.
              child: RequestInfoCard(
                requestId: request.requestId,
                pickup: 'King Abdulaziz Road',
                destination: 'Alnahdi Pharmacy, Riyadh',
                time:
                    '${request.requestDate.hour}:${request.requestDate.minute.toString().padLeft(2, '0')}pm ${request.requestDate.day}-${request.requestDate.month}-${request.requestDate.year}',
                status: request.status,
              ),
            );
          },
        );
      },
    );
  }
}
