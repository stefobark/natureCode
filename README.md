# natureCode #
Learning from [the Nature of Code](http://natureofcode.com/book/)

###Summary###
I'm using some of Reynold's steering algorithms. The SuperAttractors grow if they encounter movers and they share their color with those movers. Movers align with the average velocity of other movers in their vicinity ("neighborhood"), but if they get too close, they begin to repel. It looks like they're flocking around autonomously because underneath them the SuperAttractors are pushing and pulling them as they grow. 

I started to implemented a 'lifespan'. I think I'll reduce their lifespan on every update() but add to it if ... some condition is fulfilled... maybe I'll make a food object, or a certain region that represents food. And, I might make a predator object that 'kills' movers when they touch. And, the movers also face the direction of their velocity, which is pretty cool.

####ecosystem.pde ####
The main program. I started to bring in toxiclibs in order to make chains of movers attached by springs, but I haven't finished this yet.

####Movers.pde####
The class for movers.

####SuperAttractor.pde####
The class for super attractors.

####Liquid.pde####
The class for liquid. I'm not using this now, but it's handy to have around.

