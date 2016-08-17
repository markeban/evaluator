module AnalysisHelper
  # def combine_for_table(question_data)
  #   combined_data = []
  #    question_data.each do |choice_scores|
      
  #    end 
  # end

  def find_max_evaluations(teachers)
    teachers.map{|teacher| teacher[:data].count}.max
  end

  def find_max_evaluations_multiple_choice(question)
    question[:teachers].map{|teacher| teacher[:scores].count}.max
  end

  def find_max_evaluations_texts(question)
    question[:teachers].map{|teacher| teacher[:texts].count}.max
  end

  def multiple_choice_table_for_template(instructors)
    questions = []
    instructors.each_with_index do |instructor, index|
      instructors_realigned = {question: instructor[:table][index][:question]}
      instructors_realigned[:teachers] = instructors.map do |instructor| 
        {name: instructor[:teacher], scores: instructor[:table][index][:scores]}
      end
      questions << instructors_realigned
    end
    return questions
  end

  def texts_table_for_template(instructors)
    questions = []
    instructors.each_with_index do |instructor, index|
      instructors_realigned = {question: instructor[:texts][index][:question]}
      instructors_realigned[:teachers] = instructors.map do |instructor| 
        {name: instructor[:teacher], texts: instructor[:texts][index][:different_dates]}
      end
      questions << instructors_realigned
    end
    return questions
  end

end
