import 'package:bloc/bloc.dart';
import 'package:omnichannel_flutter/constant/Status.dart';
import 'package:omnichannel_flutter/data/modals/Export.dart';
import 'package:omnichannel_flutter/data/repository/remote_repository.dart';
import 'package:omnichannel_flutter/modules/import/bloc/ImportEvent.dart';
import 'package:omnichannel_flutter/modules/import/bloc/ImportState.dart';

class ImportBloc extends Bloc<ImportEvent, ImportState> {
  ImportBloc() : super(ImportState(status: Status.initial, imports: ExportsPaging.empty));

  @override
  Stream<ImportState> mapEventToState(ImportEvent event) async* {
    if (event is ImportEventPaging) {
      yield state.copyWith(status: Status.loading);
      try {
        final result = await RemoteRepository.getImportsPaging(event.page, event.perPage);
        yield state.copyWith(status: Status.success, import: result);
      } catch (e) {
        yield state.copyWith(status: Status.fail);
      }
    }
    if (event is ImportEventCancelImport) {
      try {
        final result = await RemoteRepository.cancelImport(event.id);
        this.add(ImportEventPaging());
      } catch (e) {

      }
    }
    if (event is ImportEventCloneImport) {
      try {
        final result = await RemoteRepository.cloneImport(event.id);
        this.add(ImportEventPaging());
      } catch (e) {
        
      }
    }
  }
}