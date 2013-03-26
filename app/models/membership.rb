class Membership < ActiveRecord::Base
  attr_accessible :user_id, :group_id, :user_email
  belongs_to :user
  belongs_to :group

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :user_email, presence: true, format: { with: VALID_EMAIL_REGEX }
  after_create :invite_unknown_users

  private

  def invite_unknown_users
    unless User.find_by_email(self.user_email)
      User.invite!(email: self.user_email)
    end
  end
end
