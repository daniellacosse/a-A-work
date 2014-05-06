class Question < Lonely
  def self.all
    results = QuestionsDatabase.instance.execute("SELECT * FROM questions")
    results.map { |question| Question.new(question) }
  end



  def self.find_by_user_id(id)
    results = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        questions
      WHERE
        user_id = ?
    SQL
    results.map { |q| Question.new(q) }
  end

  def self.most_followed(n)
    Follower.most_followed_questions(n)
  end

  def self.most_liked(n)
    Like.most_liked_questions(n)
  end

  attr_accessor :title, :body, :id, :user_id

  def initialize(options = {})
    @title, @body = options["title"], options["body"]
    @user_id = options["user_id"]
    @id = options["id"]
    @table = "questions"
  end

  def author
    User.find_by_id(self.user_id)
  end

  def replies
    Reply.find_by_question_id(self.id)
  end

  def followers
    Follower.followers_for_question_id(self.id)
  end

  def likers
    Like.likers_for_question_id(self.id)
  end

  def num_likes
    Like.num_likes_for_question_id(self.id)
  end

  # def save
  #   if self.id.nil?
  #     QuestionsDatabase.instance.execute(<<-SQL, self.title, self.body, self.user_id)
  #     INSERT INTO
  #       questions(title, body, user_id)
  #     VALUES
  #       (?, ?, ?)
  #     SQL
  #
  #     self.id = QuestionsDatabase.instance.last_insert_row_id
  #
  #   else
  #     QuestionsDatabase.instance.execute(<<-SQL, self.title, self.body, self.user_id, self.id)
  #     UPDATE
  #       questions
  #     SET
  #       title = ?, body = ?, user_id = ?
  #     WHERE
  #       id = ?
  #     SQL
  #   end
  # end

end
