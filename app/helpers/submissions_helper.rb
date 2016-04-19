module SubmissionsHelper

  def required?(question)
    required_or_optional = question.required ? "required" : "optional"
    "<span class='#{required_or_optional} text-right'>#{required_or_optional.capitalize}</span>"
  end

end
