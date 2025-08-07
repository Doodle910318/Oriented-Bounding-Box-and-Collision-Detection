# Oriented-Bounding-Box-and-Collision-Detection
  As industrial automation flourishes, human–machine collaboration has become the norm in industry, making collision-avoidance technologies ever more critical. From drones and autonomous vehicles to machine tools and robotic arms, a well-designed collision-avoidance system not only prevents damage and reduces costs for both humans and machines, but also narrows the gap between them, enabling smoother cooperation.

  An OBB (Oriented Bounding Box) encloses an object in a rectangular prism whose axes can rotate. Because OBBs combine this rotational flexibility with a relatively simple collision-detection scheme, they perform excellently at detecting collisions quickly in the very first stage. Their drawback is that generating an OBB takes longer than creating an AABB.

  This project validates and simulates the approach using C and Verilog. The current focus is on the correctness of the algorithm and its functions, with the bounding volume and collision-detection space set to 256 × 256 cm (including signed arithmetic). Future work will refine the design for specific object types.
