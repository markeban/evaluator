class Submission < ActiveRecord::Base
  belongs_to :evaluation
  belongs_to :template
  has_many :answers
  has_many :questions, :through => :answers


  accepts_nested_attributes_for :answers

  def scale_answers
    answers.select { |answer| answer.question.format_type == "scale1To10" }.map { |answer| answer.answer.to_i }
  end

  def multiple_choice_answers
    answers.select { |answer| answer.question.format_type == "multipleChoice" }.map { |answer| answer.answer }
  end



end
