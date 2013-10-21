require 'spec_helper'

describe Integration do

  describe 'Validations' do
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :account_id }
    it { should validate_presence_of :access_secret }
    it { should validate_uniqueness_of(:user_id).scoped_to(:account_id) }
  end

  describe 'Associations' do
    it { should belong_to :user }
    it { should belong_to :account }
  end

  describe 'Github' do
    before(:each) do
      @integration = FactoryGirl.build(:integration)
      @integration.account = Account.find_by_name("Github")
    end
    describe '#github?' do
      it 'returns true for github' do
        expect(@integration.github?).to be_true
      end
      it 'returns false for non-github' do
        @integration.account = FactoryGirl.create(:account)
        expect(@integration.github?).to be_false
      end
    end

    describe '#github_login' do
      it 'returns Github object with token set' do
        expect(@integration.github_login.oauth_token).to eql @integration.access_secret
      end
    end
  end
end
