class EvaluationsController < ApplicationController


  def new
    @teacher_select = []
      Teacher.all.each do |teacher|
      @teacher_select << [teacher.full_name, teacher.id]
    end
    @template_select = []
      Template.all.each do |template|
      @template_select << [template.name, template.id]
    end
    @evaluation = Evaluation.new
  end

  def create
    @evaluation = Evaluation.new(evaluation_params)
    

    begin
      @evaluation.url = SecureRandom.hex(4).upcase
    end while Evaluation.find_by(:url => @evaluation.url) # or (url: eval_link)

        
    if @evaluation.save
      flash[:success] = "Evaluation created successfully"
      redirect_to evaluation_path(@evaluation)
    else
      render 'new'
    end
  end

  def show
    @evaluation = Evaluation.find_by(:id => params[:id])


  end


  private

  def evaluation_params
    params.require(:evaluation).permit(:teacher_id, :template_id, :url)
  end


end
