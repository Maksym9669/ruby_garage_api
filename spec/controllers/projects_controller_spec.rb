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

RSpec.describe Api::ProjectsController, :type => :controller do
  describe "GET index" do
    login_user

    it "has a 200 status code" do
      get :index
      expect(response.status).to eq(200)
    end

    it "has a 200 status code" do
      get :index
      expect(JSON::Validator.validate(user_schema, JSON.parse(response.body))).to eq(true)
    end
  end
end