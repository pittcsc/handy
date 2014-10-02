class AttendancesController < ApplicationController
  before_action :set_event
  def index
    @attendances = @event.attendances.all
  end

  private
    def set_event
      @event = Event.find(params[:event_id])
    end
end
