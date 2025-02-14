class Goal < ApplicationRecord
  belongs_to :user

  validates :title, presence: true

  enum :status, %i[ not_started in_process completed ]

  def next_status
    case status
    when "not_started"
      "in_process"
    when "in_process"
      "completed"
    when "completed"
      "not_started"
    else
      logger.error("Unexpected status: #{status}")
    end
  end
end
