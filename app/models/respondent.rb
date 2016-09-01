class Respondent < ActiveRecord::Base
  belongs_to :evaluation

  validates :email, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end


  def access_token
    Respondent.create_access_token(self)
  end

  # Verifier based on our application secret
  def self.verifier
    ActiveSupport::MessageVerifier.new(Rails.application.secrets.secret_key_base)
  end

  # Get a user from a token
  def self.read_access_token(signature)
    id = verifier.verify(signature)
    Respondent.find_by(id: id)
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    nil
  end

  # Class method for token generation
  def self.create_access_token(respondent)
    verifier.generate(respondent.id)
  end

end
