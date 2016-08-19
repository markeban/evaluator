class FirstLastToNameTeachers < ActiveRecord::Migration
  class Teacher < ActiveRecord::Base
  end


  def change
    add_column :teachers, :name, :string
    Teacher.all.each do |teacher|
      teacher.name = "#{teacher.first_name} #{teacher.last_name}"
      teacher.save
    end
  end
end
