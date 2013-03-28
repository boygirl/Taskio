class Notifier < ActionMailer::Base
  default from: "Taskio <laurentestsender@gmail.com>"

#priority = 1
  def weekly_email(user_email)
    content = ""
    address = user_email
    Membership.where(user_email: user_email).each do |membership|
      Task.where(group_id: membership.group_id).each do |task|
        if task.priority == 1
          content << "#{task.title}\n"
        end
      end
      Subtask.where(group_id: membership.group_id).each do |subtask|
        if subtask.priority == 1
          content << "#{subtask.task.title}: #{subtask.title}\n"
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
          content << "#{task.title}\n"
        end
      end
      Subtask.where(group_id: membership.group_id).each do |subtask|
        if subtask.priority == 2
          content << "#{subtask.task.title}: #{subtask.title}\n"
        end
      end
    end
    unless content.empty?
      mail(to: address, subject: "Daily Tasks", body: content)
    end
  end

#priority = 3
  def urgent_email(user_email)
    content = ""
    address = user_email
    Membership.where(user_email: user_email).each do |membership|
      Task.where(group_id: membership.group_id).each do |task|
        if task.priority == 3
          content << "#{task.title}\n"
        end
      end
      Subtask.where(group_id: membership.group_id).each do |subtask|
        if subtask.priority == 3
          content << "#{subtask.task.title}: #{subtask.title}\n"
        end
      end
    end
    unless content.empty?
      mail(to: address, subject: "Urgent Tasks", body: content)
    end
  end
  #ALL EMAIL not filtered by priority
  def all_email(user_email)
    content = ""
    address = user_email
    Membership.where(user_email: user_email).each do |membership|
      Task.where(group_id: membership.group_id).each do |task|
          content << "#{task.title}\n"
      end
      Subtask.where(group_id: membership.group_id).each do |subtask|
          content << "#{subtask.task.title}: #{subtask.title}\n"
      end
    end
    unless content.empty?
      mail(to: address, subject: "Your Tasks", body: content)
    end
  end

  #priority = 3 SMS only!
  def text_notification(user_email)
    content = ""
    address = user_email
    phone = User.where(email: user_email).first.phone
    Membership.where(user_email: user_email).each do |membership|
      Task.where(group_id: membership.group_id).each do |task|
        if task.priority == 3
          content << "#{task.title}\n"
        end
      end
      Subtask.where(group_id: membership.group_id).each do |subtask|
        if subtask.priority == 3
          content << "#{subtask.task.title}: #{subtask.title}\n"
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
  end

end


