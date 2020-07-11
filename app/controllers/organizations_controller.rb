class OrganizationsController < ApplicationController
  before_action :build_organization, only: %i[new create]

  def index
    @organizations = @user.organizations.order(:slug)
  end

  def create
    Organization.create!(create_params)
    redirect_to action: :index
  rescue ActiveRecord::RecordInvalid => e
    flash.now[:error] = e.message
    render action: :new
  end

  def new; end

  private def build_organization
    @organization = Organization.new(create_params)
    @organization.validate if params[:organization].present?
  end

  private def create_params
    params.fetch(:organization, {}).permit(
      :name
    ).merge(user_organizations_attributes: [{
                                              role: UserOrganization::ROLES[:CREATOR],
                                              user: @user
                                            }])
  end
end
