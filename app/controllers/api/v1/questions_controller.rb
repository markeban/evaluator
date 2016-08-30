class Api::V1::QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :restrict_current_user_template!, except: [:batch_destroy]

  def new
    @template = Template.find_by(:id => params[:template_id])
    @question = Question.new
  end


  def create
    @question = Question.new(question_params)
    if @question.save
    else
      render json: { errors: @question.questionErrors.full_messages }, status: 422
    end
  end

  def batch_create
    @questions = []
    errors = []
    params[:questions].each do |question|
      if question[:id]
        question = Question.find_by(:id => question[:id])
        question.assign_attributes(:text => question[:text], :template_id => question[:template_id], :required => question[:required], :format_type => question[:format_type])
      else
        question = Question.new(:text => question[:text], :template_id => question[:template_id], :required => question[:required], :format_type => question[:format_type])
      end
      if question.save
        if question[:options]
          question[:options].each do |option|
            if option[:id]
              existing_option = QuestionOption.find_by(:id => option[:id])
              existing_option.update(:text => option[:text])
            else
              question.question_options.create(:text => option[:text])
            end
          end
        end
      else
        errors << question.errors.full_messages
      end
      @questions << question
    end
    errors.empty? ? @questions : (render json: { errors: errors.flatten }, status: 422)
  end

  def batch_destroy
    if params[:questions] && restrict_current_user_template!
      params[:questions].each do |question|
        question = Question.find_by(:id => question[:id])
        if question
          question.destroy
        end
      end
    else
      render json: {message: "no questions to destroy"}
    end
  end

  def index
    template_id = params[:template_id]
    @questions = Question.where(:template_id => template_id)
  end

  
  def destroy
    template = Template.find_by(:id => params[:id])
    template.questions.destroy_all
  end


  private

  def question_params
    params.require(:question).permit(:text, :required, :format_type, :template_id)
  end

end

