class Template < ActiveRecord::Base
  belongs_to :user
  has_many :questions
  has_many :evaluations
  has_many :submissions
  has_many :teachers, :through => :evaluations
  has_many :answers, :through => :questions



end
