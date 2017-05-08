require 'rails_helper'
require 'devise'

RSpec.describe Api::V1::EvaluationsController, type: :controller do
  login_user
  
  before(:each) do
    @evaluation = FactoryGirl.create(:evaluation)
    FactoryGirl.create(:teacher, user_id: subject.current_user.id)
    @respondent_1 = FactoryGirl.create(:respondent, email: 'test1@gmail.com', evaluation_id: @evaluation.id)
    @respondent_2 = FactoryGirl.create(:respondent,  email: 'test2@gmail.com', evaluation_id: @evaluation.id, emailed: true)
    @respondent_3 = FactoryGirl.create(:respondent,  email: 'test3@gmail.com', evaluation_id: @evaluation.id)
  end

  describe "PATCH #email_respondents" do
    context "with valid params" do
      it "should email respondents just inputed by user" do
        patch :email_respondents, {id: @evaluation.id, email_contents: {subject: "Hello Class!", message: "Please fill out this survey"}}
        expect(response.body).to eq(@evaluation.respondents.to_json)
      end
    end

    context "with invalid params" do
      it "should email respondents just inputed by user" do
        patch :email_respondents, {id: @evaluation.id, email_contents: {subject: "", message: "Please fill out this survey"}, format: :json}
        json_cool = JSON.parse(response.body)
        expect(JSON.parse(response.body)["error_messages"]["subject"]).to eq(["can't be blank"])
        expect(response.status).to eq(422)
      end
    end
  end
end
