class ApiKey < ActiveRecord::Base
  before_create :generate_access_token
  belongs_to :user

  def expired?
   DateTime.now >= self.expires
  end

  private
    def generate_access_token
      begin
        self.key = SecureRandom.hex
      end while self.class.exists?(key: key)
    end
  
end
