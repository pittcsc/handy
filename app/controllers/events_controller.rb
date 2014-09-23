class EventsController < ApplicationController
  helper_method :make_current

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    event = params[:event]
    name = event[:name]
    date = event[:date]

    event = Event.create(name: name, date: date)
    event.save

    redirect_to events_url
  end

  def show
    event_id = params[:id]

    @event = Event.find(event_id)
  end

  def edit
  end

  def update
    event_id = params[:id]
    name = params[:name]
    date = params[:date]

    event = Event.find(event_id)
    event.name = name
    event.date = date

    event.save

    redirect_to events_url
  end

  def destroy
    event_id = params[:id]
    Event.destroy(event_id)

    redirect_to events_url
  end

  def make_current
    if event = Event.find(params[:id])
      event.current = true;
      event.save
    end

    redirect_to events_url
  end
end
