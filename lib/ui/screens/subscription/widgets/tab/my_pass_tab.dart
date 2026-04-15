import 'package:flutter/material.dart';
import 'package:khmerbike/models/subscription_info.dart';
import 'package:khmerbike/ui/screens/subscription/view_model/subscription_view_model.dart';
import 'package:khmerbike/ui/theme/app_theme.dart';
import 'package:khmerbike/ui/widget/app_buttons.dart';
import 'package:khmerbike/ui/screens/subscription/widgets/tab/widgets/cancel_subscription_modal.dart';
import 'package:provider/provider.dart';

class MyPassTab extends StatelessWidget {
  const MyPassTab();

  @override
  Widget build(BuildContext context) {
    return Consumer<SubscriptionViewModel>(
      builder: (context, viewModel, _) {
        if (viewModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final activePass = viewModel.activePass;

        if (activePass == null) {
          return const Center(
            child: Text(
              'No active pass',
              style: TextStyle(color: Colors.grey, fontSize: 18),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
          child: Column(
            children: [
              _TicketCard(pass: activePass),
              const SizedBox(height: 24),

              // Unlock button
              PrimaryButton(
                label: 'Unlock a bike',
                onPressed: () {
                  // TODO: handle unlock
                },
              ),
              const SizedBox(height: 12),

              // Cancel button
              SecondaryButton(
                label: 'Cancel subscription',
                fontSize: 16,
                padding: const EdgeInsets.symmetric(vertical: 16),
                onPressed: () => CancelSubscriptionModal.show(
                  context,
                  viewModel,
                  activePass,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Ticket card widget
// ---------------------------------------------------------------------------

class _TicketCard extends StatelessWidget {
  final SubscriptionInfo pass;

  const _TicketCard({required this.pass});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Main card
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppTheme.borderColor),
            borderRadius: BorderRadius.circular(20),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Column(
              children: [
                // ── Green top half ───────────────────────────────────────────────
                Container(
                  width: double.infinity,
                  color: AppTheme.primaryGreen,
                  padding: const EdgeInsets.fromLTRB(22, 22, 22, 28),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Active badge
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.22),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Text(
                                'Active pass',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              pass.name,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              pass.description,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withOpacity(0.7),
                                height: 1.5,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Bike icon box
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.18),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.directions_bike_rounded,
                          size: 26,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
            
                // ── Tear edge ───────────────────────────────────────────────────
                SizedBox(
                  height: 20,
                  child: CustomPaint(
                    painter: _TearEdgePainter(color: AppTheme.primaryGreen),
                    size: const Size(double.infinity, 20),
                  ),
                ),
            
                // ── White bottom stub ───────────────────────────────────────────
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(color: AppTheme.borderColor, width: 1),
                      left: BorderSide(color: AppTheme.borderColor, width: 1),
                      right: BorderSide(color: AppTheme.borderColor, width: 1),
                    ),
                  ),
                  padding: const EdgeInsets.fromLTRB(22, 16, 22, 20),
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        _StubStat(
                          label: 'Price',
                          value: '\$${pass.price.toStringAsFixed(2)}',
                        ),
                        _StubDivider(),
                        _StubStat(label: 'Valid for', value: pass.validityLabel),
                        _StubDivider(),
                        _StubStat(label: 'Until', value: pass.validUntilLabel),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Right circle - left half only (first)
        Positioned(
          left: 0,
          top: 155,
          child: ClipRect(
            child: Align(
              alignment: Alignment.centerRight,
              widthFactor: 0.5,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppTheme.borderColor, width: 1.5),
                ),
              ),
            ),
          ),
        ),

        // Left circle - right half only (second)
        Positioned(
          right: 0,
          top: 155,
          child: ClipRect(
            child: Align(
              alignment: Alignment.centerLeft,
              widthFactor: 0.5,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppTheme.borderColor, width: 1.5),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ── Tear edge painter ────────────────────────────────────────────────────────

class _TearEdgePainter extends CustomPainter {
  final Color color;

  _TearEdgePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()..color = Colors.white;
    final greenPaint = Paint()..color = color;

    // White background for the whole tear strip
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    // Green fill for the top half
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height / 2),
      greenPaint,
    );

    // Dashed line across the middle
    final dashPaint = Paint()
      ..color = Colors.grey.withOpacity(0.25)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    const dashWidth = 6.0;
    const dashGap = 5.0;
    double x = 12;
    final y = size.height / 2;
    while (x < size.width - 12) {
      canvas.drawLine(Offset(x, y), Offset(x + dashWidth, y), dashPaint);
      x += dashWidth + dashGap;
    }
  }

  @override
  bool shouldRepaint(_TearEdgePainter old) => old.color != color;
}

// ── Stub stat item ────────────────────────────────────────────────────────────

class _StubStat extends StatelessWidget {
  final String label;
  final String value;

  const _StubStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF111111),
            ),
          ),
          const SizedBox(height: 3),
          Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
        ],
      ),
    );
  }
}

class _StubDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.5,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      color: Colors.grey.withOpacity(0.25),
    );
  }
}
