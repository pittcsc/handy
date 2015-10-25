module TextMessage::Receivable
  RECEIVERS = [ AttendanceReceiver, RegistrationReceiver ]

  private
    def receive
      receiver_classes.each do |klass|
        klass.new(self).receive
      end
    end

    def receiver_classes
      RECEIVERS.select { |klass| klass.accept?(self) }
    end
end
