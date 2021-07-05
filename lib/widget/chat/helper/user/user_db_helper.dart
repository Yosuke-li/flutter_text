part of 'user_db.dart';

String update(
    String table, Map<String, dynamic> values, String whereStr) {
  final StringBuffer update = StringBuffer();
  update.write('UPDATE ');
  update.write(_escapeName(table));
  update.write(' SET ');

  final int size = (values != null) ? values.length : 0;

  if (size > 0) {
    var i = 0;
    values.forEach((String colName, dynamic value) {
      if (i++ > 0) {
        update.write(', ');
      }

      /// This should be just a column name
      update
          .write('${_escapeName(colName)} = ${PostgreSQLFormat.id(colName)}');
    });
  }
  update.write(' ${whereStr}');

  var sql = update.toString();
  return sql;
}

String insert(String table, Map<String, dynamic> values) {
  final StringBuffer insert = StringBuffer();
  insert.write('INSERT');
  insert.write(' INTO ');
  insert.write(_escapeName(table));
  insert.write(' (');

  final int size = (values != null) ? values.length : 0;

  if (size > 0) {
    final StringBuffer sbValues = StringBuffer(') VALUES (');

    var i = 0;
    values.forEach((String colName, dynamic value) {
      if (i++ > 0) {
        insert.write(', ');
        sbValues.write(', ');
      }

      /// This should be just a column name
      insert.write(_escapeName(colName));
      sbValues.write(PostgreSQLFormat.id(colName));
    });
    insert.write(sbValues);
  }
  insert.write(')');

  var sql = insert.toString();
  return sql;
}

String _escapeName(String name) {
  if (name == null) {
    return name;
  }
  if (escapeNames.contains(name.toLowerCase())) {
    return _doEscape(name);
  }
  return name;
}

String _doEscape(String name) => '"$name"';

final Set<String> escapeNames = <String>{
  'add',
  'all',
  'alter',
  'and',
  'as',
  'autoincrement',
  'between',
  'case',
  'check',
  'collate',
  'commit',
  'constraint',
  'create',
  'default',
  'deferrable',
  'delete',
  'distinct',
  'drop',
  'else',
  'escape',
  'except',
  'exists',
  'foreign',
  'from',
  'group',
  'having',
  'if',
  'in',
  'index',
  'insert',
  'intersect',
  'into',
  'is',
  'isnull',
  'join',
  'limit',
  'not',
  'notnull',
  'null',
  'on',
  'or',
  'order',
  'primary',
  'references',
  'select',
  'set',
  'table',
  'then',
  'to',
  'transaction',
  'union',
  'unique',
  'update',
  'using',
  'values',
  'when',
  'where'
};