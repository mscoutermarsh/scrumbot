require 'spec_helper'

describe GithubCollector do

  it { should be_processed_in :critical }
  it { should be_retryable 1 }

  let(:github_collector){ GithubCollector.new }

  
  
end
