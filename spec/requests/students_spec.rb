require 'swagger_helper'

RSpec.describe 'students', type: :request do
  let(:school) { create(:school) }
  let(:school_class) { create(:school_class, school: school) }

  path '/schools/{school_id}/classes/{class_id}/students' do
    parameter name: :school_id, in: :path, type: :integer, format: :int32
    parameter name: :class_id,  in: :path, type: :integer, format: :int32, description: 'id класса'

    get('Вывести список студентов класса') do
      tags 'students', 'classes'
      operationId 'getClassStudentList'

      response '200', 'Список студентов' do
        schema type: :object,
               properties: {
                 data: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       id: { type: :integer },
                       first_name: { type: :string },
                       last_name: { type: :string },
                       surname: { type: :string },
                       class_id: { type: :integer },
                       school_id: { type: :integer }
                     },
                     required: %w[id first_name last_name surname class_id school_id]
                   }
                 }
               }

        let(:school_id) { school.id }
        let(:class_id) { school_class.id }

        before do
          create_list(:student, 2, school_class: school_class, school: school)
        end

        run_test! do |response|
          data = JSON.parse(response.body)["data"]
          expect(data.size).to eq(2)
        end
      end
    end
  end

  path '/students' do
    post('Регистрация нового студента') do
      tags 'students'
      operationId 'createStudent'
      consumes 'application/json'

      parameter name: :student, in: :body, schema: {
        type: :object,
        properties: {
          first_name: { type: :string },
          last_name:  { type: :string },
          surname:    { type: :string },
          class_id:   { type: :integer },
          school_id:  { type: :integer }
        },
        required: %w[first_name last_name surname class_id school_id]
      }


      response '201', 'Successful operation' do
        header 'X-Auth-Token', schema: { type: :string },
                               description: 'Токен для последующей авторизации'

        schema type: :object,
               properties: {
                 id: { type: :integer },
                 first_name: { type: :string },
                 last_name: { type: :string },
                 surname: { type: :string },
                 class_id: { type: :integer },
                 school_id: { type: :integer }
               },
               required: %w[id first_name last_name surname class_id school_id]

        let(:student) { attributes_for(:student, class_id: school_class.id, school_id: school.id)  }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['id']).to be_present
          expect(response.headers['X-Auth-Token']).to be_present
        end
      end

      response '405', 'Invalid input' do
        let(:student) { { student: { first_name: nil } } }
        run_test!
      end
    end
  end

  path '/students/{user_id}' do
    parameter name: :user_id, in: :path, type: :integer, format: :int64, description: 'id студента'

    delete('Удалить студента') do
      tags 'students'
      operationId 'deleteStudent'
      security [ bearerAuth: [] ]

      let(:student) { create(:student, :with_token) }

      response '400', 'Некорректный id студента' do
        let(:user_id) { 'invalid' }
        let(:Authorization) { student.raw_token }

        run_test!
      end

      response '401', 'Некорректная авторизация' do
        let(:user_id) { student.id }
        let(:Authorization) { nil }

        run_test!
      end

      response '204', 'Студент удалён' do
        let(:user_id) { student.id }
        let(:Authorization) { student.raw_token }

        run_test! do
          expect(Student.find_by(id: user_id)).to be_nil
        end
      end
    end
  end
end
