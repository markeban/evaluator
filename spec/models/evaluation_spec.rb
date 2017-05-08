require 'rails_helper'

RSpec.describe Evaluation, :type => :model do
  describe '#email_respondents_for_first_time' do
    it 'should only email respondents that haven\'t already been sent an email' do
      evaluation = FactoryGirl.create(:evaluation)
      respondent_1 = FactoryGirl.create(:respondent, email: 'test1@gmail.com', evaluation_id: evaluation.id)
      respondent_2 = FactoryGirl.create(:respondent,  email: 'test2@gmail.com', evaluation_id: evaluation.id, emailed: true)
      respondent_3 = FactoryGirl.create(:respondent,  email: 'test3@gmail.com', evaluation_id: evaluation.id)
      expect(evaluation.email_respondents_for_first_time).to eq([respondent_1, respondent_3])
    end
  end 
end
