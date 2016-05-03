class Student
  include Mongoid::Document
  field :first_name, type: String
  field :last_name, type: String
  field :major, type: String
  field :gpa, type: Float
  field :courses, type: Array
end
