class Submission < ApplicationRecord
  belongs_to :evaluation
  has_one :template, through: :evaluation
  has_many :answers
  has_many :questions, :through => :answers


  accepts_nested_attributes_for :answers

  def scale_answers
    answers.select { |answer| answer.question.format_type == "scale1To10" }.map { |answer| answer.answer.to_i }
  end

  def multiple_choice_answers
    answers.select { |answer| answer.question.format_type == "multipleChoice" }.map { |answer| answer.answer }
  end

  def boolean_answers
    answers.select { |answer| answer.question.format_type == "boolean" }.map { |answer| answer.answer.to_i }
  end



end
