class ApiKey < ActiveRecord::Base
  before_create :generate_access_token
  belongs_to :user

  def expired?
    DateTime.now >= expires_at
  end

  private
    def generate_access_token
      begin
        key = SecureRandom.hex
      end while self.class.exists?(access_token: key)
    end
  
end
