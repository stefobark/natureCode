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

  void repel(Mover m, float repelDistance) {
    PVector force = PVector.sub(location, m.location); 
    float distance = force.mag();
   if(m.red > 150 || m.blue > 150){   
    distance = constrain(distance, 5.0, 100.0);   
    force.normalize();
    float strength = (g * mass * m.mass) / (distance * distance); 
    force.mult(-strength*10);  
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
  
  //look at the shaker creatures, get the distance by looking at the magnitude of the vector created by subtracting location from shaker location
  //change mass based on location of opposite creatures. so, if a mover is surrounded by shakers it will grow, if it is not surrounded by shakers, it will shrink
  void attract(Mover m, float attractDistance) {
    PVector force = PVector.sub(location, m.location);             
    float distance = force.mag();
    if(m.green > 150){
      distance = constrain(distance, 5.0, 100.0);
      force.normalize(); 
      float strength = (g * mass * m.mass) / (distance * distance);
      force.mult(strength*2); 
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


