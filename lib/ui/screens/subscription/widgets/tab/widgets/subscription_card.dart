import 'package:flutter/material.dart';
import 'package:khmerbike/models/subscription_info.dart';
import 'package:khmerbike/ui/theme/app_theme.dart';

class SubscriptionCard extends StatelessWidget {
  final SubscriptionInfo pass;
  final VoidCallback onTap;

  const SubscriptionCard({required this.pass, required this.onTap});

  String _getPricePeriod(String id) {
    if (id.contains('annual') || id.contains('year')) return 'per year';
    if (id.contains('monthly') || id.contains('month')) return 'per month';
    return 'per day';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 110,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // ── Green background layer (full width) ──────────────────────
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.primaryGreen,
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 14),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'TAP',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                    SizedBox(height: 4),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),

            // ── White card stacked on top, leaves green strip on right ───
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              right: 52,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 6,
                      offset: const Offset(2, 0),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Title + description
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            pass.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF111111),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            pass.description,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF999999),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 14),

                    // Price + period
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '\$${pass.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF111111),
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          _getPricePeriod(pass.id),
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFFBBBBBB),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // ── Tag ribbon — drops from top of white card ─────────────────
            Positioned(
              top: 0,
              left: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: _tagBackground(pass.tag),
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(8),
                  ),
                ),
                child: Text(
                  pass.tag,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: _tagTextColor(pass.tag),
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _tagBackground(String tag) {
    switch (tag) {
      case 'Most Popular':
        return AppTheme.primaryGreen.withOpacity(0.85);
      case 'Subscribe & Save':
        return const Color(0xFFDCFCE7);
      case 'Best Value':
        return const Color(0xFFDCFCE7);
      default:
        return const Color(0xFFF0F0F0);
    }
  }

  Color _tagTextColor(String tag) {
    switch (tag) {
      case 'Most Popular':
        return Colors.white;
      default:
        return const Color(0xFF15803D);
    }
  }
}