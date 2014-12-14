class Api::V1::QuestionsController < ApplicationController

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
    params[:questions].each do |question|
      if question[:id]
        new_question = Question.find_by(:id => question[:id])
        new_question.update(:text => question[:text], :template_id => question[:template_id], :required => question[:required], :format_type => question[:format_type])
      else
        new_question = Question.create(:text => question[:text], :template_id => question[:template_id], :required => question[:required], :format_type => question[:format_type])
      end
      if question[:options]
        question[:options].each do |option|
          if option[:id]
            existing_option = QuestionOption.find_by(:id => option[:id])
            existing_option.update(:text => option[:text])
          else
            new_question.question_options.create(:text => option[:text])
          end
        end
      end
      @questions << new_question
    end
  end

  def batch_destroy
    if params[:questions]
      params[:questions].each do |question|
        question = Question.find_by(:id => question[:id])
        question.destroy
      end
    end
  end

  def index
    template_id = params[:template_id]
    @questions = Question.where(:template_id => template_id)
  end

  
  # def destroy
  #   template = Template.find_by(:id => params[:id])
  #   template.questions.destroy_all
  # end


  private

  def question_params
    params.require(:question).permit(:text, :required, :format_type, :template_id)
  end

end

