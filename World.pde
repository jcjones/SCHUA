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
 
import java.util.Random;
Random r = new Random();

float lrx, lry;

float bound(float v, float lo, float hi)
{
  if (v > hi)
    return hi;
  if (v < lo)
    return lo;
  return v;
}

/* Return a number between -1.0 and 1.0 */
public float RandomClamped()
{
  return (r.nextFloat()*2.0f)-1.0f;
}

public Vec3D randomPosition()
{
  float multiplicativeFactor = .7*OuterWallRadius;
  float x = r.nextFloat() * multiplicativeFactor * 2 - multiplicativeFactor;
  float y = r.nextFloat() * multiplicativeFactor * 2 - multiplicativeFactor;
  float z = r.nextFloat() * multiplicativeFactor * 2 - multiplicativeFactor;
  return new Vec3D(x, y, z);
}

public Vec3D randomFoodPosition()
{
  float multiplicativeFactor = OuterWallRadius*.8;
  float smallVariation = 4000.0f;
  float x = r.nextFloat() * smallVariation * 2 - smallVariation;
  float y = r.nextFloat() * smallVariation * 2 + multiplicativeFactor;
  float z = r.nextFloat() * smallVariation * 2 - smallVariation;
  return new Vec3D(x, y, z);  
}

public Vec3D RandomVec()
{
  return new Vec3D((r.nextFloat()*2.0-1.0), (r.nextFloat()*2.0-1.0), (r.nextFloat()*2.0-1.0));
}

public void RotateMatrixAlongHeading(Vec3D Heading, Vec3D Side)
{
    final float epsilon = .000001;

    float norm,ux,uy,uz,rx,ry,rz,cx,cy,cz;
    norm = Heading.Magnitude();
    
    /* Heading vector */
    ux = Heading.v[0]/norm;
    uy = Heading.v[1]/norm;
    uz = Heading.v[2]/norm;

    /* Right-pointing vector with 0 in the z.*/
    rx = Side.v[0];
    ry = Side.v[1];
    rz = Side.v[2];
    
    norm = Side.Magnitude();
    rx /= norm;
    ry /= norm;
    rz /= norm;    
    
    if ((abs(ux) < epsilon) && (abs(uy) < epsilon))
    {
      /* Solution is indeterminable, use last vector */
//      rx = 0; ry = 1; rz = 0;
      rx = lrx; ry = lry;
    } else {
      lrx = rx; lry = ry;
    }
       
    /* c[xyz] is the cross product of the first two columns, e.g. perpendicular. */
    cx = uy * rz - ry * uz;
    cy = uz * rx - rz * ux;
    cz = ux * ry - rx * uy;

    norm = sqrt(cx*cx+cy*cy+cz*cz);
    cx /= norm;
    cy /= norm;
    cz /= norm;
    
//    println("ABS: " + abs(ux) + " u{"+ux+","+uy+","+uz+"} r{"+rx+","+ry+","+rz+"} c{"+cx+","+cy+","+cz+"}");
                
    /* Construct the matrix */
    float qmat[] = new float[16];

    qmat[0]=ux;
    qmat[1]=rx;
    qmat[2]=cx;
    qmat[3]=0;
    // row 1
    qmat[4]=uy;
    qmat[5]=ry;
    qmat[6]=cy;
    qmat[7]=0;
    // row 2
    qmat[8]=uz;
    qmat[9]=rz;
    qmat[10]=cz;
    qmat[11]=0;
    // row 3
    qmat[12]=0;
    qmat[13]=0;
    qmat[14]=0;
    qmat[15]=1;

    gl.glMultMatrixf(qmat);
}

public Vec3D PointToWorldSpace(Vec3D Point, Vec3D Heading, Vec3D Side, Vec3D Position)
{
  /* Since we need to do matrix ops and Java has no class for it, and Processing's matrix
   * isn't too evident as to its methodology to get data out of it, we're going to use
   * OpenGL. Fear me. */
  gl.glMatrixMode(GL.GL_MODELVIEW);
  
  gl.glPushMatrix();
  gl.glLoadIdentity();
  
  /* Translate into position */
  gl.glTranslatef(Position.v[0], Position.v[1], Position.v[2]);

  /* Rotate like we do a model */
  RotateMatrixAlongHeading(Heading, Side);


  /* Transform the translation point through a matrix multiplication */
  float[] mat = new float[16];
  float x, y, z;
  
  gl.glGetFloatv(GL.GL_MODELVIEW_MATRIX, mat);
  x = mat[0*4+0]*Point.v[0] + mat[1*4+0]*Point.v[1] + mat[2*4+0]*Point.v[2] + mat[3*4+0];
  y = mat[0*4+1]*Point.v[0] + mat[1*4+1]*Point.v[1] + mat[2*4+1]*Point.v[2] + mat[3*4+1];
  z = mat[0*4+2]*Point.v[0] + mat[1*4+2]*Point.v[1] + mat[2*4+2]*Point.v[2] + mat[3*4+2];

  gl.glPopMatrix();  

//  println("Old: " + Point + " New: " + "("+x+","+y+","+z+")");

  return new Vec3D(x, y, z);
}
