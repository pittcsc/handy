class TextMessage < ActiveRecord::Base
  def process
    InboundMessageProcessor.new(self).process
  end
end
