class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :templates
  has_many :teachers, :through => :templates
  has_many :teachers
  has_one :subscription

  def has_payment_info?
    subscription.braintree_customer_id if subscription
  end

  def full_name
    "#{first_name} #{last_name}"
  end

end
