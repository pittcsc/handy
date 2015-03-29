class TextMessage < ActiveRecord::Base
  before_save :normalize_body
  after_commit :process_later, on: :create

  def member
    @member ||= Member.find_by_phone(phone_number)
  end

  def registration
    @registration ||= Registration.find_by_phone_number(phone_number)
  end

  def process
    Receiver.for(self).receive
    destroy!
  end

  def respond_later(response_body)
    Sms::DeliveryJob.perform_later(phone_number, response_body)
  end

  private
    def normalize_body
      self.body = body.strip
    end

    def process_later
      TextMessageProcessingJob.perform_later(self)
    end
end
