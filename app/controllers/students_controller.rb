class StudentsController < ApplicationController
  def index

  end

  # List all courses from greatest to least enrollment
  def first_question
    unwind = { "$unwind" => "$courses"}
    group = {"$group" => {"_id" => {"dept" => "$courses.dept", "crs_num" => "$courses.crs_num"},
                          "enrolled" => {"$sum" => 1} } }
    project = {"$project" => {"dept" => "$_id.dept",
                              "crs_num" => "$_id.crs_num",
                              "enrolled" => 1} }
    sort = {"$sort"=> {"enrolled" => -1} }
    @q1 = Student.collection.aggregate([unwind, group, project, sort])
  end

  # List the average GPA for students who took KIN 452
  def second_question
    unwind = { "$unwind" => "$courses"}
    match = { "$match" => { "$and" => [{ "courses.dept" => "KIN" }, {"courses.crs_num"  => 452 }] }}
    group = { "$group" => { "_id" => "null", "avg" => {"$avg" => "$gpa"}} }

    @q2 = Student.collection.aggregate([unwind, match, group])
  end

  # List the number of students who received an A in ECON 131
  def third_question
    unwind = { "$unwind" => "$courses"}
    match = { "$match" => { "$and" => [
                                  { "courses.dept" => "ECON" },
                                  {"courses.crs_num"  => 131 },
                                  {"courses.grade" => "A"}]
                          }}
    group = { "$group" => { "_id" => "null", "count" => {"$sum" => 1}} }

    @q3 = Student.collection.aggregate([unwind, match, group])
  end
end
