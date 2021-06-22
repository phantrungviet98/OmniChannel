import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:omnichannel_flutter/constant/Status.dart';
import 'package:omnichannel_flutter/data/modals/Export.dart';
import 'package:omnichannel_flutter/data/repository/remote_repository.dart';
import 'package:omnichannel_flutter/modules/export/bloc/ExportEvent.dart';
import 'package:omnichannel_flutter/modules/export/bloc/ExportState.dart';

class ExportBloc extends Bloc<ExportEvent, ExportState> {
  ExportBloc() : super(ExportState(status: Status.initial, exports: ExportsPaging.empty));

  @override
  Stream<ExportState> mapEventToState(ExportEvent event) async* {
    log(event.toString());

    if (event is ExportEventPaging) {
      yield state.copyWith(status: Status.loading);
      try {
        final result = await RemoteRepository.getExportsPaging(event.page, event.perPage);
        yield state.copyWith(status: Status.success, exports: result);
      } catch (e) {
        yield state.copyWith(status: Status.fail);
      }
    }
    if (event is ExportEventCancelExport) {
      try {
        final result = await RemoteRepository.cancelExport(event.id);
        this.add(ExportEventPaging());
      } catch (e) {

      }
    }
    if (event is ExportEventCloneExport) {
      try {
        final result = await RemoteRepository.cloneExport(event.id);
        this.add(ExportEventPaging());
      } catch (e) {

      }
    }
  }
}