require 'spec_helper'

describe DailyEmail do

  it { should be_processed_in :email }
  it { should be_retryable 1 }

  let(:email){ DailyEmail.new }

  describe '#clear_user_data' do
    it 'flushes user data from redis' do
    end
  end

  describe '#get_github_events' do
    it 'loads users github events from redis' do
    end
  end
  
end
