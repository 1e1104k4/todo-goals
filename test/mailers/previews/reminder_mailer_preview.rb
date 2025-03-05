# Preview all emails at http://localhost:3000/rails/mailers/reminder_mailer
class ReminderMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/reminder_mailer/goal_reminder
  def goal_reminder
    ReminderMailer.goal_reminder
  end
end
