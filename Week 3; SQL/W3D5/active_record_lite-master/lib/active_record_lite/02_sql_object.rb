require_relative 'db_connection'
require_relative '01_mass_object'
require 'active_support/inflector'

class MassObject
  def self.parse_all(results)
    results.map do |row|
      p "row is #{row}"
      p "self is #{self}"
      self.new(row)
    end
  end
end

class SQLObject < MassObject
  def self.columns
    sql = <<-SQL
      SELECT *
      FROM #{table_name}
    SQL

    column_names = DBConnection.execute2(sql).first
    column_names.map!(&:to_sym)
    self.my_attr_accessor(*column_names)

    column_names
  end

  def self.table_name=(table_name)
    @table_name = table_name
    @table_name = self.to_s.underscore.pluralize if @table_name.nil?
  end

  def self.table_name
    @table_name ||= self.to_s.underscore.pluralize
  end

  def self.all
    sql = <<-SQL
      SELECT *
      FROM #{self.table_name}
    SQL

    parse_all DBConnection.execute(sql)
  end

  def self.find(id)
    sql = <<-SQL
      SELECT *
      FROM #{self.table_name}
      WHERE
        id = ?
    SQL

    a = parse_all(DBConnection.execute(sql, id)).first
    p a.name
    a
  end

  def insert
    q_marks = Array.new(attributes.length) { "?" }.join(", ")
    col_names = attributes.keys.join(", ")

    ins_sql = <<-SQL
      INSERT INTO #{Cat.table_name} (#{col_names})
      VALUES
        (#{q_marks})
    SQL

    DBConnection.execute(ins_sql, *attribute_values)

    attributes[:id] = DBConnection.last_insert_row_id
  end

  def save
    attributes[:id].nil? ? insert : update
  end

  def update
    set_line = self.attributes.map { |name| "#{name} = ?"}.join(", ")

    update_sql = <<-SQL
      UPDATE #{Cat.table_name}
      SET #{set_line}
      WHERE id = ?
    SQL

    DBconnection.execute(update_sql, self.attributes[:id])
  end

  def attribute_values
    attributes.values
  end
end
