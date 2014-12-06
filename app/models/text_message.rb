class TextMessage < ActiveRecord::Base
  def member
    @member ||= Member.find_by_phone(phone_number)
  end

  def registration
    @registration ||= Registration.find_by_phone_number(phone_number)
  end

  def process_later
    Sms::ProcessingJob.perform_later(self)
  end

  def process
    if member
      AttendanceProcessor.process(self)
    else
      RegistrationProcessor.process(self)
    end

    destroy!
  end

  def respond_later(response_body)
    Sms::DeliveryJob.perform_later(phone_number, response_body)
  end
end
