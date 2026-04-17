import 'package:khmerbike/models/bike_booking.dart';

enum BookingAction {
  none,
  showNoPassOptions,
  buyOneTimeTicket,
  viewSubscriptionInfo,
  unlockBike,
}

class BookingState {
  final BikeBooking? activeBooking;
  final bool hasOneTimeTicket;
  final BookingAction action;

  const BookingState({
    this.activeBooking,
    this.hasOneTimeTicket = false,
    this.action = BookingAction.none,
  });

  BookingState bookBike(BikeBooking booking) {
    return copyWith(activeBooking: booking, action: BookingAction.unlockBike);
  }

  BookingState endBike() {
    return const BookingState();
  }

  /// User tries to unlock without a pass.
  /// UI should show options: buy one-time ticket or view subscription plans.
  BookingState handleUserWithoutPass() {
    return copyWith(action: BookingAction.showNoPassOptions);
  }

  /// User chooses to buy a one-time ticket.
  BookingState buyOneTimeTicket() {
    return copyWith(
      hasOneTimeTicket: true,
      action: BookingAction.buyOneTimeTicket,
    );
  }

  /// User chooses to view subscription plans/info.
  BookingState goToSubscriptionInfo() {
    return copyWith(action: BookingAction.viewSubscriptionInfo);
  }

  /// Clear one-time action after UI handles it.
  BookingState clearAction() {
    return copyWith(action: BookingAction.none);
  }

  BookingState copyWith({
    BikeBooking? activeBooking,
    bool? hasOneTimeTicket,
    BookingAction? action,
  }) {
    return BookingState(
      activeBooking: activeBooking ?? this.activeBooking,
      hasOneTimeTicket: hasOneTimeTicket ?? this.hasOneTimeTicket,
      action: action ?? this.action,
    );
  }
}
