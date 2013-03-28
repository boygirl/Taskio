class NotificationController < ApplicationController
  def index
    #Low Priority notifications
    # Membership.group(:user_email).each do |user|
    #   Notifier.weekly_email(user.user_email).deliver
    # end

    #Medium Priority notifications
    # Membership.group(:user_email).each do |user|
    #   Notifier.daily_email(user.user_email).deliver
    # end

    #High Priority notifications (email only)
    # Membership.group(:user_email).each do |user|
    #   Notifier.urgent_email(user.user_email).deliver
    # end

    #Email notifications for all tasks
     Membership.group(:user_email).each do |user|
      Notifier.all_email(user.user_email).deliver
    end


    #SMS notifications for high priority tasks
    Membership.group(:user_email).each do |user|
      Notifier.text_notification(user.user_email)
    end

    redirect_to root_path
  end
end
