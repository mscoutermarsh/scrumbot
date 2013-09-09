class User < ActiveRecord::Base
  store_accessor :settings

  validates :email, presence: true, uniqueness: true

  has_one :api_key

  after_create :create_api_key

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  private

    def create_api_key
      ApiKey.create(user: self)
    end
end
