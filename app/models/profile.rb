class Profile < ActiveRecord::Base
  attr_accessible :about, :name, :phone, :user_id
  belongs_to :user
  before_validation phony_normalize(:phone, default_country_code: 'US')
  validates :phone, phony_plausible: true
end
