class TextMessage < ActiveRecord::Base
  include Receivable, Deliverable

  enum direction: [:incoming, :outgoing]

  before_save :normalize_body
  after_commit :process_later, on: :create

  def member
    @member ||= Member.find_by_phone(phone_number)
  end

  def registration
    @registration ||= Registration.find_by_phone_number(phone_number)
  end

  def process
    if incoming?
      receive
    else
      deliver
    end

    destroy!
  end

  def respond(body)
    self.class.outgoing.create!(phone_number: phone_number, body: body)
  end

  private
    def normalize_body
      self.body = body.strip
    end

    def process_later
      TextMessageProcessingJob.perform_later(self)
    end
end
