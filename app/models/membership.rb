class Membership < ActiveRecord::Base
  attr_accessible :user_id, :group_id, :email, :name, :phone
  belongs_to :user
  belongs_to :group

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  # validates :email, uniqueness: true
  before_validation phony_normalize(:phone, default_country_code: 'US')
  validates :phone, phony_plausible: true
  after_create :invite_unknown_users

  private

  def invite_unknown_users
    unless User.find_by_email(self.email)
      User.invite!(email: self.email)
    end
  end
end
