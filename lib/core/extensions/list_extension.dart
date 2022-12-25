extension Unique<E, Id> on List<E> {
  List<E> unique([Id Function(E element)? id]) {
    final ids = <dynamic>{};
    final list = List<E>.from(this)
      ..retainWhere((x) => ids.add(id != null ? id(x) : x as Id));
    return list;
  }
}
