abstract class BaseService<T> {
  findOnne(int id);
  List<T> findAll();
  bool save(T value);
  bool delete(int id);
}
