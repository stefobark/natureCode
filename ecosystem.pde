// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

Mover[] movers = new Mover[300];
Shaker[] shakers = new Shaker[300];

SuperAttractor topAttractor;

UnFriendly[] unfriendlies = new UnFriendly[10];
Friendly[] friendlies = new Friendly[10];

// Liquid
//Liquid liquid;

float g = 0.4;

void setup() {
  size(1600,1000);
  
  //make some liquid
  //liquid = new Liquid(0, 500, width, height/2, 0.9);
  
  //make all the unfriendlies
  for (int i = 0; i < unfriendlies.length; i++) {
    unfriendlies[i] = new UnFriendly(random(20,80),random(width),random(height)); 
  }
  
   //make all the friendlies
  for (int i = 0; i < friendlies.length; i++) {
    friendlies[i] = new Friendly(random(20,80),random(width),random(height)); 
  }
  
  //set top and bottom attractors
  topAttractor = new SuperAttractor(50);
   
   //bring in all the movers
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover(random(0.1,80),random(width),random(height)); 
  }
 
 //bring in all the shakers
  for (int j = 0; j < shakers.length; j++) {
    shakers[j] = new Shaker(random(0.1,80),random(width),random(height)); 
  }

}



void draw() {
  //changing the alpha will change the length of the creatures 'tails'
 fill(255,255,255,255);
 rect(0,0,width,height);
 

 /* taking out liquid for now
 
  liquid.display();
for (int i = 0; i < shakers.length; i++) {
    
    // Is the Shaker in the liquid?
    if (liquid.containsShaker(shakers[i])) {
      // Calculate drag force
      PVector dragForce = liquid.dragShaker(shakers[i]);
      // Apply drag force to Shaker
      shakers[i].applyForce(dragForce);
    }
 }
 
  for (int i = 0; i < unfriendlies.length; i++) {
    
    // Is the Unfriendly in the liquid?
    if (liquid.containsUnfriendly(unfriendlies[i])) {
      // Calculate drag force
      PVector dragForce = liquid.dragUnfriendly(unfriendlies[i]);
      // Apply drag force to Unfriendly
      unfriendlies[i].applyForce(dragForce);
    }
 }
 

 
 for (int i = 0; i < movers.length; i++) {
    
    // Is the Mover in the liquid?
    if (liquid.containsMover(movers[i])) {
      // Calculate drag force
      PVector dragForce = liquid.dragMover(movers[i]);
      // Apply drag force to Mover
      movers[i].applyForce(dragForce);
    }
 }
*/


//repel all movers from all movers and the mouse
  for (int i = 0; i < movers.length; i++) {
    PVector mouseForce = movers[i].repelMouse(movers[i]);
    movers[i].applyForce(mouseForce);
    for (int j = 0; j < movers.length; j++) {
      if (i != j) {
        PVector force = movers[j].repel(movers[i], 20);
        movers[i].applyForce(force);
       
      }
    }
    
//for all the unfriendlies, look at all the movers and apply the repel force to em
    for (int x = 0; x < unfriendlies.length; x++) {
      for (int t = 0; t < movers.length; t++) {
        PVector repelForce = unfriendlies[x].repelMover(movers[t]);
        movers[t].applyForce(repelForce);
      }
    }
    
//for all the friendlies, look at all the movers and apply the repel force to em
    for (int x = 0; x < friendlies.length; x++) {
      for (int t = 0; t < movers.length; t++) {
        PVector attractForce = friendlies[x].attractMover(movers[t]);
        movers[t].applyForce(attractForce);
      }
    }
    
    //attract the mover to the static attractor at top and middle
    topAttractor.attractMover(movers[i]);
    
    //now, look at all the shakers and attract to them if distance is less than 200
    for (int u = 0; u < unfriendlies.length; u++) {
      movers[i].checkShaker(shakers[u],400);
    }
    movers[i].checkEdges();
    movers[i].update();
    movers[i].display();
  }
   
  //do all the same stuff for shakers
  for (int i = 0; i < shakers.length; i++) {
    PVector mouseForce = shakers[i].repelMouse(shakers[i]);
    shakers[i].applyForce(mouseForce);
    for (int j = 0; j < shakers.length; j++) {
      if (i != j) {
        PVector force = shakers[i].repel(shakers[j],10);
        shakers[j].applyForce(force);
      }
    }
    
    //for all the unfriendlies, look at all the shakers and apply the repel force to em
    for (int x = 0; x < unfriendlies.length; x++) {
      for (int t = 0; t < shakers.length; t++) {
        PVector repelForce = unfriendlies[x].repelShaker(shakers[t]);
        shakers[t].applyForce(repelForce);
      }
    }
    
//for all the friendlies, look at all the shakers and apply the repel force to em
    for (int x = 0; x < friendlies.length; x++) {
      for (int t = 0; t < shakers.length; t++) {
        PVector attractForce = friendlies[x].attractShaker(shakers[t]);
        shakers[t].applyForce(attractForce);
      }
    }
    
    //attract the shaker to the super attractors
    topAttractor.attractShaker(shakers[i]);
    
    //attract to all movers
    for(int m = 0; m < movers.length; m++){
      shakers[i].checkMover(movers[m],400);
    }
    
    //bounce off the edges
    shakers[i].checkEdges();
    
    //apply motion algorithm
    shakers[i].update();
    
    //display the shaker
    shakers[i].display();
  }

//attract the unfriendly attractor, check edges and apply force, and display
  for (int i = 0; i < unfriendlies.length; i++) {
    topAttractor.attractUnfriendly(unfriendlies[i]);
        
       //attract them to the friendlies
       for (int w = 0; w < unfriendlies.length; w++) {
         friendlies[w].attractUnfriendly(unfriendlies[i]);
       }
        
      for (int j = 0; j < unfriendlies.length; j++) {
        if(i != j){
        PVector unfriendlyRepel = unfriendlies[i].attractUnfriendly(unfriendlies[j]);
        unfriendlies[i].applyForce(unfriendlyRepel);
        }
      }
      
      unfriendlies[i].checkEdges();
      unfriendlies[i].update();
      unfriendlies[i].display();
  }
  for (int i = 0; i < friendlies.length; i++) {
    topAttractor.attractFriendly(friendlies[i]);
       
      for (int j = 0; j < friendlies.length; j++) {
      if(i != j){
         friendlies[i].repelFriendly(friendlies[i]);
      }
    }
         friendlies[i].checkEdges();
         friendlies[i].update();
         friendlies[i].display();
  }
      topAttractor.update();
     
      topAttractor.display();
      
if(mousePressed){
  topAttractor = new SuperAttractor(50);
}
}













