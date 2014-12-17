class EventsController < ApplicationController
  before_action :set_event, except: [:new, :create]
  before_action :set_organization

  def show
    @attendees = @event.attendees
  end

  def new
    @event = Event.new
  end

  def create
    event = Event.create!(event_params)
    @organization.events.append(event)

    redirect_to organization_event_url(@organization, event)
  end

  def edit
  end

  def update
    @event.update!(event_params)

    redirect_to organization_url(@organization)
  end

  def destroy
    @event.destroy!

    redirect_to organization_url(@organization)
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

    def set_organization
      @organization = Organization.find(params[:organization_id])
    end

    def event_params
      params.require(:event).permit(:name, :date)
    end
end
