require_relative 'db_connection'
require_relative '02_sql_object'

module Searchable
  def where(params)
    set_line = params.keys.map { |name| "#{name} = ?"}.join(" AND ")
    where_sql = <<-SQL
    SELECT *
    FROM #{table_name}
    WHERE #{set_line}
    SQL

    parse_all DBConnection.execute(where_sql, params.values)
  end
end

class SQLObject
  extend Searchable
end
