require "spec_helper"

describe SuperDuperConfig do

  module MyConfig; extend SuperDuperConfig; end

  before(:each) { MyConfig.reset! }

  describe ".configuration" do
    it "should return a hash of all settings" do
      MyConfig.configuration.should == {}
    end
  end

  describe "resetting" do
    before(:each) do
      MyConfig.configure do
        first_name 'Joel'
        last_name 'Moss'
      end
    end

    it "should reset the configuration Hash" do
      MyConfig.configuration.to_hash.should == {'first_name' => "Joel", 'last_name' => "Moss"}
      MyConfig.reset!
      MyConfig.configuration.to_hash.should == {}
    end

    context "when configure is given a :reset key" do
      it "should reset the configuration Hash" do
        MyConfig.configuration.to_hash.should == {'first_name' => "Joel", 'last_name' => "Moss"}
        MyConfig.configure :reset => true do
          first_name 'Just Bob'
        end
        MyConfig.configuration.to_hash.should == {'first_name' => "Just Bob"}
      end
    end
  end

  context "Defining configuration from a file" do
    before :each do
      MyConfig.configure :from_file => File.dirname(__FILE__) + '/../support/config_test.yml'
    end

    describe ".configuration" do
      it "should return a Hash of configuration variables" do
        MyConfig.configuration.to_hash.should == {'first_name' => "Joel (T)", 'last_name' => "Moss (T)"}
      end
    end

    describe "accessing config variables via method call" do
      it { MyConfig.first_name.should == 'Joel (T)' }
      it { MyConfig.last_name.should == 'Moss (T)' }
      it { MyConfig.middle_name.should == nil }
    end
  end

  context "Defining configuration via .configure block" do
    before :each do
      MyConfig.configure do
        first_name 'Joel'
        last_name 'Moss'
      end
    end

    describe ".configuration" do
      it "should return a Hash of configuration variables" do
        MyConfig.configuration.to_hash.should == {'first_name' => "Joel", 'last_name' => "Moss"}
      end
    end

    describe "accessing config variables via method call" do
      it { MyConfig.first_name.should == 'Joel' }
      it { MyConfig.last_name.should == 'Moss' }
      it { MyConfig.middle_name.should == nil }
    end
  end

  context "Defining configuration via key= method" do
    before :each do
      MyConfig.first_name = 'Joel'
      MyConfig.last_name = 'Moss'
    end

    describe ".configuration" do
      it "should return a Hash of configuration variables" do
        MyConfig.configuration.to_hash.should == {'first_name' => "Joel", 'last_name' => "Moss"}
      end
    end

    describe "accessing config variables via method call" do
      it { MyConfig.first_name.should == 'Joel' }
      it { MyConfig.last_name.should == 'Moss' }
      it { MyConfig.middle_name.should == nil }
    end
  end

end