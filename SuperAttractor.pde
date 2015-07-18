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
      fill(red,green,blue,00);
      strokeWeight(2);
      ellipse(location.x,location.y,mass,mass);
  }

  void attract(Mover m) {
    PVector force = PVector.sub(location, m.location);      
    float distance = force.mag(); 
    //for changing color when it is influenced by this attractor
    if(distance <= mass + 40){
      m.red += (red - m.red)/100;
      m.green += (green - m.green)/100;
      m.blue += (blue - m.blue)/100;
    }
    distance = constrain(distance, 10.0, 200.0);
    force.normalize();
    
    //if the mover is less than half of the attractor's mass away
    if(distance <= mass/2){
      float strength = (g * m.mass) / (distance); 
      force.mult(-strength*50);
      if(mass > 500){
        mass = 30;
      } else {
        mass += strength * .2;
      }
      
    } else {
      float strength = (g * mass * m.mass) / (distance * distance); 
      force.mult(strength*100);
      mass -= strength * .01;
    }
    m.applyForce(force);
  }
 
  void run(){
    update();
    display();
  }
 }
