// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

class Friendly {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float fillColor = random(0,255);
  float fillColor2 = random(0,255);
  float mass;

  Friendly(float m, float x, float y) {
    mass = m;
    location = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
  }

  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }

  void update() {
    velocity.add(acceleration);
    velocity.limit(6);
    location.add(velocity);
    acceleration.mult(0);
  }

  void display() {
    stroke(0);
    strokeWeight(1);
    //when opposite creatures get close together, they share
    //each other's color
    fill(fillColor, fillColor2, fillColor/2,60);
    rect(location.x, location.y, mass, mass);
  }

  PVector attractMover(Mover m) {
    PVector force = PVector.sub(location, m.location);             // Calculate direction of force
    float distance = force.mag();    
    if(distance < 50){
      distance = constrain(distance, 5.0, 100.0);
      mass = constrain(mass, .02, 200); 
      force.normalize(); 
      float strength = (1 * mass * m.mass) / (distance * distance); // Calculate gravitional force magnitude
      force.mult(strength*500); 
    } else {
      force.mult(0);
    }
    return force;
  }
  
  void attractUnfriendly(UnFriendly m) {
    PVector force = PVector.sub(location, m.location);             // Calculate direction of force
    float distance = force.mag();    
    if(distance < 400){
      distance = constrain(distance, 5.0, 100.0);
      mass = constrain(mass, .02, 200); 
      force.normalize();
      float strength = (1 * mass * m.mass) / (distance * distance); // Calculate gravitional force magnitude
      force.mult(strength*500); 
    } else {
      force.mult(0); 
    }
    m.applyForce(force);
  }
  
  void repelFriendly(Friendly m) {
    PVector force = PVector.sub(location, m.location);             // Calculate direction of force
    float distance = force.mag();  
    distance = constrain(distance, 5.0, 100.0);
    mass = constrain(mass, .02, 200); 
    force.normalize();  
    if(distance < 300){
      float strength = (1 * mass * m.mass) / (distance * distance); // Calculate gravitional force magnitude
      force.mult(strength*500000); 
    } else {
      force.mult(0);
    }
    //directly apply the force to the friendly
    m.applyForce(force);
  }
  
  PVector attractShaker(Shaker m) {
    PVector force = PVector.sub(location, m.location);             // Calculate direction of force
    float distance = force.mag();    
    if(distance < 50){
      distance = constrain(distance, 5.0, 100.0);
      mass = constrain(mass, .02, 200); 
      force.normalize();
      float strength = (1 * mass * m.mass) / (distance * distance); // Calculate gravitional force magnitude
      force.mult(strength*500); 
    } else {
      force.mult(0);
    }
    return force;
  }
 
  
  //make them bounce off the edges
  void checkEdges() {
    if (location.x > width) {
      location.x = width;
      velocity.x *= -1;
    } else if (location.x < 0) {
      velocity.x *= -1;
      location.x = 0;
    }
    if (location.y > height) {
      // Even though we said we shouldn't touch location and velocity directly, there are some exceptions.
      // Here we are doing so as a quick and easy way to reverse the direction of our object when it reaches the edge.
      velocity.y *= -1;
      location.y = height;
    } else if (location.y < 0) {
      velocity.y *= -1;
      location.y = 0;
    }
    
  }


}


