require_relative '04_associatable'

# Phase V
module Associatable

  def has_one_through(name, through_name, source_name)
    define_method("#{name}") do
      through_options = self.class.assoc_options[through_name]
      source_options = through_options.model_class.assoc_options[source_name]

      the_sql = <<-SQL
        SELECT #{source_options.table_name}.*
        FROM #{through_options.table_name}
        JOIN #{source_options.table_name}
        ON #{source_options.table_name}.id = #{through_options.table_name}.#{source_options.foreign_key}
        WHERE #{through_options.table_name}.id = ?
      SQL
      puts"source class: #{source_options.model_class}"

      source_options.model_class.parse_all(DBConnection.execute(the_sql, self.owner_id)).first
    end
  end


end
