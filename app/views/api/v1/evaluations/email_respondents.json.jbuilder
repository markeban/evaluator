json.id @evaluation.id
json.template_id @evaluation.template_id
json.url @evaluation.url
json.created_at @evaluation.created_at
json.updated_at @evaluation.updated_at
json.subject @evaluation.subject
json.message @evaluation.message
if @evaluation.errors
  json.error_messages @evaluation.errors
else
  json.error_messages nil
end
