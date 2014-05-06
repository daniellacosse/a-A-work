require_relative '03_searchable'
require 'active_support/inflector'

require 'debugger'

# Phase IVa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key,
  )

  def model_class
    Object.const_get(self.class_name)
  end

  def table_name
    self.model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})

    defaults = {
      class_name: name.to_s.singularize.camelcase,
      foreign_key: "#{name.to_s.downcase}_id".to_sym,
      primary_key: :id
    }

    defaults.merge(options).each { |k, v| self.send("#{k}=", v) }

  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})

    f_key = "#{self_class_name.to_s.downcase}_id".to_sym

    defaults = {
      class_name: name.to_s.singularize.camelcase,
      foreign_key: f_key,
      primary_key: :id
    }

    defaults.merge(options).each { |k, v| self.send("#{k}=", v) }

  end
end

module Associatable

  def assoc_options
    @assoc_options ||= {}
  end

  def belongs_to(name, options = {})
    assoc_options

    options = BelongsToOptions.new(name, options)

    @assoc_options[name] = options

    define_method("#{options.class_name.downcase}") do

      sql_query = <<-SQL
        SELECT #{options.table_name}.*
        FROM #{self.class.table_name}
        JOIN #{options.table_name}
        ON #{options.table_name}.id = #{self.class.table_name}.#{options.foreign_key}
        WHERE #{options.table_name}.id = #{self.send(options.foreign_key)}
      SQL

      options.model_class.parse_all(DBConnection.execute(sql_query)).first
    end
  end

  def has_many(name, options = {})
    assoc_options

    options = HasManyOptions.new(name, self, options)

    @assoc_options[name] = options

    define_method("#{name.downcase}") do

      sql_query = <<-SQL
        SELECT #{options.table_name}.*
        FROM #{self.class.table_name}
        JOIN #{options.table_name}
        ON #{self.class.table_name}.id = #{options.table_name}.#{options.foreign_key}
        WHERE #{self.id} = #{options.table_name}.#{options.foreign_key}
      SQL

      options.model_class.parse_all(DBConnection.execute(sql_query))
    end
  end
end

class SQLObject
  extend Associatable
end
