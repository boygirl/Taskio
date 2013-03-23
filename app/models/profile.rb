class Profile < ActiveRecord::Base
  attr_accessible :about, :name, :phone, :user_id
  belongs_to :user
end
