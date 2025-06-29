import 'package:flutter/material.dart';
import 'package:halaqat_wasl_main_app/theme/app_text_style.dart';
import 'package:halaqat_wasl_main_app/theme/app_color.dart';
import 'package:halaqat_wasl_main_app/ui/requests/widgets/request_info_card.dart';
import 'package:halaqat_wasl_main_app/shared/widgets/gap.dart';

class RequestListScreen extends StatelessWidget {
  const RequestListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            //Space before title
            Gap.gapH16,

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text('Requests', style: AppTextStyle.sfProBold20),
            ),
            Gap.gapH16,

      
            //Class containing tab bar details
            const _RequestTabBar(),
            Gap.gapH16,
            //Class containig ListView
            const Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: _RequestsListView(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//TabBar 
class _RequestTabBar extends StatelessWidget {
  const _RequestTabBar();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController( //To manage the switching between tabs
      length: 3,
      child: TabBar(
        indicatorColor: AppColor.primaryButtonColor,
        labelColor: AppColor.primaryButtonColor,
        unselectedLabelColor: Colors.black,
        tabs: const [
          Tab(text: 'All'),
          Tab(text: 'Completed'),
          Tab(text: 'Cancelled'),
        ],
      ),
    );
  }
}
// Built using widgets RequestInfoCard
class _RequestsListView extends StatelessWidget {
  const _RequestsListView();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 3,
      separatorBuilder: (_, __) => Gap.gapH16,
      itemBuilder: (context, index) {
        return RequestInfoCard(
          requestId: '#Req-00${index + 1}', //Display an incremental order number for each item in the list
          pickup: 'King Abdulaziz Road',
          destination: 'Alnahdi Pharmacy, Riyadh',
          time: '12:59pm 29-06-2025',
          status: index == 0
              ? 'Pending'
              : index == 1
              ? 'Accepted'
              : 'Completed',
        );
      },
    );
  }
}
