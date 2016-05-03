class Instructor
  include Mongoid::Document
  field :first_name, type: String
  field :last_name, type: String
  field :dept, type: String
  field :salary, type: Float
  field :courses, type: Array
end
