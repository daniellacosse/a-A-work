Function.prototype.myBind = function(obj) {
  var thisFunction = this;

  return function() {
    thisFunction.apply(obj)
  };

};

var Clock = function() {

  this.time = new Date();
  this.hours = this.time.getHours();
  this.minutes = this.time.getMinutes();
  this.seconds = this.time.getSeconds();

};

Clock.prototype.run = function(){
  // var myClock = this;

  this.time = new Date();

  // var clk = setInterval(function(){
  //   myClock.tick();
  // }, 5000);
   // setInterval(myClock.tick.myBind(myClock), 5000);
   setInterval(this.tick.myBind(this), 5000);

};

Clock.prototype.tick = function(){
  this.seconds += 5;

  if (this.seconds >= 60){
    this.minutes += 1;
    this.seconds -= 60;
  };

  if (this.minutes >= 60){
    this.hours += 1;
    this.minutes -= 60;
  };

  if (this.hours >= 24){
    this.hours -= 24;
  };

  console.log(this.hours + ":" + this.minutes + ":" + this.seconds);
};

clock = new Clock();
clock.run();