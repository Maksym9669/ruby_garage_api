require "rails_helper"
require_relative "../support/devise"
require "json-schema"

user_schema = {
  "type" => "object",
  "required" => ["data", "user"],
  "properties" => {
    "data" => {"type" => "array"},
    "user" => {
      "type" => "object",
      "properties" => {
        "id" => {
          "type" => "integer"
        },
        "email" => {
          "type" => "string"
        }
      }
    }
  }
}

project_schema = {
  "type" => "object",
  "required" => ["data"],
  "properties" => {
    "data" => {"type" => "object", "properties" =>{
      "created_at" => {
        "type" => "string"
      },
      "updated_at" => {
        "type" => "string"
      },
      "name" => {"type" => "string"},
      "id" => { "type" => "integer"},
      "user_id" => { "type" => "integer"}
    }}
  }
}

RSpec.describe Api::ProjectsController, :type => :controller do

  describe "GET index" do
    
    login_user

    it "Has a 200 status code" do
      get :index
      expect(response.status).to eq(200)
    end

    it "Receives associated project on index" do
      project = create(:project, user_id: 3)
      get :index
      expect(project[:user_id]).to eq(3)
      expect(JSON.parse(response.body)["data"].first["name"]).to eq("MyString")
    end

    it "Response match the schema" do
      get :index
      expect(JSON::Validator.validate(user_schema, JSON.parse(response.body))).to eq(true)
    end
  end

  describe "GET show" do
    
    login_user

    it "Has a 200 status code" do
      project = create(:project, user_id: 5)
      get :show, :params =>  { id: 3  }
      expect(response.status).to eq(200)
    end

    it "Response match the schema" do
      project = create(:project, user_id: 6)
      get :show, :params =>  { id: 4  }
      expect(JSON::Validator.validate(project_schema, JSON.parse(response.body))).to eq(true)
    end

    it "Has a 404 status code" do
      project = create(:project, user_id: 7)
      get :show, :params =>  { id: 11  }
      expect(response.status).to eq(404)
    end
  end

  
  describe "PUT update" do
    
    login_user

    it "Has a 200 status code" do
      project = create(:project, user_id: 8)
      put :update, :params =>  { id: 6 }
      expect(response.status).to eq(200)
    end

   
    it "Has name updated" do
      project = create(:project, user_id: 9)
      put :update, :params =>  { id: 7, name: "Project1" }
      expect(JSON.parse(response.body)["data"]["name"]).to eq("Project1")
    end

    it "Has a 404 status code" do
      project = create(:project, user_id: 10)
      get :update, :params =>  { id: 21  }
      expect(response.status).to eq(404)
    end
  end

  describe "POST create" do
    
    login_user

    it "Has a 201 status code" do
      project = create(:project, user_id: 11)
      post :create, :params =>  { name: "Project123" }
      expect(response.status).to eq(201)
    end

    it "Has a 400 status code" do
      project = create(:project, user_id: 12)
      post :create, :params =>  { fruit: "apple" }
      expect(response.status).to eq(400)
    end
  end

  describe "DELETE destroy" do
    
    login_user

    it "Has a 200 status code" do
      project = create(:project, user_id: 13)
      delete :destroy, :params =>  { id: 12 }
      expect(response.status).to eq(200)
    end

    it "Has a 400 status code" do
      project = create(:project, user_id: 14)
      delete :destroy, :params =>  { id: 21 }
      expect(response.status).to eq(404)
    end
  end
end