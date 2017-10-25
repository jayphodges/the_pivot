class MessageSender
  def self.send_code(phone, code)
    account_sid = ENV['TWILIO_KEY']
    auth_token = ENV['TWILIO_SECRET']
    client = Twilio::REST::Client.new(account_sid, auth_token)

    message = client.messages.create(
      from: ENV['TWILIO_PHONE'],
      to: phone,
      body: code
    )

    message.status == 'queued'
  end
end