require 'spec_helper'

describe User do

  describe "#fetch_watched_repos" do
    let(:user) { create(:user) }

    it "should fetch the user's watched repos from Github" do
      stub_get('/users/joelmoss/watched', 'somerandomstring').to_return(:body => fixture("watched"))
      user.fetch_watched_repos

      Watch.count.should == 30
      user.watchings.count == 30
    end
  end

end
