require 'spec_helper'

describe GithubCollector, vcr: true do

  it { should be_processed_in :critical }
  it { should be_retryable 1 }


  before(:all) do
    Timecop.freeze(DateTime.parse('Sun, 03 Nov 2013 13:55:40 -0500')) 
  end

  before(:each) do
    $redis.flushdb
    @user = FactoryGirl.create(:user)
    @integration = FactoryGirl.create(:integration, 
                                      user: @user,
                                      account: Account.find_by_name("Github"),
                                      token: 'ABC123',
                                      username: 'mscoutermarsh')
  end

  subject { GithubCollector.new }

  context 'user has less than 30 events' do
    use_vcr_cassette 'github/events_1_page'

    it 'saves results to redis' do
      subject.perform(@user.id)
      expect($redis.get("2013-11-03-#{@user.id}-Github")).to be_an_instance_of(String)
    end

  end

  context 'user has more than 30 events' do
    use_vcr_cassette "github/events_2_pages"

    it 'saves results to redis' do
      subject.perform(@user.id)
      expect($redis.get("2013-11-03-#{@user.id}-Github")).to be_an_instance_of(String)
    end
  end
  
end