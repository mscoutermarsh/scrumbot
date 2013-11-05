require 'spec_helper'

describe DataCollector do

  it { should be_processed_in :critical }
  it { should be_retryable 1 }

  let(:data_collector){ DataCollector.new }

  describe '#collect_events' do
    it 'raises error if not overridden' do
      expect{ data_collector.collect_events }.to raise_error
    end
  end

  describe '#integration' do
    it 'raises error if not overridden' do
      expect{ data_collector.integration }.to raise_error
    end
  end
  
end
