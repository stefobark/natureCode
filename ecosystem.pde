// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

import toxi.geom.*;
import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;

// Reference to physics world
VerletPhysics2D physics;

ArrayList<Mover> movers = new ArrayList<Mover>();

ArrayList<SuperAttractor> attractors = new ArrayList<SuperAttractor>();


// Liquid
Liquid liquid;

float g = 0.4;
float red = 0;
float green = 0;
float blue = 0;
float aMass = 10;

void setup() {
  size(800,800);
  // Initialize the physics
  
  //toxi stuff
  physics=new VerletPhysics2D();
  physics.setWorldBounds(new Rect(10,10,width-20,height-20));
  physics.addBehavior(new GravityBehavior(new Vec2D(0,0.5)));
  
  
  for(int i = 150; i < width; i += 250){
    for(int e = 150; e < width; e += 250){
      if(i%3>1){
      red = 255;
      green = 0;
      blue = 0;
    } else if(i%3>0){
      red = 0;
      green = 255;
      blue = 0;
    } else {
      red = 0;
      green = 0;
      blue = 255;
    }
      attractors.add(new SuperAttractor(50, i,e,red,green,blue));
    }
  }
  smooth();
}


void draw() {

  //changing the alpha of this background rectangle will change the length of the creature's 'tails'
 fill(255,255,255,80);
 rect(0,0,width,height);
 
 
 //stuff for movers
 for (Mover mover : movers) {
      
   mover.separate(movers);
   mover.align(movers);
      
   for (SuperAttractor attractor : attractors) {
      attractor.attract(mover);
    }
    
    mover.repelMouse();
    mover.run();
 }

  //everything for attractors
  for (SuperAttractor attractor : attractors) {
     attractor.display();
  }
      
      
//on mouse press, make movers      
if(mousePressed){
  //make a mover
  movers.add(new Mover(5, random(0, width), random(0, height),5));
}

//when making movie
//saveFrame("eco#####.png");
}












