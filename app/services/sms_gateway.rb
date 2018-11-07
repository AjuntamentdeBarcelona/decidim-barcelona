# frozen_string_literal: true

# This class sends an SMS to a user so they can verify their
# phone number.
class SmsGateway
  attr_reader :mobile_phone_number, :code

  def initialize(mobile_phone_number, code)
    @mobile_phone_number = mobile_phone_number
    @code = code
  end

  def deliver_code
    raise "Pending to implement"
  end
end
