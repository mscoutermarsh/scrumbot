class ApiKey < ActiveRecord::Base
  before_validation :generate_access_token
  belongs_to :user

  validates :access_token, presence: true, uniqueness: true
  validates :access_token, length: { is: 32 }

  def expired?
    expires_at.nil? ? false : DateTime.now >= expires_at
  end

  def expire!
    update_attributes!(expires_at: DateTime.now)
  end

  private
    def generate_access_token
      self.access_token = loop do
        random_token = SecureRandom.hex
        break random_token unless ApiKey.where(access_token: random_token).exists?
      end
    end
  
end
