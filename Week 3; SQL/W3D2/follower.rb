class Follower
  def self.all
    results = QuestionsDatabase.instance.execute("SELECT * FROM question_followers")
    results.map { |follower| Follower.new(follower) }
  end

  def self.find_by_id(id)
    results = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_followers
      WHERE
        id = ?
    SQL
      Follower.new(results.pop)
  end

  def self.followers_for_question_id(q_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, q_id)
      SELECT
        u.*
      FROM
        questions AS q
      JOIN
        question_followers AS qf
      ON
        q.id = qf.q_id
      JOIN
        users AS u
      ON
        qf.user_id = u.id
      WHERE
        qf.q_id = ?
    SQL
    results.map { |user| User.new(user) }
  end

  def self.followed_questions_for_user_id(user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        q.*
      FROM
        questions AS q
      JOIN
        question_followers AS qf
      ON
        q.id = qf.q_id
      JOIN
        users AS u
      ON
        qf.user_id = u.id
      WHERE
        qf.user_id = ?
    SQL
    results.map { |q| Question.new(q) }
  end

  def self.most_followed_questions(n)
    results = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        q.*
      FROM
        questions AS q
      JOIN
        question_followers AS qf
      ON
        q.id = qf.q_id
      GROUP BY
        qf.q_id
      ORDER BY
        COUNT(qf.q_id) DESC
      SQL

      results.take(n).map { |q| Question.new(q) }
  end

  attr_accessor :id, :user_id, :q_id

  def initialize(options = {})
    @id, @user_id = options["id"], options["user_id"]
    @q_id = options["q_id"]
  end
end