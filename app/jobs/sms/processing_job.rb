class Sms::ProcessingJob < ActiveJob::Base
  def perform(text_message)
    text_message.process
  end
end
