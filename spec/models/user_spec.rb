require 'spec_helper'

describe User do

  describe 'Validations' do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :password }
    it { should ensure_length_of(:password).is_at_least(6) }
    it { should ensure_inclusion_of(:skip_weekends).in_array(['true','false']) }
    it { should ensure_inclusion_of(:tweet).in_array(['true','false']) }
    
    it { should allow_value(true).for(:active) }
    it { should allow_value(false).for(:active) }
    it { should_not allow_value(nil).for(:active) }

    it { should allow_value(true).for(:admin) }
    it { should allow_value(false).for(:admin) }
    it { should_not allow_value(nil).for(:admin) }

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

  describe '#active?' do
    it 'returns true for default user' do
      user = FactoryGirl.build(:user)
      expect(user.active?).to eql true 
    end

    it 'returns false for inactive user' do
      user = FactoryGirl.build(:user, active: false)
      expect(user.active?).to eql false 
    end
  end

  describe '#tweet?' do
    it 'returns false for default user' do
      user = FactoryGirl.build(:user)
      expect(user.tweet?).to eql false 
    end

    it 'returns true if setting on' do
      user = FactoryGirl.build(:user, tweet: 'true')
      expect(user.tweet?).to eql true 
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
    before(:each) do
      @user = FactoryGirl.create(:user) 
      account = Account.find_by_name('Github')
      @user.create_or_update_github_account!('capitals','abc123')
    end

    it 'creates new github integration' do 
      expect(@user.integrations.count).to eql 1
    end

    it 'sets correct attributes' do
      expect(@user.integrations.first.account.name).to eql 'Github'
      expect(@user.integrations.first.token).to eql 'abc123'
      expect(@user.integrations.first.token).to eql 'abc123'
    end

  end

  describe '#create_or_update_twitter_account!' do
    before(:each) do
      @user = FactoryGirl.create(:user) 
      account = Account.find_by_name('Twitter')
      @user.create_or_update_twitter_account!('mscccc','capitals','abc123')
    end

    it 'creates new twitter integration' do 
      expect(@user.integrations.count).to eql 1
    end

    it 'sets correct attributes' do
      expect(@user.integrations.first.account.name).to eql 'Twitter'
      expect(@user.integrations.first.token).to eql 'capitals'
      expect(@user.integrations.first.username).to eql 'mscccc'
      expect(@user.integrations.first.secret).to eql 'abc123'
    end
  end

  describe '#unsubscribe_token' do
    before(:each) do
      @user = FactoryGirl.build(:user, id: 1) 
    end

    it 'returns a token' do
      expect(@user.unsubscribe_token).to_not be_nil
      expect(@user.unsubscribe_token.length).to be > 10
    end
  end

  describe '#find_by_unsubscribe_token' do
    before(:each) do
      @user = FactoryGirl.create(:user) 
      @token = @user.unsubscribe_token
    end

    it 'returns correct user' do
      expect(User.find_by_unsubscribe_token(@token)).to eql @user
    end

  end

end
