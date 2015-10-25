module TextMessage::Deliverable
  private

  def deliver
    Delivery.new(self).deliver
  end
end
