part of 'printer_connection_status_cubit.dart';

@freezed
class PrinterConnectionStatusState with _$PrinterConnectionStatusState {
  const factory PrinterConnectionStatusState.initial({
    @Default(PrinterStatus.initial) PrinterStatus status,
    @Default('') String message,
  }) = Initial;
}
