class TextMessage < ActiveRecord::Base
  def member
    @member ||= Member.find_by_phone(phone_number)
  end

  def registration
    @registration ||= Registration.find_by_phone_number(phone_number)
  end

  def enqueue_for_processing
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

  def respond(response_body)
    Sms::DeliveryJob.perform_later(phone_number, response_body)
  end
end
