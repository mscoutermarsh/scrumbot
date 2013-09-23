class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  store_accessor :settings, :skip_weekends, :time_zone

  validates :email, presence: true, uniqueness: true
  validates :skip_weekends, inclusion: { in: [true, false], message: "must be true or false" }
  validates_inclusion_of :time_zone, in: ActiveSupport::TimeZone.zones_map { |m| m.name }, message: "is not a valid Time Zone"

  has_one :api_key
  has_many :integrations
  
  after_initialize :set_default_settings!
  after_create :create_api_key!

  def create_api_key!
    self.api_key = ApiKey.create
    self.save
  end

  def set_default_settings!
    self.skip_weekends = true if skip_weekends.nil?
    self.time_zone ||= 'Eastern Time (US & Canada)'
  end

  # convert to bool. hstore only stores strings
  def skip_weekends
    if %w{true false}.include? super
      super == "true" ? true : false
    else
      super
    end
  end
end
