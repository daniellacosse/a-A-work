class Course
  attr_accessor :students, :dept, :credits, :name

  def initialize(name, dept, credits)
    @name = name
    @dept = dept
    @credits = credits
    @students = []
  end

  def add_student(student)
    @students << student unless @students.include?(student)
  end


end

class Student
  attr_accessor :courses, :course_load

  def initialize(first_name="John", last_name="Doe")
    @first_name = first_name
    @last_name = last_name
    @courses = []
    @course_load = Hash.new(0)
  end

  def name
    @first_name + " " + @last_name
  end

  def enroll(course)
    @courses << course.name
    course.add_student(self.name)
    @course_load[course.dept] += course.credits
  end
end