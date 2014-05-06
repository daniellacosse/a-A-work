class Like
  def self.all
    results = QuestionsDatabase.instance.execute("SELECT * FROM question_likes")
    results.map { |like| Like.new(like) }
  end

  def self.find_by_id(id)
    results = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_likes
      WHERE
        id = ?
    SQL
      Like.new(results.pop)
  end

  def self.likers_for_question_id(q_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, q_id)
    SELECT
      u.*
    FROM
      questions AS q
    JOIN
      question_likes AS ql
    ON
      q.id = ql.q_id
    JOIN
      users AS u
    ON
      ql.user_id = u.id
    WHERE
      ql.q_id = ?
    SQL

    results.map { |user| User.new(user) }
  end

  def self.num_likes_for_question_id(q_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, q_id)
    SELECT
      COUNT(ql.q_id)
    FROM
      questions AS q
    JOIN
      question_likes AS ql
    ON
      q.id = ql.q_id
    JOIN
      users AS u
    ON
      ql.user_id = u.id
    WHERE
      ql.q_id = ?
    SQL

    results.pop.values.first
  end

  def self.liked_questions_for_user_id(user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, user_id)
    SELECT
      q.*
    FROM
      questions AS q
    JOIN
      question_likes AS ql
    ON
      q.id = ql.q_id
    JOIN
      users AS u
    ON
      ql.user_id = u.id
    WHERE
      ql.user_id = ?
    SQL

    results.map { |q| Question.new(q) }
  end

  def self.most_liked_questions(n)
    results = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        q.*
      FROM
        questions AS q
      JOIN
        question_likers AS ql
      ON
        q.id = qf.q_id
      GROUP BY
        ql.q_id
      ORDER BY
        COUNT(ql.q_id) DESC
      SQL

      results.take(n).map { |q| Question.new(q) }
  end

  attr_accessor :id, :user_id, :q_id

  def initialize(options = {})
    @id, @user_id = options["id"], options["user_id"]
    @q_id = options["q_id"]
  end
end