class Subtask < ActiveRecord::Base
  belongs_to :task
  attr_accessible :created_at, :priority, :title
  validates :title, presence: true

  def priority_string
    if :priority == 1
      "High"
    elsif :priority == 2
      "Medium"
    else
      "Low"
    end
  end
end
