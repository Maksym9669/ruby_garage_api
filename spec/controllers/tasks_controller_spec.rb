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

task_arr_schema = {
    "type" => "object",
    "required" => ["data"],
    "properties" => {
      "data" => {"type" => "array", "items": {
        "type" => "object", "properties" =>{
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
          }
      }}
    }
}


RSpec.describe Api::TasksController, :type => :controller do

    describe "GET index" do
    
        login_user
    
        it "Has a 200 status code" do
          project = create(:project, user_id: 14)
          task = create(:task, project_id: 13)
          get :index, :params =>  { project_id: 13 }
          expect(response.status).to eq(200)
        end
    

        it "Response match the schema" do
          project = create(:project, user_id: 15)
          task = create(:task, project_id: 14)
          get :index, :params =>  { project_id: 13 }
          expect(JSON::Validator.validate(task_arr_schema, JSON.parse(response.body))).to eq(true)
        end
    end


     describe "GET show" do
    
        login_user
    
        it "Has a 200 status code" do
          project = create(:project, user_id: 16)
          task = create(:task, project_id: 15)
          get :show, :params =>  { project_id: 15, id: 3 }
          expect(response.status).to eq(200)
        end
    

        it "Has a 404 status code" do
            project = create(:project, user_id: 17)
            task = create(:task, project_id: 16)
            get :show, :params =>  { project_id: 16, id: 5 } # 4
            expect(response.status).to eq(404)
        end
    end

    describe "POST create" do
    
        login_user
    
        it "Has a 201 status code" do
          project = create(:project, user_id: 18)
          post :create, :params =>  { project_id: 17, name: "Task1", status: "active" }
          expect(response.status).to eq(201)
        end
    

        it "Has a 400 status code" do
            project = create(:project, user_id: 19)
            post :create, :params =>  { project_id: 18, name: "Task2", status: "random_string" }
            expect(response.status).to eq(400)
        end
    end

    describe "PUT update" do
    
        login_user
    
       
        it "Has a 200 status code" do
            project = create(:project, user_id: 20)
            task = create(:task, project_id: 19)
            put :update, :params =>  { project_id: 19, id: 6 }
            expect(response.status).to eq(200)
        end
    
        
        it "Has status updated" do
            project = create(:project, user_id: 21)
            task = create(:task, project_id: 20)
            put :update, :params =>  { project_id: 20, id: 7, status: "done" }
            expect(JSON.parse(response.body)["data"]["status"]).to eq("done")
        end

        it "Response match the schema" do
            project = create(:project, user_id: 22)
            task = create(:task, project_id: 21)
            put :update, :params =>  { project_id: 21, id: 8 }
            expect(JSON::Validator.validate(task_schema, JSON.parse(response.body))).to eq(true)
        end
    end

    describe "DELETE destroy" do
    
        login_user
    
        it "Has a 200 status code" do
          project = create(:project, user_id: 23)
          task = create(:task, project_id: 22)
          delete :destroy, :params =>  { project_id: 22, id: 9 }
          expect(response.status).to eq(200) # Why deleted?
        end
    
        # it "Has a 400 status code" do
        #   project = create(:project, user_id: 24)
        #   task = create(:task, project_id: 23)
        #   delete :destroy, :params =>  { project_id: 23, id: 11 } # 10
        #   expect(response.status).to eq(404)
        # end
    end
end