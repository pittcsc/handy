class EventsController < ApplicationController
  before_action :set_event, except: [:index, :new, :create]

  def index
    @events = Event.all
    @current = Event.current
  end

  def new
    @event = Event.new
  end

  def create
    Event.create!(event_params)

    redirect_to events_url
  end

  def edit
  end

  def show
    @attendances = @event.attendances
  end

  def update
    @event.update!(event_params)

    redirect_to events_url
  end

  def destroy
    @event.destroy

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

    def event_params
      params.require(:event).permit(:name, :date)
    end
end
