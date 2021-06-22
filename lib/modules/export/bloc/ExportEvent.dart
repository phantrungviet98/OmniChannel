abstract class ExportEvent {
  const ExportEvent();
}

class ExportEventPaging extends ExportEvent {
  const ExportEventPaging({this.page, this.perPage});
  final int page;
  final int perPage;
}

class ExportEventCancelExport extends ExportEvent {
  const ExportEventCancelExport(this.id);
  final String id;
}

class ExportEventCloneExport extends ExportEvent {
  const ExportEventCloneExport(this.id);
  final String id;
}