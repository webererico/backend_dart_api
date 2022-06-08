class Queries {
  static const findAllUsers = 'SELECT * FROM usuarios';
  static const findOneUser = 'SELECT * FROM usuarios WHERE id = ?';
  static const insertUser = 'INSERT INTO usuarios (nome, email, password) VALUES (?, ?, ?)';
  static const deleteUser = 'DELETE from usuarios where id = ?';
  static const updateUser = 'UPDATE usuarios set nome = ?, password = ? where id = ?';
  static const findUserByEmail = 'SELECT * from usuarios WHERE email = ?';
  static const insertNews = 'INSERT into noticias (titulo, descricao, id_usuario) values (?, ?, ?)';
  static const deleteNews = 'DELETE from noticias WHERE id = ?';
  static const findOneNews = 'SELECT * FROM noticias WHERE id = ?';
  static const updateNews = 'UPDATE noticias set titulo = ?, descricao = ? WHERE id = ? and id_usuario = ?';
  static const findAllNews = 'SELECT * FROM noticias';
}
