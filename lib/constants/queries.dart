class Queries {
  static const findAllUsers = 'SELECT * FROM usuarios';
  static const findOneUser = 'SELECT * FROM usuarios WHERE id = ?';
  static const insertUser = 'INSERT INTO usuarios (nome, email, password) VALUES (?, ?, ?)';
  static const deleteUser = 'DELETE from usuarios where id = ?';
  static const updateUser = 'UPDATE usuarios set nome = ?, password = ? where id = ?';
}
