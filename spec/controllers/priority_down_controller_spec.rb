require "rails_helper"
require_relative "../support/devise"
require "json-schema"

RSpec.describe Api::PriorityDownController, :type => :controller do
    describe "GET update" do
    
        login_user
    
       
        it "Has a 400 status code" do
            project = create(:project, user_id: 1)
            task = create(:task, project_id: 1)
            get :update, :params =>  { project_id: 1, id: 1 }
            expect(response.status).to eq(400)
        end
    
        # it "Has a 200 status code" do
        #     project = create(:project, user_id: 2)
        #     task1 = create(:task, project_id: 2)
        #     task2 = create(:second_task, project_id: 2)
        #     get :update, :params =>  { project_id: 1, id: 2 }
        #     expect(task1.name).to eq(400)
        # end

        # it "Response match the schema" do
        #     project = create(:project, user_id: 28)
        #     task = create(:task, project_id: 27)
        #     put :update, :params =>  { project_id: 27, id: 14 }
        #     expect(JSON::Validator.validate(task_schema, JSON.parse(response.body))).to eq(true)
        # end

        
        # it "Has a 404 status code" do
        #     project = create(:project, user_id: 29)
        #     task = create(:task, project_id: 28)
        #     put :update, :params =>  { project_id: 28, id: 20 } # 15
        #     expect(response.status).to eq(404)
        # end
    end
end