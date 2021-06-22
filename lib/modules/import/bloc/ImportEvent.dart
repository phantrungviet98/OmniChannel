abstract class ImportEvent {
  const ImportEvent();
}

class ImportEventPaging extends ImportEvent {
  const ImportEventPaging({this.page, this.perPage});
  final int page;
  final int perPage;
}

class ImportEventCancelImport extends ImportEvent {
  const ImportEventCancelImport(this.id);
  final String id;
}

class ImportEventCloneImport extends ImportEvent {
  const ImportEventCloneImport(this.id);
  final String id;
}