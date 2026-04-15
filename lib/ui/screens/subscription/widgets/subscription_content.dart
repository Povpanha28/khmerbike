import 'package:flutter/material.dart';
import 'package:khmerbike/ui/screens/subscription/widgets/tab/subscription_info_tab.dart';
import 'package:khmerbike/ui/screens/subscription/widgets/tab/my_pass_tab.dart';
import 'package:khmerbike/ui/theme/app_theme.dart';

class SubscriptionContent extends StatelessWidget {
  const SubscriptionContent({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              pinned: true,
              floating: false,
              elevation: 4,
              scrolledUnderElevation: 4,
              forceElevated: true,
              shadowColor: Colors.black.withOpacity(0.3),
              toolbarHeight: 70,
              backgroundColor: AppTheme.background,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'My pass',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Manage your bike subscription',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(48),
                child: TabBar(
                  indicatorColor: AppTheme.primaryGreen,
                  indicatorWeight: 3,
                  labelColor: AppTheme.textPrimary,
                  unselectedLabelColor: AppTheme.textSecondary,
                  dividerColor: Colors.transparent,
                  tabs: const [
                    Tab(text: 'Plans'),
                    Tab(text: 'My pass'),
                  ],
                ),
              ),
            ),
          ],
          body: const TabBarView(
            children: [SubscriptionInfoTab(), MyPassTab()],
          ),
        ),
      ),
    );
  }
}
