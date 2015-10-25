module TextMessage::Receivable
  RECEIVERS = [ AttendanceReceiver, RegistrationReceiver ]

  private
    def receive
      receiver_class.new(self).receive
    end

    def receiver_class
      RECEIVERS.find { |klass| klass.accept?(self) }
    end
end
