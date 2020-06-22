require "rails_helper"
require_relative "../support/devise"
require "json-schema"

task_schema = {
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
        "project_id" => { "type" => "integer"},
        "status" => {"type" => "string"},
        "priority" => { "type" => "integer" }
      }}
    }
}

RSpec.describe Api::TasksDoneController, :type => :controller do
    describe "GET update" do
    
        login_user
    
       
        it "Has a 200 status code" do
            project = create(:project, user_id: 27)
            task = create(:task, project_id: 26)
            get :update, :params =>  { project_id: 26, id: 13 }
            expect(response.status).to eq(200)
        end
    
        
        it "Has status updated" do
            project = create(:project, user_id: 28)
            task = create(:task, project_id: 27)
            put :update, :params =>  { project_id: 27, id: 14, status: "done" }
            expect(JSON.parse(response.body)["data"]["status"]).to eq("done")
        end

        it "Response match the schema" do
            project = create(:project, user_id: 29)
            task = create(:task, project_id: 28)
            put :update, :params =>  { project_id: 28, id: 15 }
            expect(JSON::Validator.validate(task_schema, JSON.parse(response.body))).to eq(true)
        end

        
        it "Has a 404 status code" do
            project = create(:project, user_id: 30)
            task = create(:task, project_id: 29)
            put :update, :params =>  { project_id: 29, id: 21 } # 16
            expect(response.status).to eq(404)
        end
    end
end