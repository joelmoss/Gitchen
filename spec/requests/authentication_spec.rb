require 'spec_helper'

describe "Authentication" do

  context "on successful sign in" do
    before(:each) do
      OmniAuth.config.mock_auth[:github] = { credentials: { token: "somerandomstring" },
                                             extra: {
                                             raw_info: {
                                             login: "joelmoss" } } }
    end

    it "should create a new User record" do
      HardWorker.should_receive(:perform_async)

      get "/auth/github"
      follow_redirect!

      User.should have(1).record
      session[:user_id].should == User.first.id
    end

    context "when user record already exists" do
      it "should use the existing record" do
        user = build_stubbed(:user)
        OmniAuth.config.mock_auth[:github][:extra][:raw_info][:login] = user.username
        attrs = { github_data: {login: user.username}, github_access_token: "somerandomstring" }
        User.should_receive(:find_or_create_by_username).with(user.username, attrs).and_return(user)
        user.should_receive(:update_attributes)
        HardWorker.should_receive(:perform_async)

        get "/auth/github"
        follow_redirect!
        session[:user_id].should == user.id
      end
    end
  end

  context "on unsuccessful sign in" do
    it "does something" do
      OmniAuth.config.mock_auth[:github] = :invalid_credentials

      get "/auth/github"
      follow_redirect!
      session[:user_id].should be_nil
      response.should redirect_to('/auth/failure?message=invalid_credentials')
    end
  end

end
