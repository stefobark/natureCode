// Steve Barker
// Reading "the Nature of Code"
// by Daniel Shiffman
// http://natureofcode.com

class Shaker extends Mover{

  Shaker(float m, float x, float y, float l) {
    super(m,x,y,l);
  }
  
  void display() {
    float angle = atan2(velocity.y,velocity.x);
    stroke(0,0);
    fill(red,green,blue,50);
    pushMatrix();
    translate(location.x,location.y);
    rotate(angle);
    ellipse(-mass,0,mass/2,mass/2);
    ellipse(0,0,mass,mass);
    ellipse(mass,0,mass/2,mass/2);
    popMatrix();
  }
 

}


