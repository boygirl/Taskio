class NotificationController < ApplicationController
  def index
    Membership.group(:user_email).each do |user|
      Notifier.weekly_email(user.user_email).deliver
    end
    Membership.group(:user_email).each do |user|
      Notifier.daily_email(user.user_email).deliver
    end
    redirect_to root_path
  end
end
