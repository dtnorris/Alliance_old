require 'spec_helper'

describe "PatronXps" do
  describe "GET /patron_xps" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get patron_xps_path
      response.status.should be(200)
    end
  end
end
