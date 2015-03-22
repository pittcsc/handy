class Twilio::BaseController < ActionController::Base
  before_action :validate_twilio_request

  private
    def validate_twilio_request
      head :forbidden unless valid_twilio_request?
    end

    def valid_twilio_request?
      Twilio::Util::RequestValidator.new.validate(request.original_url, request.POST, request.headers['X-Twilio-Signature'].to_s)
    end
end
