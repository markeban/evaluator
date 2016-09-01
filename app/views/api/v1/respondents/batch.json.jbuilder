json.array! @respondents.each do |respondent|
  json.id respondent.id
  json.first_name respondent.first_name
  json.last_name respondent.last_name
  json.email respondent.email
  json.responded respondent.responded
  json.created_at respondent.created_at
  json.updated_at respondent.updated_at
  json.evaluation_id respondent.evaluation_id
  json.emailed respondent.emailed
  json.unsubscribed_to_user respondent.unsubscribed_to_user
  json.unsubscribed_to_all respondent.unsubscribed_to_all
  if respondent.errors
    json.error_messages respondent.errors.full_messages
  else
    json.error_messages nil
  end
end