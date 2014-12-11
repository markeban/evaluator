json.id question.id
json.text question.text
json.template_id question.template_id
json.required question.required
json.format_type question.format_type
json.options question.question_options.each do |option|
  json.id option.id
  json.text option.text
end
