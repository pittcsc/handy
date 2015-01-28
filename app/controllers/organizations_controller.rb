class OrganizationsController < ApplicationController
  before_action :set_organization, except: [:index, :new, :create]

  def index
    @organizations = current_user.organizations
  end

  def new
    @organization = Organization.new
  end

  def create
    organization = Organization.create!(organization_params)
    organization.users.append(current_user)

    redirect_to organization_events_url(organization)
  end

  def edit
  end

  def update
    @organization.update!(organization_params)

    redirect_to organization_events_url(@organization)
  end

  def destroy
    @organization.destroy!
    
    redirect_to organizations_url
  end

  private
    def set_organization
      unless @organization = current_user.organizations.find(params[:id])
        redirect_to organizations_url
      end
    end

    def organization_params
      params.require(:organization).permit(:name)
    end
end
