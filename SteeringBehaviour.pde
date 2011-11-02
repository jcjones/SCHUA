/* 
 * SCHUA: The SCHooling User-interactive Aquarium
 * - Created for Paul Fishwick's CAP5805 "Simulation Concepts" course at the 
 *   University of Florida in November 2005
 * Copyright (c) 2005 James C. Jones <jcjones AT ufl DOT edu>
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this 
 * software and associated documentation files (the "Software"), to deal in the Software 
 * without restriction, including without limitation the rights to use, copy, modify, 
 * merge, publish, distribute, sublicense, and/or sell copies of the Software, and to 
 * permit persons to whom the Software is furnished to do so, subject to the following 
 * conditions:
 * 
 * The above copyright notice and this permission notice shall be included in all copies 
 * or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
 * INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A 
 * PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT 
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF 
 * CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR 
 * THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
public class SteeringBehaviour {
  MovableObject self;

  public float WanderJitter = 0.5;
  public float WanderRadius = 10;
  public float WanderDistance = 100;    
  Vec3D WanderTarget;

  public float NeighborRadius = 10000;  
  ArrayList Neighbors;
  ArrayList VisibleNeighbors;
  
  public float SeparationScalar = 100;
  
  public float OuterMargin = 5000.0f;
  public float InnerMargin = 500.0f;

  protected MovableObject huntTarget;
  protected long huntTargetLastSeenTime;
  protected long huntTargetMemoryLength = 30000; // 1000ths of a second
  protected float huntEatingDistance = 1300.0;

  Vec3D accumulatedForce;
  
  public float AvoidWeight = 20.0;
  public float HuntWeight = 10.0;
  public float XenoWeight = 2.0;
  public float FearWeight = 5.0;
  public float SepWeight = 10.0;
  public float AliWeight = 8.0;
  public float CohWeight = 4.0;
  public float WanWeight = 1.0;      
  
  int timeOfUpdate;

  public SteeringBehaviour(MovableObject s)
  {
    self = s;
    Neighbors = new ArrayList();
    VisibleNeighbors = new ArrayList();
    WanderTarget = new Vec3D();
    
    timeOfUpdate = r.nextInt(10);
    
    accumulatedForce = new Vec3D();
  }

  public Vec3D Calculate(float deltaTime){  
    // this takes time, so don't do it all the time    
    if (microTimeStep == timeOfUpdate)
      FindNeighbors(NeighborRadius);
      
    accumulatedForce.Zero();
    
    if (!AccumulateForce(AvoidWalls().Scale(AvoidWeight), accumulatedForce))
      return accumulatedForce;
    debug(1, self.Name()+" Avoid: " + accumulatedForce);

    if (!AccumulateForce(Hunt().Scale(HuntWeight), accumulatedForce))
      return accumulatedForce;
    debug(1, self.Name()+" Hunt: " + accumulatedForce);    

    if (!AccumulateForce(Fear().Scale(FearWeight), accumulatedForce))
      return accumulatedForce;
    debug(1, self.Name()+" Fear: " + accumulatedForce);                
                                    
    if (!AccumulateForce(Separation().Scale(SepWeight*SepFactor), accumulatedForce))
      return accumulatedForce;
    debug(1, self.Name()+" Sep: " + accumulatedForce);
    
    if (!AccumulateForce(Alignment().Scale(AliWeight*AliFactor), accumulatedForce))
      return accumulatedForce;
    debug(1, self.Name()+" Align: " + accumulatedForce);      
    
    if (!AccumulateForce(Cohesion().Scale(CohWeight*CohFactor), accumulatedForce))
      return accumulatedForce;
    debug(1, self.Name()+" Cohes: " + accumulatedForce);      
    
    if (!AccumulateForce(Wander(deltaTime).Scale(WanWeight), accumulatedForce))
      return accumulatedForce;
    debug(1, self.Name()+" Wand: " + accumulatedForce);                    
    
    return accumulatedForce;
  }
  
  public boolean AccumulateForce(Vec3D toAdd, Vec3D runTotal) {
    float usedSoFar = runTotal.Magnitude();
    float remaining = self.MaxForce - usedSoFar;
    if (remaining <= 0.0) return false;
    
    float magToAdd = toAdd.Magnitude();
    
    if (magToAdd < remaining) 
      runTotal.AddS(toAdd);
    else
      runTotal.AddS( toAdd.Normalize().Scale(remaining) );
      
    return true; 
  }
  
  public boolean CanSee(Vec3D positionToSee)
  {
    Vec3D checkPosNorm = positionToSee.Normalize();
    Vec3D myHdgNorm = self.Heading.Normalize();
    
    float dot = myHdgNorm.Dot(checkPosNorm);
    return (dot > 0.0);
  }
  
  public void FindNeighbors(float radius) {
    Neighbors.clear();
    VisibleNeighbors.clear();
    
    for(int i=0; i<fishes.size(); ++i) {
      MovableObject current = (MovableObject)fishes.get(i);
      
      /* Calculate range based on target's bounding radius */
      float range = radius + current.BoundRadius;
      
      /* Get the range vector between positions */
      Vec3D to = current.Position.Sub(self.Position);
      
      /* Work in squared space to avoid sqrts */
      if ( ( self != current ) && ( to.Magnitude2() < range*range ) ) {
        /* It's a physical neighbor...*/
        Neighbors.add(current);
        
        /* But a visible one only if in front of me */        
        if (CanSee(current.Position)){
          VisibleNeighbors.add(current);
        }
        
      }
    }
  }
  
  public Vec3D Wander(float deltaTime) {
    float jitterThisTime = WanderJitter * deltaTime;
    Vec3D tmp = new Vec3D(RandomClamped()*WanderJitter,
                                RandomClamped()*WanderJitter,
                                RandomClamped()*WanderJitter);
    debug(2, "Jitt" + tmp);
    WanderTarget.AddS(tmp);
    WanderTarget.NormalizeS();
    WanderTarget.ScaleS(WanderRadius);
    debug(2, "ScaleS" + WanderTarget);
    Vec3D target = WanderTarget.Add(new Vec3D( WanderDistance, 0, 0));
    debug(2,"DistA" + target);
    Vec3D WorldTarget = PointToWorldSpace(target, self.Heading, self.Side, self.Position);
    
    return WorldTarget.Sub(self.Position);
  }
  
  public Vec3D Seek(Vec3D targetPos) {
    Vec3D velocity = targetPos.Sub(self.Position).Normalize().Scale(self.MaxVelocity);
    return velocity.Sub(self.Velocity);
  }
  
  public Vec3D Flee(Vec3D targetPos) {
    Vec3D velocity = self.Position.Sub(targetPos).Normalize().Scale(self.MaxVelocity);
    return velocity.Sub(self.Velocity);
  }
  
  public Vec3D Pursuit(MovableObject target) {
    Vec3D toTarget = target.Position.Sub(self.Position);
    float RelativeHeading = self.Heading.Dot(target.Heading);
    // If the target is straight ahead, just seek.
    if ( (toTarget.Dot(self.Heading) > 0) && (RelativeHeading < -0.95) ) // arcCos(0.95)=~18 degs
      return Seek(target.Position);
      
    // Not "ahead" so let's predict 
    float lookAheadTime = toTarget.Magnitude() / ( self.MaxVelocity + target.Velocity.Magnitude() );
    return Seek(target.Position.Add(target.Velocity.Scale(lookAheadTime)));    
  }
  
  public Vec3D Evade(MovableObject pursuer) {
    Vec3D toPursuer = pursuer.Position.Sub(self.Position);
    float lookAheadTime = toPursuer.Magnitude() / ( self.MaxVelocity + pursuer.Velocity.Magnitude() );
    return Flee(pursuer.Position.Add(pursuer.Velocity.Scale(lookAheadTime)));
  } 
  
  public Vec3D Separation() {
    Vec3D repulsion = new Vec3D();
    
    for (int i=0; i<Neighbors.size(); ++i) {
      MovableObject target = (MovableObject)Neighbors.get(i);
      
      if (target == huntTarget)
        continue; // Don't separate from our target of feasting!
    
      Vec3D to = self.Position.Sub(target.Position);
      to = to.Normalize().Scale(1/to.Magnitude());
      
      // More separation if it's of unlike species, based on XenoFactor.
      if (target.Species != self.Species)
        to.ScaleS(XenoFactor*XenoWeight);
        
      repulsion.AddS( to );
    }
    
    debug(3, self.Name()+" AvoidForce: " + repulsion);
    
    return repulsion.Scale(SeparationScalar);
  }
  
  public Vec3D Alignment() {
    Vec3D averageHeading = new Vec3D();
    int countOfFriends = 0;    
    
    for (int i=0; i<VisibleNeighbors.size(); ++i) {
      MovableObject target = (MovableObject)VisibleNeighbors.get(i);
      if (target.Species != self.Species)
        continue; // Don't align to different species
      
      averageHeading.AddS(target.Heading);
      countOfFriends++;
    }
    
    /* If there's one or more neighbor, average the headings, then return the difference */
    if (countOfFriends > 0) {
      averageHeading.ScaleS(1/countOfFriends);
      averageHeading.SubS(self.Heading);
    }

    debug(3, self.Name()+" AlignForce: " + averageHeading);
    
    return averageHeading;    
  }
  
  public Vec3D Cohesion() {
    Vec3D centerOfMass = new Vec3D();
    Vec3D toPointer = new Vec3D();
    int countOfFriends = 0;

    for (int i=0; i<VisibleNeighbors.size(); ++i) {
      MovableObject target = (MovableObject)VisibleNeighbors.get(i);
      if (target.Species != self.Species)
        continue; // Don't cohere to different species
      centerOfMass.AddS(target.Position);
      countOfFriends++;
    }
    
    /* If there's one or more neighbor, average the headings, then return the difference */
    if (countOfFriends > 0) {
      centerOfMass.ScaleS(1/countOfFriends);
      toPointer = Seek(centerOfMass);
    }    

    debug(3, self.Name()+" CohesionForce: " + toPointer);
                        
    return toPointer;
  }
  
  public Vec3D AvoidWalls()
  {
    // OuterWallRadius and InnerWallRadius are global and defined in AquariumFlocking    
        
    float posMag = self.Position.Magnitude();

    Vec3D avoidPointer;
    
    if (OuterWallRadius-posMag < OuterMargin)
    {
      float f = (OuterWallRadius-posMag)*(OuterWallRadius-posMag)*(OuterWallRadius-posMag)*(OuterWallRadius-posMag);
      
      if (abs(f) < Vec3D.epsilon)
        f = Vec3D.epsilon;

      avoidPointer = Seek(self.Position.Scale(-1));
      
      debug(3, self.Name()+" O_WallAvoidanceForce: " + avoidPointer);
      return avoidPointer;
    }
    
    if (InnerWallRadius-posMag > InnerMargin)
    {
      avoidPointer = Seek(self.Position.Scale(abs(InnerWallRadius+InnerMargin-posMag)) );
            
      debug(3, self.Name()+" I_WallAvoidanceForce: " + avoidPointer);
      return avoidPointer;
    }
    
    return new Vec3D();
  }
  
  public void targetDecision() {
    // We only consider things in our cone of visibility
    for (int i=0; i<VisibleNeighbors.size(); ++i) {
      MovableObject target = (MovableObject)VisibleNeighbors.get(i);
      
      // See whether we're looking for non-self species, or just fish food
      if (self.Carnivorous && target.Species != self.Species ) {
        // This is fresh meat. Go for it!
        huntTarget = target;        
        return;
      } else if (self.Species > 1 && !target.Live) {
        // This is food and we're not sharks (which won't attack dead stuff).
        huntTarget = target;
        return;
      }
    }
    // We found no food.
    huntTarget = null;
  }
  
  public Vec3D Hunt()
  {
//    long huntTargetLastSeenTime;
//    MovableObject huntTarget;
    Vec3D toPointer;

    // Look for our target if we have one
    if (huntTarget != null && VisibleNeighbors.indexOf(huntTarget) >= 0)
      huntTargetLastSeenTime = millis(); // Saw it!

    // Consider looking for a new target
    if (microTimeStep == timeOfUpdate)
      if (huntTarget == null || (millis()-huntTargetLastSeenTime) > huntTargetMemoryLength)
        targetDecision(); // find new target
    
    // We have no target...
    if (huntTarget == null)
      return new Vec3D();
      
    // Check if we're within chomping distance
    toPointer = huntTarget.Position.Sub(self.Position);
    if (toPointer.Magnitude2() < huntEatingDistance * huntEatingDistance) {
      eat(huntTarget, self);
      huntTarget = null;
      return new Vec3D();
    }

    debug(5, self.Name()+ " Hunting " + huntTarget.Name() + " dist is " + toPointer.Magnitude());
            
    // Find a vector to our tasty treat and return it.    
    toPointer = Pursuit(huntTarget);    
    return toPointer;
  }
  
  public Vec3D Fear()
  {
    Vec3D toPointer = new Vec3D();
    
    for (int i=0; i<VisibleNeighbors.size(); ++i) {
      MovableObject target = (MovableObject)VisibleNeighbors.get(i);
      if (target.Species != self.Species) {
        if (target.Carnivorous) {        
          Vec3D to = self.Position.Sub(target.Position);
          debug(5, self.Name()+ " Fleeing " + target.Name() + "!! dist is " + to.Magnitude());              
          toPointer = Evade(target).Scale(1/( to.Magnitude()/ 10 ) );
          break; // Only flee one...
        }
      }
    }
  
    debug(3, self.Name()+" FearForce: " + toPointer);
    return toPointer;
  }

}
