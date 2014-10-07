class EventsController < ApplicationController
  before_action :set_event, only: [:make_current, :remove_current]

  def index
    @events = Event.all
    @current = Event.find_by_current true
  end

  def new
    @event = Event.new
  end

  def create
    event = params[:event]
    name = event[:name]
    date = event[:date]

    event = Event.create(name: name, date: date)

    redirect_to events_url
  end

  def show
    event_id = params[:id]

    @event = Event.find(event_id)
  end

  def edit
    event_id = params[:id]

    @event = Event.find(event_id)
  end

  def update
    event_params = params[:event]
    name = event_params[:name]
    date = event_params[:date]

    event = Event.find(params[:id])

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
    @event.update!(current: true)

    redirect_to events_url
  end

  def remove_current
    @event.update!(current: false)

    redirect_to events_url
  end

  private
    def set_event
      @event = Event.find(params[:id])
    end
end
