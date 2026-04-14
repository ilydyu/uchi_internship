# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.openapi_root = Rails.root.join('swagger').to_s

     # Define one or more Swagger documents and provide global metadata for each one
     # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
     # be generated at the provided relative path under openapi_root
     # By default, the operations defined in spec files are added to the first
     # document below. You can override this behavior by adding a openapi_spec tag to the
     # the root example_group in your specs, e.g. describe '...', openapi_spec: 'v2/swagger.json'
     config.openapi_specs = {
       'v1/swagger.yaml' => {
         openapi: '3.0.3',
         info: {
           title: 'API сервиса для тестового задания',
           version: '0.1.0'
         },
         components: {
           securitySchemes: {
             bearerAuth: {
               type: :http,
               scheme: :bearer,
               description: 'Ожидается токен, выдаваемый при регистрации студента',
               bearerFormat: 'SHA256'
             }
           },
           parameters: {
             school_id: {
               name: :school_id,
               in: :path,
               required: true,
               schema: { type: :integer, format: :int32 }
             },
             class_id: {
               name: :class_id,
               in: :path,
               required: true,
               schema: { type: :integer, format: :int32 }
             }
           },
           schemas: {
             Class: {
               type: :object,
               required: [ :id, :number, :letter, :students_count ],
               properties: {
                 id: { type: :integer, format: :int32, readOnly: true, example: 10 },
                 number: { type: :integer, format: :int32, example: 1, description: 'Цифра класса' },
                 letter: { type: :string, example: 'Б', description: 'Буква класса' },
                 students_count: { type: :integer, format: :int32, readOnly: true, example: 32, description: 'Количество учеников в классе' }
               }
             },
             Student: {
               type: :object,
               required: [ :id, :first_name, :last_name, :surname, :class_id, :school_id ],
               properties: {
                 id: { type: :integer, format: :int64, readOnly: true, example: 10 },
                 first_name: { type: :string, example: 'Вячеслав' },
                 last_name: { type: :string, example: 'Абдурахмангаджиевич' },
                 surname: { type: :string, example: 'Мухобойников-Сыркин' },
                 class_id: { type: :integer, format: :int32 },
                 school_id: { type: :integer, format: :int32 }
               }
             }
           }
         },
         paths: {},
         servers: [
           { url: 'http://{defaultHost}', variables: { defaultHost: { default: 'localhost:3000' } } }
         ]
       }
     }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The openapi_specs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.openapi_format = :yaml
end
