class Integration < ActiveRecord::Base
  validates :user_id, presence: true, numericality: true
  validates :account_id, presence: true, numericality: true
  validates :access_token, presence: true
  validates :access_secret, presence: true
  validates_uniqueness_of :user_id, :scope => [:account_id]

  belongs_to :user

end
