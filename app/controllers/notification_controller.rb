class NotificationController < ApplicationController
  def index
    #Low Priority notifications
    # Membership.group(:email).each do |user|
    #   Notifier.weekly_email(user.email).deliver
    # end

    #Medium Priority notifications
    # Membership.group(:email).each do |user|
    #   Notifier.daily_email(user.email).deliver
    # end

    #High Priority notifications (email only)
    # Membership.group(:email).each do |user|
    #   Notifier.urgent_email(user.email).deliver
    # end

    #Email notifications for all tasks
     Membership.group(:email).each do |user|
      Notifier.all_email(user.email).deliver
    end


    #SMS notifications for high priority tasks
    Membership.group(:email).each do |user|
      Notifier.text_notification(user.email)
    end

    redirect_to root_path
  end
end
