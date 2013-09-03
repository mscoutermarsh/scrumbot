require 'spec_helper'

describe Integration do
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :account_id }
  it { should validate_presence_of :access_token }
  it { should validate_presence_of :access_secret }
  it { should validate_uniqueness_of :user_id }

end
