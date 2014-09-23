class CurrentEventsController < ApplicationController
  def index
    if CurrentEvent.first
      @current_event = CurrentEvent.first
      @event = Event.find(@current_event.event_id)
    end
  end

  def new
    @event_list = Event.all
    @event = CurrentEvent.new
  end

  def create
    if(CurrentEvent.first)
      CurrentEvent.destroy(CurrentEvent.first.id)
    end

    event_id = params[:id]

    new_current_event = CurrentEvent.create(event_id: event_id)
    new_current_event.save 

    redirect_to current_events_url
  end

  def destroy
    CurrentEvent.destroy(CurrentEvent.first.id)
    redirect_to current_events_url
  end
end
