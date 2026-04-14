# spec/requests/classes_spec.rb
require 'swagger_helper'

RSpec.describe 'classes', type: :request do
  path '/schools/{school_id}/classes' do
    parameter name: :school_id, in: :path, type: :integer, format: :int32

    get('Вывести список классов школы') do
      tags 'classes'
      operationId 'getClassList'

      response '200', 'Список классов' do
        schema type: :object,
               properties: {
                 data: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       id: { type: :integer },
                       number: { type: :integer },
                       letter: { type: :string },
                       students_count: { type: :integer }
                     },
                     required: %w[id number letter students_count]
                   }
                 }
               }

        let(:school) { create(:school) }
        let(:school_id) { school.id }

        before do
          create_list(:school_class, 2, school: school)
        end

        run_test! do |response|
          data = JSON.parse(response.body)['data']
          expect(data.size).to eq(2)
        end
      end
    end
  end
end
