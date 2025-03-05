class SendReminderJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    # Do something later
    puts "Sending reminder email to user #{user_id}"
    user = User.find(user_id)
    goals = user.goals.where(status: ["not_started", "in_process"])
    if goals.any?
      ReminderMailer.goal_reminder(user, goals).deliver_now
      Rails.logger.info "Reminder email sent to #{user.email} for #{goals.count} goals"
    else
      logger.error "Could not send reminder email - User ID: #{user_id}"
    end
  end
end
