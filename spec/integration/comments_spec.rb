require 'swagger_helper'

describe 'Comments API' do

  path '/api/projects/{project_id}/tasks/{task_id}/comments' do
    get 'Retrieves comments' do
        tags 'Comments'
        produces 'application/json'
        parameter name: :project_id, in: :path, type: :string
        parameter name: :task_id, in: :path, type: :string
  
        response '200', 'Comments found' do
          run_test!
        end
  
        response '404', 'Comments not found' do
          run_test!
        end
      end
  end


  path '/api/projects/{project_id}/tasks/{task_id}/comments' do

    post 'Creates a comment' do
      tags 'Comment'
      consumes 'application/json'
      parameter name: :project_id, in: :path, type: :string
      parameter name: :task_id, in: :path, type: :string
      parameter name: :comment, in: :body, schema: {
        type: :object,
        properties: {
          content: { type: :string },
          attachment: { type: :string }
        },
        required: [ 'content' ]
      }

      response '201', 'Comment created' do
        let(:comment) { { content: 'Comment1' } }
        run_test!
      end

      response '400', 'Project not created' do
        let(:comment) { { random_string: 'foo' } }
        run_test!
      end
    end
  end


  path '/api/projects/{project_id}/tasks/{task_id}/comments/{id}' do

    get 'Retrieves a comment' do
      tags 'Comment'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :project_id, in: :path, type: :string
      parameter name: :task_id, in: :path, type: :string

      response '200', 'Comment found' do
        schema type: :object,
        properties: {
            
            id: { type: :integer },
            project_id: { type: :integer },
            task_id: { type: :integer },
            created_at: {type: :string},
            updated_at: {type: :string},
            content: {type: :string},
            attachment: {type: :string}
          },
          required: [ 'id', 'task_id', 'project_id', 'created_at', 'updated_at', 'content']

        let(:id) { Comment.create(content: 'Comment1').id }
        run_test!
      end

      response '404', 'Comment not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end






  path '/api/projects/{project_id}/tasks/{task_id}/comments/{id}' do

    delete 'Delete a comment' do
      tags 'Comment'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :project_id, in: :path, type: :string
      parameter name: :task_id, in: :path, type: :string

      response '200', 'Comment was successfully deleted' do
        let(:id) { Comment.create(content: 'Comment1').id }
        run_test!
      end

      response '404', 'Comment not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end