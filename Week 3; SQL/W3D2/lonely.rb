class Lonely
  def self.find_by_id(id)
    results = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        questions
      WHERE
        id = ?
    SQL
      self.class.new(results.pop)
  end


  def columns
    columns = self.instance_variables.map { |var| var.to_s[1..-1] }
    columns.delete("id")
    columns.delete("table")

    columns
  end

  def save
    args = []
    self.instance_variables[0..-2].map { |var| var.to_s[1..-1] }.map(&:to_sym).each do |i_var|

      args << send(i_var)
    end

    if self.id.nil?
      q_marks = Array.new(columns.length) { "?" }.join(", ")
      h_doc = <<-SQL
        INSERT INTO
         #{table}(#{columns.join(", ")})
        VALUES
          (#{q_marks})
        SQL
      QuestionsDatabase.instance.execute(h_doc, *args)

      self.id = QuestionsDatabase.instance.last_insert_row_id
    else
      h_doc = <<-SQL
        UPDATE
         #{table}
        SET
          #{columns.map { |col| "#{col} = ?"}.join(", ")}
        WHERE
          id = ?
        SQL

      QuestionsDatabase.instance.execute(h_doc, *args)
    end
  end
end