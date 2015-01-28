class EventsController < ApplicationController
  before_action :set_organization
  before_action :set_event, except: [:index, :new, :create]

  def index
    @events = @organization.events.order(date: :desc).page(current_page)
  end

  def show
    @attendees = @event.attendees
  end

  def new
    @event = Event.new
  end

  def create
    event = @organization.events.create!(event_params)

    redirect_to organization_event_url(@organization, event)
  end

  def edit
  end

  def update
    @event.update!(event_params)

    redirect_to @organization
  end

  def destroy
    @event.destroy!

    redirect_to @organization
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
      @event = @organization.events.find(params[:id])
    end

    def set_organization
      unless @organization = current_user.organizations.find_by_id(params[:organization_id])
        redirect_to organizations_url
      end
    end

    def event_params
      params.require(:event).permit(:name, :date)
    end
end
