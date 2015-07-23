class SuperAttractor {

  PVector location;
  float mass;
  float red;
  float green;
  float blue;
  
  SuperAttractor(float m, float x,float y, float r, float g, float b) {
    mass = m;
    location = new PVector(x, y);
    red = r;
    green = g;
    blue = b;
    
  }
  
  void update() {
  }
  
  void display() {
      stroke(20, 0);
      fill(red,green,blue,10);
      strokeWeight(2);
      ellipse(location.x,location.y,mass,mass);
  }

  void attract(Mover m) {
    PVector force = PVector.sub(location, m.location);      
    float distance = force.mag(); 
    //for changing color when it is influenced by this attractor
    if(distance <= mass + 40){
      m.red += (red - m.red)/50;
      m.green += (green - m.green)/50;
      m.blue += (blue - m.blue)/50;
    }
    distance = constrain(distance, 10.0, 200.0);
    force.normalize();
    
    //if the mover is less than half of the attractor's mass away
    if(distance <= mass){
      float strength = (mass * m.mass) / (distance * distance); 
      
      //make force stronger if the attractor is red or blue
      if(blue > 100 || red > 100){
        force.mult(10);
      }
      force.mult(-strength*2);
      if(mass > 800){
        mass = 30;
      } else {
        mass += strength * .3;
      }
      
    } else {
      float strength = (mass * m.mass) / (distance * distance);
      
     //make force weak if the attractor is green 
     if(green > 200){
        force.mult(.5);
      } 
      
      force.mult(strength*2);
    }
    m.applyForce(force);
  }
 
  void run(){
    update();
    display();
  }
 }
