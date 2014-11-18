class EventsController < ApplicationController
  before_action :set_event, except: [:index, :new, :create]

  def index
    @events = Event.order(date: :desc)
    @current_event = Event.current
  end

  def new
    @event = Event.new
  end

  def create
    event = Event.create!(event_params)

    redirect_to event_url(event)
  end

  def edit
  end

  def show
    @attendances = @event.attendances.includes(:member)
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
