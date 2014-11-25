class TeachersController < ApplicationController
 
  def new
     @teacher = Teacher.new
  end

  def index
    @teachers = Teacher.all
  end

   def create
    @teacher = Teacher.new(teacher_params)
    if @teacher.save
      flash[:success] = "Teacher added successfully"
      redirect_to new_evaluation_path
    else
      render 'new'
    end
  end






  private

  def teacher_params
    params.require(:teacher).permit(:first_name, :last_name, :email)
  end

end
