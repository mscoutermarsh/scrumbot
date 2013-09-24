require 'spec_helper'

describe User do
  before(:each) do
    @user = FactoryGirl.create(:user)
  end 

  describe 'Validations' do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :password }
    it { should ensure_length_of(:password).is_at_least(8) }
    it { should ensure_inclusion_of(:skip_weekends).in_array(['true','false']) }
    it { should ensure_inclusion_of(:time_zone).in_array(ActiveSupport::TimeZone.all.map(&:name)) }
  end

  describe 'Associations' do
    it { should have_one :api_key }
    it { should have_many :integrations }
  end

  describe 'Api Key' do
    it 'has API key on create' do
      user = FactoryGirl.build(:user)
      user.should_receive(:create_api_key!)
      user.save
      expect(@user.api_key).to_not be_nil
    end
  end

  describe '.skip_weekends?' do
    it 'return false' do
      @user.settings[:skip_weekends] = "false"
      @user.save
      expect(@user.skip_weekends?).to be_false
    end
    it 'return true' do
      @user.settings[:skip_weekends] = "true"
      @user.save
      expect(@user.skip_weekends?).to be_true
    end
  end
end
