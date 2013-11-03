require 'spec_helper'

describe GithubCollector do
  fixtures :accounts

  it { should be_processed_in :critical }
  it { should be_retryable 1 }

  let(:github_collector){ GithubCollector.new }

  before(:all) do
    @user = FactoryGirl.create(:user)
    @integration = FactoryGirl.build(:integration, user: @user, username: 'mscoutermarsh')
    @integration.account = Account.find_by_name("Github")
    @integration.save
  end

  it 'collects all users github events' do
    VCR.use_cassette "github/events" do
      github_collector.perform(@user.id)
    end
  end
  
end
