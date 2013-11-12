require 'spec_helper'

describe GithubCollector do

  it { should be_processed_in :critical }
  it { should be_retryable 1 }


  before(:all) do
    Timecop.freeze(DateTime.parse('Sun, 03 Nov 2013 13:55:40 -0500')) 
  end

  before(:each) do
    # Redis.current.flushdb
    @user = FactoryGirl.create(:user)
    @integration = FactoryGirl.create(:integration, 
                                      user: @user,
                                      account: Account.find_by_name("Github"),
                                      token: 'ABC123',
                                      username: 'mscoutermarsh')
  end

  context 'user has less than 30 events', vcr: { cassette_name: 'github/events_1_page' } do

    subject(:events) do
      GithubCollector.new.perform(@user.id)
      JSON.parse(@user.integrations.github.todays_events)
    end

    describe 'result' do

      it 'has 4 events' do
        expect(events.size).to eql 4
      end

      it 'has 4 commit events' do
        events.select! { |e| e['type'] == 'Commit'}
        expect(events.size).to eql 4
      end

      it 'has 0 pull request events' do
        events.select! { |e| e['type'] == 'Pull Request'}
        expect(events.size).to eql 0
      end

    end

  end

  context 'user has more than 30 events', vcr: { cassette_name: 'github/events_2_pages' }  do

    subject(:events) do
      GithubCollector.new.perform(@user.id)
      JSON.parse(@user.integrations.github.todays_events)
    end

    describe 'result' do

      it 'has 17 events' do
        expect(events.size).to eql 17
      end

      it 'has 11 commit events' do
        events.select! { |e| e['type'] == 'Commit'}
        expect(events.size).to eql 11
      end

      it 'has 6 pull request events' do
        events.select! { |e| e['type'] == 'Pull Request'}
        expect(events.size).to eql 6
      end

      it 'has 3 open pull request events' do
        events.select! { |e| e['type'] == 'Pull Request' && e['action'] == 'opened'}
        expect(events.size).to eql 3
      end

      it 'has 3 closed pull request events' do
        events.select! { |e| e['type'] == 'Pull Request' && e['action'] == 'closed'}
        expect(events.size).to eql 3
      end

    end

    describe 'pull request' do
      subject(:pull_request) { events.find { |e| e['type'] == 'Pull Request'} }

      it 'has correct type' do
        expect(pull_request['type']).to eql 'Pull Request'
      end

      it 'has an action' do
        expect(['closed','opened']).to include pull_request['action']
      end

      it 'has a title' do
        expect(pull_request['title']).to_not be_nil
      end

      it 'has a link' do
        expect(pull_request['link']).to_not be_nil
      end

      it 'has a repo name' do
        expect(pull_request['repo_name']).to_not be_nil
      end

      it 'has a valid time' do
        expect(pull_request['time']).to_not be_nil
        expect{ DateTime.parse(pull_request['time']) }.to_not raise_error
      end

    end

    describe 'commit' do
      subject(:commit) { events.find { |e| e['type'] == 'Commit'} }

      it 'has correct type' do
        expect(commit['type']).to eql 'Commit'
      end

      it 'has a description' do
        expect(commit['description']).to_not be_nil
      end

      it 'has a link' do
        expect(commit['link']).to_not be_nil
      end

      it 'has a repo name' do
        expect(commit['repo_name']).to_not be_nil
      end

      it 'has a valid time' do
        expect(commit['time']).to_not be_nil
        expect{ DateTime.parse(commit['time']) }.to_not raise_error
      end

    end

  end
  
end