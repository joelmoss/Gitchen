require 'spec_helper'

describe User do

  describe "after creation, fetch the watched repos list" do
    it "should call the Github API" do
      HardWorker.should_receive(:perform_async).with(101)
      create(:user, :id => 101)
    end
  end

  describe "#fetch_watched_repos" do
    before(:each) do
      HardWorker.should_receive(:perform_async).with(user.id)
    end

    let(:user) { create(:user) }

    it "should fetch the user's watched repos from Github" do
      stub_get('/users/joelmoss/watched', 'somerandomstring').to_return(:body => fixture("watched"))
      user.fetch_watched_repos
      Watch.count.should == 30
      user.watchings.count == 30
    end
  end

end
