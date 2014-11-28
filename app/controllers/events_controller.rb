class EventsController < ApplicationController
  before_action :set_event, except: [:index, :new, :create]

  def index
    @events = Event.order(date: :desc)
  end

  def new
    @event = Event.new
  end

  def create
    event = Event.create!(event_params)

    redirect_to event
  end

  def edit
  end

  def show
    @attendees = @event.attendees
  end

  def update
    @event.update!(event_params)

    redirect_to events_url
  end

  def destroy
    @event.destroy

    redirect_to events_url
  end

  def activate
    @event.update!(active: true)

    redirect_to :back
  end

  def deactivate
    @event.update!(active: false)

    redirect_to :back
  end

  private
    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:name, :date)
    end
end
