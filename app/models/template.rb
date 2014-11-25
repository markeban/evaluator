class Template < ActiveRecord::Base
  belongs_to :user
  has_many :questions
  has_many :evaluations
  has_many :submissions



end
