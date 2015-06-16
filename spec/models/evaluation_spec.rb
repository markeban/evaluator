require 'rails_helper'

RSpec.describe Evaluation, :type => :model do
  describe 'scale_calculations' do
    it 'returns the submissions in an array, the teacher, text questions in an array, the averages in an array, and the hex color for the graph for SCALE questions' do

      #setup
      FactoryGirl.create(:template)
      FactoryGirl.create(:teacher)
      FactoryGirl.create(:question)
      FactoryGirl.create(:answer, :answer => "8")
      FactoryGirl.create(:answer, :answer => "6")
      FactoryGirl.create(:answer, :answer => "9" )
      submission1 = FactoryGirl.create(:submission)
      submission2 = FactoryGirl.create(:submission)
      submission3 = FactoryGirl.create(:submission)
      evaluation = FactoryGirl.create(:evaluation)

      submissions = [submission1, submission2, submission3]
      
      #run example
      expect(evaluation.scale_calculations).to eq([[submissions], [["Question1"], ["Question2"]], [7.7], ["#a3c400"]])
    end
  end

  describe 'boolean_calculations' do
    it 'returns the text questions in an array, the average percentages for each question, and the hex color for the graph for BOOLEAN questions' do
      
      #setup
      FactoryGirl.create(:template)
      FactoryGirl.create(:question, :id => 2, :format_type => "boolean")
      FactoryGirl.create(:question, :id => 3, :format_type => "boolean")
      FactoryGirl.create(:answer, :question_id => 2, :answer => "1")
      FactoryGirl.create(:answer, :question_id => 2, :answer => "1")
      FactoryGirl.create(:answer, :question_id => 2, :answer => "0")
      FactoryGirl.create(:answer, :question_id => 3, :answer => "0")
      FactoryGirl.create(:answer, :question_id => 3, :answer => "1")
      FactoryGirl.create(:answer, :question_id => 3, :answer => "0")
      evaluation = FactoryGirl.create(:evaluation)

      #run example
      expect(evaluation.boolean_calculations).to eq([["Question2", "Question3"], [0.66, 0.33], ["#a3c400", "#e67300"]])

    end
  end

  describe 'multiple_choice_calculations' do 
    it 'returns the text questions in an array, and the percentage MULTIPLE CHOICE options for each question' do

      #setup
      FactoryGirl.create(:template)
      FactoryGirl.create(:question, :id => 4, :format_type => "multipleChoice")
      FactoryGirl.create(:question_option, :text => "Mondays")
      FactoryGirl.create(:question_option, :text => "Thursdays")
      FactoryGirl.create(:question_option, :text => "Saturdays")
      FactoryGirl.create(:answer, :question_id => 4, :answer => "Mondays")
      FactoryGirl.create(:answer, :question_id => 4, :answer => "Thursdays")
      FactoryGirl.create(:answer, :question_id => 4, :answer => "Saturdays")
      FactoryGirl.create(:answer, :question_id => 4, :answer => "Mondays")
      FactoryGirl.create(:answer, :question_id => 4, :answer => "Mondays")
      FactoryGirl.create(:answer, :question_id => 4, :answer => "Thursdays")
      evaluation = FactoryGirl.create(:evaluation)

      #run example
      expect(evaluation.multiple_choice_calculations).to eq([["Question4"], [["Mondays", 0.50], ["Thursdays", 0.33], ["Saturdays", 0.16]]])
    end
  end

  describe 'text_calculations' do
    it 'returns a 2d array; first element is the question, second element contains all the answers to TEXT questions'  do

        #setup
      FactoryGirl.create(:template)
      FactoryGirl.create(:question, :id => 5, :format_type => "text")
      FactoryGirl.create(:question, :id => 6, :format_type => "text")
      FactoryGirl.create(:answer, :question_id => 5, :answer => "Answer1")
      FactoryGirl.create(:answer, :question_id => 5, :answer => "Answer2")
      FactoryGirl.create(:answer, :question_id => 6, :answer => "Answer1")
      FactoryGirl.create(:answer, :question_id => 6, :answer => "Answer2")
      FactoryGirl.create(:answer, :question_id => 6, :answer => "Answer3")
      FactoryGirl.create(:answer, :question_id => 6, :answer => "Answer4")
      evaluation = FactoryGirl.create(:evaluation)

      #run example
      expect(evaluation.text_calculations).to eq([[["Question5"], ["Answer1", "Answer2"]], [["Question6"], ["Answer1", "Answer2", "Answer3", "Answer4"]]])

    end
  end


end
