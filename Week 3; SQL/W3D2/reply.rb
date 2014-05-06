class Reply < Lonely
  def self.all
    results = QuestionsDatabase.instance.execute("SELECT * FROM replies")
    results.map { |reply| Reply.new(reply) }
  end

  def self.find_by_id(id)
    results = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?
    SQL
      Reply.new(results.pop)
  end

  def self.find_by_user_id(id)
   results = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        user_id = ?
    SQL
    results.map { |q| Reply.new(q) }
  end

  def self.find_by_question_id(id)
    results = QuestionsDatabase.instance.execute(<<-SQL, id)
       SELECT
         *
       FROM
         replies
       WHERE
         q_id = ?
     SQL
     results.map { |q| Reply.new(q) }
  end

  attr_accessor :body, :id, :user_id, :q_id, :parent_id

  def initialize(options = {})
    @body = options["body"]
    @user_id = options["user_id"]
    @q_id, @parent_id = options["q_id"], options["parent_id"]
    @id = options["id"]
    @table = "replies"
  end

  def author
    User.find_by_id(self.user_id)
  end

  def question
    Question.find_by_id(self.q_id)
  end

  def parent_reply
    Reply.find_by_id(self.parent_id)
  end

  def child_replies
    results = QuestionsDatabase.instance.execute(<<-SQL, self.id)
      SELECT
        *
      FROM
        replies
      WHERE
        parent_id = ?
    SQL
    results.map { |q| Reply.new(q) }
  end

  # def save
  #   if self.id.nil?
  #
  #     QuestionsDatabase.instance.execute(<<-SQL, self.body, self.user_id, self.q_id, self.parent_id)
  #     INSERT INTO
  #       replies(body, user_id, q_id, parent_id)
  #     VALUES
  #       (?, ?, ?, ?)
  #     SQL
  #
  #     self.id = QuestionsDatabase.instance.last_insert_row_id
  #
  #   else
  #     QuestionsDatabase.instance.execute(<<-SQL, self.body, self.user_id, self.q_id, self.parent_id, self.id)
  #     UPDATE
  #       replies
  #     SET
  #       body = ?, user_id = ?, q_id = ?, parent_id = ?
  #     WHERE
  #       id = ?
  #     SQL
  #   end
  # end
end