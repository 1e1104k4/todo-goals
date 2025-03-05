class ReminderMailer < ApplicationMailer
  default from: "Admin <noreply@example.com>"
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.reminder_mailer.goal_reminder.subject
  #
  def goal_reminder(user, goals)
    @user = user
    @goals = goals

    mail to: @user.email, subject: "Goal Reminder"
  end
end
