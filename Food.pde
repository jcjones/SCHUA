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
 public class Food extends MovableObject
{
  Vec3D gravity;
  boolean rising;
  
  public Food(Vec3D p) { 
    super(p); 
    Mass = 1.0;    
    Behaviour = new SlowTurning(this);
    gravity = new Vec3D(0.0,-9.8/6,0.0);
    rising = false;
    
    Name = "Food";
    Live = false;
  }
  
  public void Draw() {    
    setMaterialDiffuseColor(0.2f,0.8f,0.3f,1.0f);
    
    GLUquadric quadric = glu.gluNewQuadric();
    glu.gluCylinder(quadric, 250.0, 00.0, 800.0, 16, 8);
    
    /* Caps */
    setMaterialDiffuseColor(0.9f,0.9f,0.1f,1.0f);    
    glu.gluDisk(quadric, 0.0, 100.0, 16, 8);
    
//    gl.glTranslatef(0, 0, 1000.0);
//    gl.glRotatef(-180.0f, 1.0f, 0.0f, 0.0f);
//    glu.gluDisk(quadric, 0.0, 100.0, 16, 8);   
    
    glu.gluDeleteQuadric(quadric);
    
  }  
 
  /* Customized update to allow for decoupled velocity/heading 
   * WARNING: This funciton keeps "Velocity" but only uses it for heading! */
  public void Update(float deltaTime) {    
    Vec3D SteeringForce = Behaviour.Calculate(deltaTime);
    Vec3D Sep = ((SlowTurning)Behaviour).QuasiMovement();

    /* Deal with rising / falling  */
    if (Position.v[1] < -.8*OuterWallRadius)
    {
      rising = true;
      gravity.ScaleS(-1);      
    }
    if (Position.v[1] > 0 && rising)
    {
      rising = false;
      gravity.ScaleS(-1);
    }

    /* F = m*a -> a = F/m */  
    Vec3D Acceleration = SteeringForce.DividedBy(Mass);    
    /* Increase velocity */
    Velocity.AddS(Acceleration.Scale(deltaTime));
        
    /* Clip values */
    Velocity.ClipS(MaxVelocity);
    
    /* Adjust position using gravity, ignoring Velocity */
    Position.AddS(gravity.Scale(deltaTime).Add(Sep).Scale(DILATION));
    
    /* Update heading if the vehicle has a nonzero velocity */
    if (Velocity.Magnitude2() > 0.0000001)
    {
      Heading = Velocity.Normalize();
      Side = Heading.Perp();
    }        
    
  } 
}

public class SlowTurning extends SteeringBehaviour {

  public SlowTurning(MovableObject s)
  {
    super(s);
    WanderDistance = 0.0f;
    WanderRadius = 1.0f;
    OuterMargin = 800.0f;
    InnerMargin = 10.0f;
  }

  public Vec3D Calculate(float deltaTime){    
    return Wander(deltaTime);
  }
  
  public Vec3D QuasiMovement()
  {
    FindNeighbors(NeighborRadius);
    return Separation().Scale(0.4).Add(AvoidWalls().Scale(1.5));
  }

}
