class Notifier < ActionMailer::Base
  default from: "Taskio <laurentestsender@gmail.com>"

#priority = 1
  def weekly_email(user_email)
    content = ""
    address = user_email
    Membership.where(user_email: user_email).each do |membership|
      Task.where(group_id: membership.group_id).each do |task|
        if task.priority == 1
          content << task.title
        end
      end
      Subtask.where(group_id: membership.group_id).each do |subtask|
        if subtask.priority == 1
          content << subtask.title
        end
      end
    end
    unless content.empty?
      mail(to: address, subject: "Weekly Tasks", body: content)
    end
  end

  #priority = 2
  def daily_email(user_email)
    content = ""
    address = user_email
    Membership.where(user_email: user_email).each do |membership|
      Task.where(group_id: membership.group_id).each do |task|
        if task.priority == 2
          content << task.title
        end
      end
      Subtask.where(group_id: membership.group_id).each do |subtask|
        if subtask.priority == 2
          content << subtask.title
        end
      end
    end
    unless content.empty?
      mail(to: address, subject: "Daily Tasks", body: content)
    end
  end

  #priority = 3
  def urgent_notification(user_email)
    content = ""
    address = user_email
    logger.info 'email: ' + user_email
    logger.info User.where(:email, user_email).first
    phone = User.where(email: user_email).first.phone
    Membership.where(user_email: user_email).each do |membership|
      Task.where(group_id: membership.group_id).each do |task|
        if task.priority == 2
          content << task.title
        end
      end
      Subtask.where(group_id: membership.group_id).each do |subtask|
        if subtask.priority == 2
          content << subtask.title
        end
      end
    end
    unless phone.nil?
      if content.empty? == false
        TWILIO_CLIENT.account.sms.messages.create(
          from: TWILIO_NUMBER,
          to: "+#{phone}",
          body: content
        )
      end
    end

    # unless content.empty?
    #   mail(to: address, subject: "Daily Tasks", body: content)
    # end
  end

end


