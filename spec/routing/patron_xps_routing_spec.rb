require "spec_helper"

describe PatronXpsController do
  describe "routing" do

    it "routes to #index" do
      get("/patron_xps").should route_to("patron_xps#index")
    end

    it "routes to #new" do
      get("/patron_xps/new").should route_to("patron_xps#new")
    end

    it "routes to #show" do
      get("/patron_xps/1").should route_to("patron_xps#show", :id => "1")
    end

    it "routes to #edit" do
      get("/patron_xps/1/edit").should route_to("patron_xps#edit", :id => "1")
    end

    it "routes to #create" do
      post("/patron_xps").should route_to("patron_xps#create")
    end

    it "routes to #update" do
      put("/patron_xps/1").should route_to("patron_xps#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/patron_xps/1").should route_to("patron_xps#destroy", :id => "1")
    end

  end
end
