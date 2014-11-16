class TeachersController < ApplicationController
 
  def new
     @teacher = Teacher.new
  end

  def index
    @teachers = Teacher.all
  end

  private

  def teacher_params
    params.require(:question).permit(:first_name, :last_name, :email)
  end

end
