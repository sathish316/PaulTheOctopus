require 'spec_helper'

describe Paul do

  describe "prediction algorithm" do

    before do
      @paul = Paul.new
    end

    it "should choose if two choices are given" do
      chooseion = @paul.send(:choose, "Will i win the lottery? [No Way] [Get Rich or Die Trying]")
      ['No Way', 'Get Rich or Die Trying'].should include(chooseion)
    end

    it "should return 42 if no options are given" do
      @paul.send(:choose, 'Whats the point of life?').should == 42
    end

    it "should return 42 if only one option is given" do
      @paul.send(:choose, 'Am i awesome? [Absolutely]').should == 42
    end

    it "should be optimistic for Yes/No questions" do
      @paul.send(:choose, 'Will she accept the ring? [Yes] [Disappointment]').should == 'Yes'
    end

    it "should choose from multiple options" do
      chooseion = @paul.send(:choose, 'What will i get for Christmas? [XBox] [iPad] [Wii] [PS3]')
      ['XBox','iPad','Wii','PS3'].should include(chooseion)
    end

    it "should return nil if parsed question is nil" do
      @paul.send(:choose, nil).should be_nil
    end

  end
end
