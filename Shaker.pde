// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

class Shaker {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float fillColor = random(0,255);
  int fillColor2 = 20;
  float mass;

  Shaker(float m, float x, float y) {
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
    velocity.limit(4);
    location.add(velocity);
    acceleration.mult(0);
  }

  void display() {
    stroke(0);
    strokeWeight(1);
    //when opposite creatures get close together, they share
    //each other's color
    mass = constrain(mass, 1, 10);
    fill(fillColor, fillColor + 30, fillColor/2,100);
    ellipse(location.x, location.y, mass, mass);
  }

   
  PVector repelMouse(Shaker m) {;
    PVector mouseLoc = new PVector(mouseX,mouseY);
    PVector force = PVector.sub(mouseLoc, m.location);
    float distance = force.mag(); 
     if(distance < 100){    
        
        distance = constrain(distance, 5.0, 100.0);
        force.normalize(); 
        float strength = (g * mass * m.mass) / (distance * distance); // Calculate gravitional force magnitude
        force.mult(strength*10000000);  
        force.mult(-1);
     } else {
       force.mult(0);
     }
    return force;
  }
  PVector repel(Shaker m, float repelDistance) {
   PVector force = PVector.sub(location, m.location); 
    float distance = force.mag();
   if(distance < repelDistance){   
    distance = constrain(distance, 5.0, 100.0); 
    force.normalize();                                            // Normalize vector (distance doesn't matter here, we just want this vector for direction
    force.mult(-1);
    float strength = (g * mass * m.mass) / (distance * distance); // Calculate gravitional force magnitude
    force.mult(strength*100000);  
   } else {
     force.mult(0);
   }
    
    return force;
  }
  
  //look at the mover creatures, get the distance by looking at the magnitude of the vector created by subtracting location from mover location
  //change mass based on location of opposite creatures. so, if a shaker is surrounded by movers it will grow, if it is not surrounded by movers, it will shrink
  void checkMover(Mover m, float repelDistance) {
    PVector force = PVector.sub(location, m.location);             // Calculate direction of force
    float distance = force.mag();
    if(distance < repelDistance){
      mass += .05;
      mass = constrain(mass, .02, 80);
      force.normalize(); 
      float strength = (g * mass * m.mass) / (distance * distance); // Calculate gravitional force magnitude
      force.mult(strength*10000); 
    } else {
       mass -= .05;
       force.mult(0);
    }
    m.applyForce(force);
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


