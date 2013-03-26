class Group < ActiveRecord::Base
  attr_accessible  :name
  validates :name, :presence => true
  has_many :memberships
  has_many :users, through: :memberships
  has_many :tasks
end
