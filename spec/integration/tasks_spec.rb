require 'swagger_helper'

describe 'Tasks API' do
    path '/api/projects/{project_id}/tasks' do
        get 'Retrieves tasks' do
            tags 'Tasks'
            produces 'application/json'
            parameter name: :project_id, in: :path, type: :string
      
            response '200', 'Tasks found' do
              run_test!
            end
      
            response '404', 'Tasks not found' do
              run_test!
            end
          end
      end




      path '/api/projects/{project_id}/tasks' do

        post 'Creates a task' do
          tags 'Task'
          consumes 'application/json'
          parameter name: :project_id, in: :path, type: :string
          parameter name: :task, in: :body, schema: {
            type: :object,
            properties: {
              name: { type: :string },
              status: { type: :string},
              priority: {type: :integer},
              id: { type: :integer },
              project_id: { type: :integer },
              created_at: {type: :string},
              updated_at: {type: :string}
            },
            required: [ 'name']
          }
          
    
          response '201', 'Task created' do
            let(:task) { { name: 'Task1' } }
            run_test!
          end
    
          response '400', 'Task not created' do
            let(:task) { { random_string: 'foo' } }
            run_test!
          end
        end
      end




      path '/api/projects/{project_id}/tasks/{id}' do

        get 'Retrieves a task' do
          tags 'Task'
          produces 'application/json'
          parameter name: :id, in: :path, type: :string
          parameter name: :project_id, in: :path, type: :string
    
          response '200', 'Task found' do
            schema type: :object,
            properties: {
                name: { type: :string },
                status: { type: :string},
                priority: {type: :integer},
                id: { type: :integer },
                project_id: { type: :integer },
                created_at: {type: :string},
                updated_at: {type: :string}
              },
              required: [ 'id', 'name', 'project_id', 'created_at', 'updated_at', 'status', 'priority' ]
    
            let(:id) { Task.create(name: 'task1').id }
            run_test!
          end
    
          response '404', 'Task not found' do
            let(:id) { 'invalid' }
            run_test!
          end
        end
      end




      path '/api/projects/{project_id}/tasks/{id}' do
        put 'Updates a task' do
            tags 'Task'
            produces 'application/json'
            parameter name: :id, in: :path, type: :string
            parameter name: :project_id, in: :path, type: :string
    
            response '200', 'Task updated' do
            schema type: :object,
            properties: {
                name: { type: :string },
                status: { type: :string},
                priority: {type: :integer},
                id: { type: :integer },
                project_id: { type: :integer },
                created_at: {type: :string},
                updated_at: {type: :string}
              },
              required: [ 'id', 'name', 'project_id', 'created_at', 'updated_at', 'status', 'priority' ]
    
            let(:id) { Task.create(name: 'task1').id }
            run_test!
            end
    
            response '404', 'Task not found' do
            let(:id) { 'invalid' }
            run_test!
            end
        end
        end
    

        path '/api/projects/{project_id}/tasks/{id}' do

            delete 'Delete a task' do
              tags 'Task'
              parameter name: :id, in: :path, type: :string
              parameter name: :project_id, in: :path, type: :string
        
              response '200', 'Task was successfully deleted' do
                let(:id) { Task.create(name: 'project1').id }
                run_test!
              end
        
              response '404', 'Task not found' do
                let(:id) { 'invalid' }
                run_test!
              end
            end
          end

          path '/api/projects/{project_id}/tasks/{id}/done' do
            get 'Completes a task' do
                tags 'Task'
                produces 'application/json'
                parameter name: :id, in: :path, type: :string
                parameter name: :project_id, in: :path, type: :string
        
                response '200', 'Task completed' do
                schema type: :object,
                properties: {
                    name: { type: :string },
                    status: { type: :string},
                    priority: {type: :integer},
                    id: { type: :integer },
                    project_id: { type: :integer },
                    created_at: {type: :string},
                    updated_at: {type: :string}
                  },
                  required: [ 'id', 'name', 'project_id', 'created_at', 'updated_at', 'status', 'priority' ]
        
                let(:id) { Task.create(name: 'task1').id }
                run_test!
                end
        
                response '404', 'Task not found' do
                let(:id) { 'invalid' }
                run_test!
                end
            end
            end

            path '/api/projects/{project_id}/tasks/{id}/up' do
                get 'Move a task up' do
                    tags 'Task'
                    produces 'application/json'
                    parameter name: :id, in: :path, type: :string
                    parameter name: :project_id, in: :path, type: :string
            
                    response '200', 'Task moved up' do
            
                    let(:id) { Task.create(name: 'task1').id }
                    run_test!
                    end
            
                    response '404', 'Task not found' do
                    let(:id) { 'invalid' }
                    run_test!
                    end
                end
                end

                path '/api/projects/{project_id}/tasks/{id}/down' do
                    get 'Move a task down' do
                        tags 'Task'
                        produces 'application/json'
                        parameter name: :id, in: :path, type: :string
                        parameter name: :project_id, in: :path, type: :string
                
                        response '200', 'Task moved down' do
                
                        let(:id) { Task.create(name: 'task1').id }
                        run_test!
                        end
                
                        response '404', 'Task not found' do
                        let(:id) { 'invalid' }
                        run_test!
                        end
                    end
                    end
end