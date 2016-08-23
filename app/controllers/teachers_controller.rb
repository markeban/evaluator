class TeachersController < ApplicationController
  before_action :authenticate_user!

  def new
    @teacher = Teacher.new
    if params[:self]
      @teacher.email = current_user.email 
      @teacher.name = current_user.full_name
    end
  end

  def index
    @teachers = current_user.teachers
  end

   def create
    @teacher = current_user.teachers.new(teacher_params)
    if @teacher.save
      flash[:success] = "Teacher added successfully"
      redirect_to new_evaluation_path
    else
      render :new
    end
  end

  private

  def teacher_params
    params.require(:teacher).permit(:name, :email)
  end

end
