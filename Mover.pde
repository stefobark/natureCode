// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

class Mover {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  int fillColor2 = 20;
  float fillColor = random(0,255);

  Mover(float m, float x, float y) {
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
    mass = constrain(mass, 1, 50);
    fill(fillColor, fillColor2, 245,30);
    ellipse(location.x, location.y, mass, mass);
  }

  PVector repel(Mover m, float repelDistance) {
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
  
  PVector repelMouse(Mover m) {;
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
  
  //look at the shaker creatures, get the distance by looking at the magnitude of the vector created by subtracting location from shaker location
  //change mass based on location of opposite creatures. so, if a mover is surrounded by shakers it will grow, if it is not surrounded by shakers, it will shrink
  void checkShaker(Shaker m, float attractDistance) {
    PVector force = PVector.sub(location, m.location);             // Calculate direction of force
    float distance = force.mag();
    if(distance < attractDistance){
      mass += .05;
      force.normalize(); 
      float strength = (g * mass * m.mass) / (distance * distance); // Calculate gravitional force magnitude
      force.mult(strength*10000); 
    } else {
       mass -= m.mass*.05;
       force.mult(0);
    }
    m.applyForce(force);
  }
  
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


