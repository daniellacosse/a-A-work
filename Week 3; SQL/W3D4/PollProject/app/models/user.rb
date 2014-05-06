class User < ActiveRecord::Base

  validates :user_name, :presence => true, :uniqueness => true

  has_many(
    :authored_polls,
    :class_name => "Poll",
    :foreign_key => :author_id,
    :primary_key => :id
  )

  has_many(
    :responses,
    :class_name => "Response",
    :foreign_key => :user_id,
    :primary_key => :id
  )

  def completed_polls
    query = <<-SQL
      SELECT
        pol.*
      FROM
        polls AS pol
      JOIN questions as qu
        ON pol.id = qu.poll_id
      JOIN answer_choices AS ans
        ON ans.question_id = qu.id
      LEFT OUTER JOIN (
          SELECT
            responses.*
          FROM
            responses
          WHERE
            responses.user_id = ?
        ) AS resp
        ON resp.answer_choice_id = ans.id
      GROUP BY pol.id
      HAVING COUNT(DISTINCT qu.id) = COUNT(resp.id)
    SQL

    Poll.find_by_sql(query, self.id)
  end

  def uncompleted_polls
    query = <<-SQL
      SELECT
        pol.*
      FROM
        polls AS pol
      JOIN questions as qu
        ON pol.id = qu.poll_id
      JOIN answer_choices AS ans
        ON ans.question_id = qu.id
      LEFT OUTER JOIN (
          SELECT
            responses.*
          FROM
            responses
          WHERE
            responses.user_id = ?
        ) AS resp
        ON resp.answer_choice_id = ans.id
      GROUP BY pol.id
      HAVING COUNT(DISTINCT qu.id) != COUNT(resp.id)
      AND COUNT(resp.id) > 0
    SQL

    Poll.find_by_sql(query, self.id)
  end

end

#Poll.joins(:questions => {:answer_choices => :responses})
# => .where("user.id = ?", self.id)
# => .group("polls.id")
# => .having("COUNT(questions.id) = COUNT(responses.id)")

#Poll.joins(:questions => {:answer_choices => {:responses => :users}})
# => .where("user.id = ?", self.id)
# => .group("polls.id")
# => .having("COUNT(questions.id) != COUNT(responses.id) AND COUNT(responses.id > 0)")