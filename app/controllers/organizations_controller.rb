class OrganizationsController < ApplicationController
  def index
    @organizations = current_user.organizations
  end

  def show
    @events = Organization.find(params[:id]).events
  end

  def new
    @organization = Organization.new
  end

  def create
    organization = Organization.create!(organization_params)

    redirect_to organization
  end

  def edit
  end

  def update
    @organiztaion.update!(organization_params)

    redirect_to organizations_url
  end

  def destroy
    @organization.destroy!
    
    redirect_to organizations_url
  end

  private
    def current_user
      @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
    end

    def organization_params
      params.require(:organization).permit(:name)
    end
end
