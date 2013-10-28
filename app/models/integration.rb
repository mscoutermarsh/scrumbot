class Integration < ActiveRecord::Base
  validates :user_id, presence: true, numericality: true
  validates :account_id, presence: true, numericality: true
  validates :access_secret, presence: true
  validates_uniqueness_of :user_id, :scope => [:account_id]

  attr_encrypted :access_secret, :access_token, key: :encryption_key

  belongs_to :user
  belongs_to :account

  include GithubHelper
  include Encryption

end

#     Column     |            Type             |                         Modifiers
# ---------------+-----------------------------+-----------------------------------------------------------
#  id            | integer                     | not null default nextval('integrations_id_seq'::regclass)
#  user_id       | integer                     |
#  account_id    | integer                     |
#  access_token  | character varying(255)      |
#  access_secret | character varying(255)      |
#  created_at    | timestamp without time zone |
#  updated_at    | timestamp without time zone |
#  username      | character varying(255)      |
# Indexes:
#     "integrations_pkey" PRIMARY KEY, btree (id)
#     "index_integrations_on_user_id_and_account_id" btree (user_id, account_id)