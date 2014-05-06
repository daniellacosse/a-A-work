class Question < ActiveRecord::Base

  validates :text, :presence => true
  validates :poll_id, :presence => true

  has_many(
    :answer_choices,
    :class_name => "AnswerChoice",
    :foreign_key => :question_id,
    :primary_key => :id,
    :dependent => :destroy
  )

  belongs_to(
    :poll,
    :class_name => "Poll",
    :foreign_key => :poll_id,
    :primary_key => :id
  )

  def results
    votes = Hash.new(0)

    choices_w_counts = self
      .answer_choices
      .select("answer_choices.*, COUNT(responses.id) AS response_count")
      .joins("LEFT OUTER JOIN responses ON answer_choices.id = responses.answer_choice_id")
      .group("responses.answer_choice_id")

    choices_w_counts.each do |choice|
      votes[choice.text] += choice.response_count
    end

    votes
  end
end