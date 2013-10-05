require 'spec_helper'

describe Account do
  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
  end

  describe 'Associations' do
    it { should have_many :integrations }
  end
end
