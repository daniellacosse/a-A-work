class Response < ActiveRecord::Base

  validates :answer_choice_id, :presence => true
  validates :user_id, :presence => true
  validate :respondent_has_not_already_answered_question
  validate :author_cant_respond_to_own_poll

  belongs_to(
    :answer_choice,
    :class_name => "AnswerChoice",
    :foreign_key => :answer_choice_id,
    :primary_key => :id
  )

  belongs_to(
    :respondent,
    :class_name => "User",
    :foreign_key => :user_id,
    :primary_key => :id
  )

  private
  def author_cant_respond_to_own_poll
    polls = Poll.joins(:questions => :answer_choices)
            .where("answer_choices.id = ?", self.answer_choice_id)

    if polls.first.author_id == self.user_id
      errors[:user_id] << "author can't respond to own poll"
    end
  end

  def respondent_has_not_already_answered_question
    resp = existing_responses
    unless resp.empty? || (resp.length == 1 && resp.first.id = self.id)
      errors[:user_id] << "user has already answered this question"
    end
  end

  def existing_responses
    query = <<-SQL
      SELECT
        r.*
      FROM
        responses AS r
      JOIN
        answer_choices AS a
      ON
        a.id = r.answer_choice_id
      WHERE
        r.user_id = ?
      AND
        a.question_id = (
          SELECT
            answer_choices.question_id
          FROM
            answer_choices
          WHERE
            answer_choices.id = ?
        )
    SQL

    Response.find_by_sql(query, [self.user_id, self.answer_choice_id])
  end
end