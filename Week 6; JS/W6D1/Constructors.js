function Cat(name, owner){
  this.name = name;
  this.owner = owner;
}

Cat.prototype.cuteStatement = function(){
  return (this.owner + " loves " + this.name);
};

cat1 = new Cat();

cat1.name = "cat1";
cat1.owner = "owner1";

cat2 = new Cat();

cat2.name = "cat2";
cat2.owner = "owner2";

cat3 = new Cat();

cat3.name = "cat3";
cat3.owner = "owner3";

console.log(cat1.cuteStatement());
console.log(cat2.cuteStatement());
console.log(cat3.cuteStatement());

Cat.prototype.cuteStatement = function(){
  return ("everyone loves " + this.name + "!");
}

console.log(cat1.cuteStatement());
console.log(cat2.cuteStatement());
console.log(cat3.cuteStatement());

Cat.prototype.meow = function(){
  return "meoooooooooowwwww....";
}
cat1.meow = function(){
  return "yeowwww";
}

console.log(cat1.meow());
console.log(cat2.meow());
console.log(cat3.meow());
