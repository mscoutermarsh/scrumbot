require 'spec_helper'

describe DataCollector do

  it { should be_processed_in :critical }
  it { should be_retryable 1 }

  let(:data_collector){ DataCollector.new }
  
end
