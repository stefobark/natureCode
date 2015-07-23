// Steve Barker's ecosystem inspired by:
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
  float lifespan;
  float red;
  float green;
  float blue;
  float maxspeed;
  float maxforce;

  Mover(float m, float x, float y, float l) {
    mass = m;
    location = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    //lifespan = l;
    red = 0;
    green = 0;
    blue = 0;
    
  }

  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    velocity.limit(2);
    acceleration.mult(0);
    //lifespan -= 1;
  }

  void display() {
    float angle = atan2(velocity.y,velocity.x);
    stroke(0,0);
    fill(red,green,blue,50);
    pushMatrix();
    translate(location.x,location.y);
    rotate(angle);
    ellipse(0,0,mass,mass);
    ellipse(mass,0,mass/2,mass/2);
    ellipse(0,mass,mass/2,mass/2);
    ellipse(-mass,0,mass/3,mass/3);
    ellipse(0,-mass,mass/3,mass/3);
    popMatrix();
  }
  
  // Alignment
  // For every nearby boid in the system, calculate the average velocity
  PVector align (ArrayList<Mover> movers) {
    float neighbordist = 50;
    PVector sum = new PVector(0,0);
    int count = 0;
    for (Mover other : movers) {
      float d = PVector.dist(location,other.location);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.velocity);
        count++;
      }
    }
    if (count > 0) {
      sum.div((float)count);
      sum.normalize();
      sum.mult(maxspeed);
      PVector steer = PVector.sub(sum,velocity);
      steer.limit(maxforce);
      return steer;
    } else {
      return new PVector(0,0);
    }
  }

  
  // Separation
  // Method checks for nearby movers and steers away
  void separate (ArrayList<Mover> movers) {
    float desiredseparation = 25.0f;
    PVector steer = new PVector(0,0,0);
    int count = 0;
    // For every boid in the system, check if it's too close
    for (Mover other : movers) {
      float d = PVector.dist(location,other.location);
      // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
      if ((d > 0) && (d < desiredseparation)) {
        // Calculate vector pointing away from neighbor
        PVector diff = PVector.sub(location,other.location);
        diff.normalize();
        diff.div(d);        // Weight by distance
        steer.add(diff);
        count++;            // Keep track of how many
      }
    }
    // Average -- divide by how many
    if (count > 0) {
      steer.div((float)count);
    }

    // As long as the vector is greater than 0
    if (steer.mag() > 0) {
      // Implement Reynolds: Steering = Desired - Velocity
      steer.normalize();
      steer.mult(maxspeed);
      steer.sub(velocity);
      steer.limit(maxforce);
    }
    applyForce(steer);
  }

  void repel(Mover m, float repelDistance) {
    PVector force = PVector.sub(location, m.location); 
    float distance = force.mag();
   if(red > 200 || blue > 200){   
    distance = constrain(distance, 5.0, 100.0);   
    force.normalize();
    float strength = (g * m.mass) / distance; 
    force.mult(-strength*.5);  
   } else {
     force.mult(0);
   }
    
     m.applyForce(force);
  }
  
  void run(){
    update();
    checkEdges();
    display();
  }
  
  void repelMouse() {
    PVector mouseLoc = new PVector(mouseX,mouseY);
    PVector force = PVector.sub(mouseLoc, location);
    float distance = force.mag(); 
     if(distance < 100){
        distance = constrain(distance, 5.0, 100.0);
        force.normalize(); 
        float strength = (g * mass * 100) / (distance * distance); // Calculate gravitional force magnitude
        force.mult(-strength*2);
     } else {
       force.mult(0);
     }
    applyForce(force);
  }
  
  void attract(Mover m, float attractDistance) {
    PVector force = PVector.sub(location, m.location);             
    float distance = force.mag();
    if(green > 150){
      distance = constrain(distance, 5.0, 100.0);
      force.normalize(); 
      float strength = (g * m.mass) / distance;
      force.mult(strength); 
    } else {
       force.mult(0);
    }
    m.applyForce(force);
  }
  
  boolean isTouching(Mover m){
    PVector force = PVector.sub(location, m.location);  
    float distance = force.mag();
    if(distance <= mass){
      red += (m.red - red)/8;
      blue += (m.blue - blue)/8;
      green += (m.green - green)/8;
      return true;
    } else {
      return false;
    }
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
      velocity.y *= -1;
      location.y = height;
    } else if (location.y < 0) {
      velocity.y *= -1;
      location.y = 0;
    }
    
  }


}


