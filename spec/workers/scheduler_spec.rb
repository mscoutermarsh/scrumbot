require 'spec_helper'

describe Scheduler do
  fixtures :accounts

  it { should be_processed_in :critical }
  it { should be_retryable 1 }

  let(:scheduler){ Scheduler.new }

  describe '#midnight_zones' do
    it "returns time_zones where it's currently midnight" do
      Timecop.freeze("2013-11-04 00:00:00 -0500") do
        expect(scheduler.midnight_zones).to eql ["Eastern Time (US & Canada)", "Indiana (East)", "Bogota", "Lima", "Quito", "Caracas"]
      end

      Timecop.freeze("2013-11-04 00:05:21 -0000") do
        expect(scheduler.midnight_zones).to eql ["UTC", "Dublin", "Edinburgh", "Lisbon", "London", "Casablanca", "Monrovia"]
      end
    end
  end

  describe '#process' do
    before(:all) do
      Timecop.freeze("2013-11-04 00:00:00 -0500")
    end

    before(:each) do
      @user = FactoryGirl.create(:user)
      @integration = FactoryGirl.create(:integration, user: @user,
                                        account: Account.find_by_name("Github"))
    end

    it 'schedules github job' do
      scheduler.perform
      expect(GithubCollector).to have_enqueued_job(@user.id)
    end

    it 'schedules email job' do
      scheduler.perform
      expect(DailyEmail).to have_enqueued_job(@user.id)
    end
    
  end

end