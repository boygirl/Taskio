class DashboardsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_membership

  def show

  end

  private

  def find_membership
    @membership = Membership.where(user_email: current_user.email)
  end
end
