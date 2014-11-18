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



end
