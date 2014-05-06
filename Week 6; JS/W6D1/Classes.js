

Array.prototype.include = function(target){
  for(var i = 0; i < this.length; i++){
    if(this[i] === target) return true;
  }
  return false;
}


function Student(fname, lname){
  this.fname = fname;
  this.lname = lname;
  this.name = fname + " " + lname;

  this.courses = new Array();

  this.enroll = function(course){
    if(this.hasConflict(course)) throw "Schedule Conflict!";
    if(!this.courses.include(course)){
      this.courses.push(course);
      course.addStudent(this);
    }
  };

  this.hasConflict = function(course){
    for(var i = 0; i < this.courses.length; i++){
      if(this.courses[i].conflictsWith(course)) return true;
    }

    return false;
  }
}

Student.prototype.toString = function(){
  return this.name;
}

function Course(name, department, credits, weekdays, timeblock){
  this.name = name;
  this.department = department;
  this.credits = credits;
  this.weekdays = weekdays;
  this.timeblock = timeblock;

  this.students = new Array();

  this.addStudent = function(student){
    if(!this.students.include(student)) this.students.push(student);
  }

  this.conflictsWith = function(otherCourse){
    if (this.timeblock !== otherCourse.timeblock) return false;

    for(var i = 0; i < this.weekdays.length; i++){
      if (otherCourse.weekdays.include(this.weekdays[i])) return true;
    }

    return false;
  }


}

Course.prototype.toString = function(){
  return this.name;
}


var krishna = new Student("Krishna", "Kulkarni");
var daniel = new Student("Daniel", "LaCosse");
var course1 = new Course("ruby", "COS", 2, ["M", "W", "F"], 3);
var course2 = new Course("js", "COS", 0.5, ["T", "R"], 2);
var course3 = new Course("talking to girls", "GEN", 4, ["M", "W"], 2);

krishna.enroll(course1);
krishna.enroll(course2);
daniel.enroll(course1);
daniel.enroll(course3);

console.log("K Courses: "+ krishna.courses);
console.log("C1 students: " + course1.students);
console.log("Dan's name: "+daniel.name);

