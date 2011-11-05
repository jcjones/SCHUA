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
 public class MovableObject
{
  public Vec3D Position, Velocity, Heading, Side;
  public float Mass, AxisRotation, BoundRadius, MaxVelocity, MaxTurnRate, MaxForce;
  
  public SteeringBehaviour Behaviour;
  public int Species;
  public boolean Carnivorous;
  public boolean Live;
  
  public int NumberOfThingsEaten;
  
  public int serialNumber;
  
  protected final float DILATION = 75.0f;
  
  public MovableObject(Vec3D p) {
    Position = p;
    Velocity = new Vec3D();
    
    Heading = RandomVec(); // avoid fully zero headings which will cause problems.
    Heading.NormalizeS();
    Side = Heading.Perp();   
    
    AxisRotation = 180.0f;
    
    BoundRadius = 1.0f;
    
    Behaviour = new SteeringBehaviour(this);
    
    MaxVelocity = 6.0f;
    MaxTurnRate = 25.0f;
    MaxForce = 100.0f;
    
    Mass = 1.0;
    
    serialNumber = globalSerialNumber++;
    
    NumberOfThingsEaten = 0;
    
    Species = 0;
    Carnivorous = false;
    Live = true;
  }
  
  public void Draw() {
  }
  
  public final void DrawAxes()
  {
    if (!drawAxes)
      return;
  
    final float len = 5000.0f;
    gl.glLineWidth (5);    
    
    setMaterialDiffuseColor (1.0f, 0.0f, 0.0f, 1.0f);
    gl.glBegin(GL.GL_LINES);
      gl.glVertex3f(0.0f, 0.0f, 0.0f);
      gl.glVertex3f(len, 0.0f, 0.0f);
    gl.glEnd();
    setMaterialDiffuseColor (0.0f, 1.0f, 0.0f, 1.0f);
    gl.glBegin(GL.GL_LINES);
      gl.glVertex3f(0.0f, 0.0f, 0.0f);
      gl.glVertex3f(0.0f, len, 0.0f);
    gl.glEnd();
    setMaterialDiffuseColor (0.0f, 0.0f, 1.0f, 1.0f);
    gl.glBegin(GL.GL_LINES);
      gl.glVertex3f(0.0f, 0.0f, 0.0f);
      gl.glVertex3f(0.0f, 0.0f, len);
    gl.glEnd();    
  }
  
  public final String Name() {
    return Name + " " + serialNumber + ":" + Species;
  }
  
  public String Name = "Generic object";  
  
  public final String toString()
  {
    return Name() + " at pos " + Position + " hdg " + Heading + " vel " + Velocity;
  }
  
  protected void enforceWalls() {
    float posMag = Position.Magnitude2();
    if (posMag < OuterWallRadius*OuterWallRadius)
      return;
      
    // We're beyond the walls! Shit! Slam on the brakes and stop us
    Velocity.ScaleS(0.025f);
    // Now scale back our position so that we end up within the walls again
    Position.ScaleS( (OuterWallRadius*OuterWallRadius) / posMag );
    
    debug(0, Name() + " says 'OUCH!'");
  }
  
  public void Update(float deltaTime) {    
    Vec3D SteeringForce = Behaviour.Calculate(deltaTime);
    debug(4, this.Name() + " Steering Force: " + SteeringForce);

    /* F = m*a -> a = F/m */  
    Vec3D Acceleration = SteeringForce.DividedBy(Mass);    

    /* Increase velocity */
    Velocity.AddS(Acceleration.Scale(deltaTime));
    
//    Velocity = Behaviour.Velocity();
    
    /* Clip values */
    Velocity.ClipS(MaxVelocity);
    
    /* Adjust position */
    Position.AddS(Velocity.Scale(deltaTime).Scale(DILATION));
    
    /* Enforce Walls */
    enforceWalls();
    
    /* Update heading if the vehicle has a nonzero velocity */
    if (Velocity.Magnitude2() > 0.0000001)
    {
      Heading = Velocity.Normalize();
      Side = Heading.Perp();
    }
    
  }
  
}
