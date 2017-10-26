module TokenAuthenticatable
  extend ActiveSupport::Concern

  included do
    before_save :ensure_auth_token
  end

  module ClassMethods
    def find_by_token(token)
      find_by(auth_token: token)
    end
  end

  def ensure_auth_token
    self.auth_token = generate_auth_token if auth_token.blank?
  end

  private

  def generate_auth_token
    loop do
      token = SecureRandom.hex
      break token unless self.class.exists?(auth_token: token)
    end
  end
end
