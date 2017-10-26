class ConfirmationSender
  def self.send_confirmation_sms(user)
    reset_code = rand(10000-99999).to_s
    user.update(reset_code: reset_code)
    MessageSender.send_code(user.phone, reset_code)
  end
end