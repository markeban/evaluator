class Question < ActiveRecord::Base
  belongs_to :template

    def format_type_text
    if self.format_type == "text"
      return "This question requests a written answer."
    elsif self.format_type == "ranking"
      return "This question requests a user to rank the criteria above."
    elsif self.format_type == "multiple_choice"
      return "This question requests a multiple choice answer."
    elsif self.format_type == "boolean"
      return "This question requests a true/false (yes/no) answer."
    end
  end

    def required_text
    if self.required
      return "This question is required."
    else 
      return "This question is optional."
    end
  end



end
