require 'spec_helper'

describe User do

  describe "after creation, fetch the watched repos list" do
    it "should call the Github API" do
      HardWorker.should_receive(:perform_async).with(101)
      create(:user, :id => 101)
    end
  end

  describe "#fetch_watched_repos" do
    it "should fetch the users watched repos from Github" do
      stub_get('/users/joelmoss/watched', 'somerandomstring').to_return(:body => fixture("watched"))
      mark create(:user).fetch_watched_repos.size
    end
  end

end
