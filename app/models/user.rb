class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  store_accessor :settings, :skip_weekends

  validates :email, uniqueness: true
  validates :skip_weekends, inclusion: { in: ['true', 'false'], message: "must be true or false" }
  validates_inclusion_of :time_zone, in: ActiveSupport::TimeZone.zones_map { |m| m.name }, message: "is not a valid Time Zone"
  validates_inclusion_of :admin, in: [true, false], message: "must be true or false"
  validates_inclusion_of :active, in: [true, false], message: "must be true or false"

  has_one :api_key
  has_many :integrations
  
  after_initialize :set_default_settings!
  after_create :create_api_key!

  scope :active, -> { where(active: true) }

  def create_or_update_github_account!(username, token)
    account = Account.find_by_name('Github')
    integration = integrations.find_or_create_by(account: account)
    integration.update_attributes(token: token, username: username)
  end

  def todays_events
    user.integrations.each do |integration|
      key = "#{current_time.to_date}-#{self.id}-#{integration.account.name}"
      events["#{integration.account.name}"] = $redis.get(key) if $redis.get(key)
    end
  end

  def current_time
    Time.now.in_time_zone(time_zone)
  end

  def admin?
    admin
  end

  def active?
    active
  end

  def create_api_key!
    self.api_key = ApiKey.create
  end

  def set_default_settings!
    self.skip_weekends = 'true' if skip_weekends.nil?
    self.time_zone ||= 'Eastern Time (US & Canada)'
  end

  def skip_weekends?
    skip_weekends == "true" ? true : false
  end
end

# psql scrumlogs_development
#  -- describe table:
# \d users

#          Column         |            Type             |                     Modifiers
# ------------------------+-----------------------------+----------------------------------------------------
#  id                     | integer                     | not null default nextval('users_id_seq'::regclass)
#  email                  | character varying(255)      | not null default ''::character varying
#  encrypted_password     | character varying(255)      | not null default ''::character varying
#  reset_password_token   | character varying(255)      |
#  reset_password_sent_at | timestamp without time zone |
#  remember_created_at    | timestamp without time zone |
#  sign_in_count          | integer                     | default 0
#  current_sign_in_at     | timestamp without time zone |
#  last_sign_in_at        | timestamp without time zone |
#  current_sign_in_ip     | character varying(255)      |
#  last_sign_in_ip        | character varying(255)      |
#  created_at             | timestamp without time zone |
#  updated_at             | timestamp without time zone |
#  settings               | hstore                      |
#  first_name             | character varying(255)      |
#  last_name              | character varying(255)      |
#  admin                  | boolean                     | default false
#  active                 | boolean                     | default true
#  time_zone              | character varying(255)      |
# Indexes:
#     "users_pkey" PRIMARY KEY, btree (id)
#     "index_users_on_email" UNIQUE, btree (email)
#     "index_users_on_reset_password_token" UNIQUE, btree (reset_password_token)
#     "index_users_on_active" btree (active)
#     "index_users_on_time_zone" btree (time_zone)
