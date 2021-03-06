class Question < ApplicationRecord
  belongs_to :template
  has_many :answers
  has_many :submissions, :through => :answers
  has_many :question_options, :dependent => :destroy

  validates :text, presence: true


    def format_type_text
    if self.format_type == "text"
      return "This question requests a written answer."
    elsif self.format_type == "multipleChoice"
      return "This question requests a user to choose only one option from a list."
    elsif self.format_type == "scale1To10"
      return "This question requests a user to scale the question from 1 to 10."
    elsif self.format_type == "boolean"
      return "This question requests a true/false (yes/no) answer."
    end
  end

    def required_text
    if self.required
      return "Required"
    else 
      return ""
    end
  end

  def label
    if required
      return "required"
    else
      return "optional"
    end
  end


end
