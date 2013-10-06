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

#     Column    |            Type             |                       Modifiers
# --------------+-----------------------------+-------------------------------------------------------
#  id           | integer                     | not null default nextval('api_keys_id_seq'::regclass)
#  user_id      | integer                     |
#  access_token | character varying(255)      |
#  expires_at   | timestamp without time zone |
#  created_at   | timestamp without time zone |
#  updated_at   | timestamp without time zone |
# Indexes:
#     "api_keys_pkey" PRIMARY KEY, btree (id)
#     "index_api_keys_on_access_token" btree (access_token)
#     "index_api_keys_on_user_id" btree (user_id)
