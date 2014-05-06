require_relative 'db_connection'
require_relative '00_attr_accessor_object'
require 'active_support/inflector'

class MassObject < AttrAccessorObject
  def self.parse_all(results)
    results.map do |row|
      self.new(row)
    end
  end
end

class SQLObject < MassObject

  def self.table_name=(table_name)
    @table_name = table_name
    @table_name = self.to_s.underscore.pluralize if @table_name.nil?
  end

  def self.table_name
    @table_name ||= self.to_s.underscore.pluralize
  end

  def self.columns
    sql = <<-SQL
      SELECT *
      FROM #{table_name}
    SQL

    column_names = DBConnection.execute2(sql).first
    column_names.map!(&:to_sym)
  end

  def self.all
    sql = <<-SQL
      SELECT *
      FROM #{table_name}
    SQL

    parse_all DBConnection.execute(sql)
  end

  def self.find(id)
    sql = <<-SQL
      SELECT *
      FROM #{table_name}
      WHERE
        id = ?
    SQL

    parse_all(DBConnection.execute(sql, id)).first
  end

  def initialize(params = {})
    _columns = self.class.columns
    self.class.my_attr_accessor(*_columns)

    @attributes = params.dup

    @attributes.each do |attr_name, value|
      attr_sym = attr_name.to_sym
      raise "unknown attribute #{attr_name}" unless _columns.include?(attr_sym)
      self.send("#{attr_name}=", value)
    end
  end

  def attributes
    @attributes ||= {}
  end

  def insert
    q_marks = Array.new(attributes.length) { "?" }.join(", ")
    col_names = attributes.keys.join(", ")

    ins_sql = <<-SQL
      INSERT INTO #{self.class.table_name} (#{col_names})
      VALUES
        (#{q_marks})
    SQL

    DBConnection.execute(ins_sql, *attribute_values)

    self.id = DBConnection.last_insert_row_id
  end

  def save
    self.id.nil? ? insert : update
  end

  def update
    set_line = attributes.keys.map { |name| "#{name} = ?"}.join(", ")

    update_sql = <<-SQL
      UPDATE #{self.class.table_name}
      SET #{set_line}
      WHERE
        id = ?
    SQL
    print update_sql

    print "Values to update #{attribute_values}"

    result = DBConnection.execute(update_sql, attribute_values, self.id)

    print result
  end

  def attribute_values
    attribute_values = []

    self.class.columns.each do |attr|
      attribute_values << self.send(attr)
      puts "self.send(attr) = #{self.send(attr)}"
    end

    puts "attribute values = #{attribute_values.compact}"
    attribute_values.compact
  end
end
