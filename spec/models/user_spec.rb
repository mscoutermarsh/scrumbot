require 'spec_helper'

describe User do

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
      user = FactoryGirl.create(:user)
      expect(user.api_key).to_not be_nil
    end
  end

  describe '#admin?' do
    it 'returns true for admin' do
      user = FactoryGirl.build(:user, admin: true)
      expect(user.admin?).to eql true 
    end

    it 'returns false for default user' do
      user = FactoryGirl.build(:user)
      expect(user.admin?).to eql false 
    end
  end

  describe '#skip_weekends?' do

    before(:each) do
      @user = FactoryGirl.create(:user) 
    end

    it 'returns false' do
      @user.settings[:skip_weekends] = "false"
      @user.save
      expect(@user.skip_weekends?).to be_false
    end
    it 'returns true' do
      @user.settings[:skip_weekends] = "true"
      @user.save
      expect(@user.skip_weekends?).to be_true
    end

  end

  describe '#create_or_update_github_account!' do
    before(:all) do
      @user = FactoryGirl.create(:user) 
      account = FactoryGirl.create(:account, name: 'Github')
      @user.create_or_update_github_account!('capitals','abc123')
    end

    it 'creates new github integration' do 
      expect(@user.integrations.count).to eql 1
    end

    it 'sets correct account' do
      expect(@user.integrations.first.account.name).to eql 'Github'
    end

    it 'sets correct token' do
      expect(@user.integrations.first.access_secret).to eql 'abc123'
    end

  end
end
