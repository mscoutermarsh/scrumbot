require 'spec_helper'

describe ApiKey do
  before(:each) do
    @user = FactoryGirl.create(:user)
  end

  describe 'Associations' do
    it { should belong_to :user }
  end

  describe 'Validations' do
    before (:each) do
      ApiKey.any_instance.stub(:generate_access_token).and_return(true)
    end
    it { should ensure_length_of(:access_token).is_equal_to(32)}
    it { should validate_uniqueness_of :access_token }
  end

  describe '#expired?' do
    it 'returns true if expired' do
      @user.api_key.expires_at = Time.now - 1.hour
      expect(@user.api_key.expired?).to be_true
    end
  end
end
