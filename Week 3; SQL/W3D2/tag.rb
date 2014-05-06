class Tag
  def self.all
    results = QuestionsDatabase.instance.execute("SELECT * FROM tags")
    results.map { |tag| Tag.new(tag) }
  end


  def self.most_popular(n)
    results = QuestionsDatabase.instance.execute(<<-SQL)
    SELECT
      t.*
    FROM
      tags as t
    JOIN
      question_tags as qt
    ON
      t.id = qt.t_id
    JOIN
      question_likes as ql
    ON
      qt.q_id = ql.q_id
    GROUP BY
      t.id
    ORDER BY
      COUNT(t.id) DESC
    SQL


    results.take(n).map { |tag| Tag.new(tag) }
  end


  attr_reader :tag, :id

  def initialize(options = {})
    @tag = options["tag"]
    @id = options["id"]
  end

  def most_popular_questions(n)
    results = QuestionsDatabase.instance.execute(<<-SQL, self.id)
    SELECT
      q.*
    FROM
      tags AS t
    JOIN question_tags AS qt
    ON t.id = qt.t_id
    JOIN question_likes AS ql
    ON qt.q_id = ql.q_id
    JOIN questions AS q
    ON ql.q_id = q.id
    WHERE t.id = ?
    GROUP BY q.id
    ORDER BY COUNT(q.id) DESC

    SQL

    results.take(n).map { |q| Question.new(q) }
  end
end