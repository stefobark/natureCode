// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com
 
 // Liquid class 
 class Liquid {

  
  // Liquid is a rectangle
  float x,y,w,h;
  // Coefficient of drag
  float c;

  Liquid(float x_, float y_, float w_, float h_, float c_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    c = c_;
  }
  
  // Is the Shaker in the Liquid?
  boolean containsShaker(Shaker s) {
    PVector t = s.location;
    
    if (t.x > x && t.x < x + w && t.y > y && t.y < y + h) {
      return true;
    }  
    else {
      return false;
    }
  }
  
  boolean containsUnfriendly(UnFriendly s) {
    PVector t = s.location;
    
    if (t.x > x && t.x < x + w && t.y > y && t.y < y + h) {
      return true;
    }  
    else {
      return false;
    }
  }
  
  // Is the Mover in the Liquid?
  boolean containsMover(Mover s) {
    PVector t = s.location;
    
    if (t.x > x && t.x < x + w && t.y > y && t.y < y + h) {
      return true;
    }  
    else {
      return false;
    }
  }
  
  // Calculate drag force
  PVector dragShaker(Shaker s) {
    // Magnitude is coefficient * speed squared
    float speed = s.velocity.mag();
    float dragMagnitude = c * speed * speed;

    // Direction is inverse of velocity
    PVector dragForce = s.velocity.get();
    dragForce.mult(-1);
    
    // Scale according to magnitude
    // dragForce.setMag(dragMagnitude);
    dragForce.normalize();
    dragForce.mult(dragMagnitude);
    return dragForce;
  }
  
  // Calculate drag force
  PVector dragUnfriendly(UnFriendly s) {
    // Magnitude is coefficient * speed squared
    float speed = s.velocity.mag();
    float dragMagnitude = c * speed * speed;

    // Direction is inverse of velocity
    PVector dragForce = s.velocity.get();
    dragForce.mult(-1);
    
    // Scale according to magnitude
    // dragForce.setMag(dragMagnitude);
    dragForce.normalize();
    dragForce.mult(dragMagnitude);
    return dragForce;
  }
  
  // Calculate drag force
  PVector dragMover(Mover m) {
    // Magnitude is coefficient * speed squared
    float speed = m.velocity.mag();
    float dragMagnitude = c * speed * speed;

    // Direction is inverse of velocity
    PVector dragForce = m.velocity.get();
    dragForce.mult(-1);
    
    // Scale according to magnitude
    // dragForce.setMag(dragMagnitude);
    dragForce.normalize();
    dragForce.mult(dragMagnitude);
    return dragForce;
  }
  
  void display() {
    noStroke();
    fill(0,0,255,10);
    rect(x,y,w,h);
  }

}
