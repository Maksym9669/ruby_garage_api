require "rails_helper"

RSpec.describe Project, type: :model do
    describe "Check validations" do
        let!(:user) { create(:user) }

        it "Is valid" do
            project = create(:project, user_id: 31)
            expect(project).to be_valid
        end

        it "Is not valid without a name" do
            project = create(:project, user_id: 32)
            project.name = nil
            expect(project).to be_invalid
        end

        it "Is not valid without a user_id" do
          project = create(:project, user_id: 33)
          project.user_id = nil
          expect(project).to be_invalid
        end
    end
end
