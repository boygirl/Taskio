class Task < ActiveRecord::Base
  attr_accessible :created_at, :priority,
                  :title
  validates :title, presence: true

  has_many :subtasks

  belongs_to :group

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
