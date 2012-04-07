require 'spec_helper'

describe User do

  let(:user) { create(:user) }

  describe "#fetch_watched_repos" do
    it "should fetch the user's watched repos from Github" do
      stub_get('/users/joelmoss/watched', 'somerandomstring').to_return(:body => fixture("watched"))

      user.fetch_watched_repos

      Watch.count.should == 30
      user.watchings.count == 30
    end
  end

  describe "#prune_unwatched_repos" do
    it "should prune repos that are no longer being watched" do
      stub_get('/users/joelmoss/watched', 'somerandomstring').to_return(:body => fixture("watched"))
      user.fetch_watched_repos

      user.instance_variable_set("@github_watched", nil)

      stub_get('/users/joelmoss/watched', 'somerandomstring').to_return(:body => fixture("unwatched"))
      user.prune_unwatched_repos

      Watch.count.should == 29
      user.watchings.count == 29
    end
  end

end
