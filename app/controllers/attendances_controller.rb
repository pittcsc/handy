class AttendancesController < ApplicationController
  before_action :set_event

  def index
    @attendances = @event.attendances.includes(:member)
  end

  private
    def set_event
      @event = Event.find(params[:event_id])
    end
end
