class Account < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_many :integrations
end

#    Column   |            Type             |                       Modifiers
# ------------+-----------------------------+-------------------------------------------------------
#  id         | integer                     | not null default nextval('accounts_id_seq'::regclass)
#  name       | character varying(255)      |
#  created_at | timestamp without time zone |
#  updated_at | timestamp without time zone |
# Indexes:
#     "accounts_pkey" PRIMARY KEY, btree (id)
#     "index_accounts_on_name" UNIQUE, btree (name)