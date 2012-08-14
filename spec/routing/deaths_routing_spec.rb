require "spec_helper"

describe DeathsController do
  describe "routing" do

    it "routes to #index" do
      get("/characters/1/deaths").should route_to("deaths#index", :character_id => "1")
    end

    it "routes to #new" do
      get("/characters/1/deaths/new").should route_to("deaths#new", :character_id => "1")
    end

    it "routes to #show" do
      get("/characters/1/deaths/1").should route_to("deaths#show", :id => "1", :character_id => "1")
    end

    it "routes to #edit" do
      get("/characters/1/deaths/1/edit").should route_to("deaths#edit", :id => "1", :character_id => "1")
    end

    it "routes to #create" do
      post("/characters/1/deaths").should route_to("deaths#create", :character_id => "1")
    end

    it "routes to #update" do
      put("/characters/1/deaths/1").should route_to("deaths#update", :id => "1", :character_id => "1")
    end

    it "routes to #destroy" do
      delete("/characters/1/deaths/1").should route_to("deaths#destroy", :id => "1", :character_id => "1")
    end

  end
end
