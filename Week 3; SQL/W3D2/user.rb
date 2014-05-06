class User < Lonely
  # table class variable to call Database#execute
  # in 'self.all' use self.new
  # make class method to return corrected instance variables


  def self.all
    results = QuestionsDatabase.instance.execute("SELECT * FROM users")
    results.map { |user| User.new(user) }
  end

  def self.find_by_id(id)
    results = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?
    SQL
      User.new(results.pop)
  end

  def self.find_by_name(fname, lname)
    name = [fname, lname]
    results = QuestionsDatabase.instance.execute(<<-SQL, *name)
      SELECT
        *
      FROM
        users
      WHERE
        fname = ? AND lname = ?
    SQL
    p results
      User.new(results.pop)
  end

  attr_accessor :fname, :lname, :id
  attr_reader :table

  def initialize(options = {})
    @fname, @lname = options["fname"], options["lname"]
    @id = options["id"]
    @table = "users"
  end

  def authored_questions
    Question.find_by_user_id(self.id)
  end

  def authored_replies
    Reply.find_by_user_id(self.id)
  end

  def followed_questions
    Follower.followed_questions_for_user_id(self.id)
  end

  def liked_questions
    Like.liked_questions_for_user_id(self.id)
  end

  def average_karma
    results = QuestionsDatabase.instance.execute(<<-SQL, self.id)
    SELECT
      AVG(count.qlid)
    FROM
      (SELECT
        COUNT(ql.id) qlid
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
        q.user_id = ?
      GROUP BY
        q.id) AS count
    SQL

    results.pop.values.first
  end
end