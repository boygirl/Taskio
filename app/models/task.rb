class Task < ActiveRecord::Base
  attr_accessible :created_at, :priority,
                  :title
  validates :title, presence: true

  has_many :subtasks

  belongs_to :group

  def priority_string
    if self.priority == 1
      "Low"
    elsif self.priority == 2
      "Medium"
    elsif self.priority == 3
      "High"
    else
      "unset"
    end
  end
end
