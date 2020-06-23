require 'swagger_helper'

describe 'Projects API' do

  path '/api/projects/' do
    get 'Retrieves projects' do
        tags 'Projects'
        produces 'application/json'
        parameter name: :id, in: :path, type: :string
  
        response '200', 'Projects found' do
          run_test!
        end
  
        response '404', 'Projects not found' do
          run_test!
        end
      end
  end



  path '/api/projects/{id}' do

    post 'Creates a project' do
      tags 'Project'
      consumes 'application/json'
      parameter name: :project, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string }
        },
        required: [ 'name']
      }

      response '201', 'Project created' do
        let(:project) { { name: 'Project1' } }
        run_test!
      end

      response '400', 'Project not created' do
        let(:project) { { random_string: 'foo' } }
        run_test!
      end
    end
  end

  path '/api/projects/{id}' do

    get 'Retrieves a project' do
      tags 'Project'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'Project found' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            user_id: { type: :integer },
            created_at: {type: :string},
            updated_at: {type: :string}
          },
          required: [ 'id', 'name', 'user_id', 'created_at', 'updated_at' ]

        let(:id) { Project.create(name: 'project1').id }
        run_test!
      end

      response '404', 'Project not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end



  path '/api/projects/{id}' do

    put 'Updates a project' do
      tags 'Project'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'Project updated' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            user_id: { type: :integer },
            created_at: {type: :string},
            updated_at: {type: :string}
          },
          required: [ 'id', 'name', 'user_id', 'created_at', 'updated_at' ]

        let(:id) { Project.create(name: 'project1').id }
        run_test!
      end

      response '404', 'Project not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end


  path '/api/projects/{id}' do

    delete 'Delete a project' do
      tags 'Project'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'Project was successfully deleted' do
        let(:id) { Project.create(name: 'project1').id }
        run_test!
      end

      response '404', 'Project not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
  
end