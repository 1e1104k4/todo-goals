require "test_helper"

class ReminderMailerTest < ActionMailer::TestCase
  test "goal_reminder" do
    mail = ReminderMailer.goal_reminder
    assert_equal "Goal reminder", mail.subject
    assert_equal [ "to@example.org" ], mail.to
    assert_equal [ "from@example.com" ], mail.from
    assert_match "Hi", mail.body.encoded
  end
end
