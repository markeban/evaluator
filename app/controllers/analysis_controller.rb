class AnalysisController < ApplicationController

  def index
    @analysis = Analysis.new
    @teacher_select = []
      Teacher.all.each do |teacher|
      @teacher_select << [teacher.full_name, teacher.id]
    end
  end
end
