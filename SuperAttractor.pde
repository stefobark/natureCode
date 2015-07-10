class SuperAttractor {

  PVector location;
  float mass;
  float startAngle = 0;
  float angleVel = 0.23;
  float x;
  float lifespan;
  float incrementer;
  
  SuperAttractor(float m, float u,float i) {
    mass = m;
    x = u;
    location = new PVector(0, 0);
    lifespan = 5555.0;
    incrementer = i;
  }
  
  void update() {
    startAngle += 0.015;
    float angle = startAngle;
    if(location.x <= width){
      x += incrementer;
      float y = map(sin(angle),-10,10,800,height/8);
      location.x = x;
      location.y = y;
      angle += angleVel;
     } else {
       mass = 0;
     }
    lifespan -= 4;
    if(mass > 0){
      mass -= .02;
    } else {
      mass = 0;
    }
  }
  
 
     
  void display() {
      stroke(0, 10);
      fill(0,10);
      strokeWeight(2);
      ellipse(location.x,location.y,mass,mass);
  }
  
  // Is the attractor still alive?
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } 
    else {
      return false;
    }
  }

  void attractShaker(Shaker m) {
    PVector force = PVector.sub(location, m.location);             // Calculate direction of force
    float distance = force.mag();                                 // Distance between objects
    if(distance < lifespan){
      distance = constrain(distance, 100.0, 900.0);
      force.normalize();
      float strength = (g * mass * m.mass) / (distance * distance); // Calculate gravitional force magnitude
      force.mult(strength*500);    
    } else {
      force.mult(0);
    }
    m.applyForce(force);
  }
  
  void attractUnfriendly(UnFriendly m) {
    PVector force = PVector.sub(location, m.location);             // Calculate direction of force
    float distance = force.mag();                                 // Distance between objects
    if(distance < lifespan){
      distance = constrain(distance, 100.0, 900.0);
      force.normalize();
      float strength = (g * mass * m.mass) / (distance * distance); // Calculate gravitional force magnitude
      force.mult(strength*5000);    
    } else {
      force.mult(0);
    }
       m.applyForce(force);
  }
  
   void attractFriendly(Friendly m) {
    PVector force = PVector.sub(location, m.location);             // Calculate direction of force
    float distance = force.mag();                                 // Distance between objects
    if(distance < lifespan){
      distance = constrain(distance, 100.0, 900.0);
      force.normalize();
      float strength = (g * mass * m.mass) / (distance * distance); // Calculate gravitional force magnitude
      force.mult(strength*5000);    
    } else {
      force.mult(0);
    }
       m.applyForce(force);
  }
  
  void run(){
    update();
    display();
  }
  
  void attractMover(Mover m) {
   PVector force = PVector.sub(location, m.location);             // Calculate direction of force
    float distance = force.mag();                                 // Distance between objects
    if(distance > lifespan){
      distance = constrain(distance, 100.0, 900.0);
      force.normalize();
      float strength = (g * mass * m.mass) / (distance * distance); // Calculate gravitional force magnitude
      force.mult(strength*5000);    
    } else {
       m.applyForce(force);
    }
       m.applyForce(force);
  }
 }
