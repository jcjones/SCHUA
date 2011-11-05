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
 
public class Vec3D {
        public float[] v;
        static final float epsilon = 0.0000001;
        
        public Vec3D(float x, float y, float z) {
          v = new float[3];
          v[0] = x;
          v[1] = y; 
          v[2] = z;
        }
        public Vec3D() {
          v = new float[3];
          v[0]=v[1]=v[2]=0.0f;
        }
        
        public void Zero() {
          v[0]=v[1]=v[2]=0.0f;
        }
        
        public Vec3D Clone() {
          return new Vec3D(v[0], v[1], v[2]);
        }
        
        public String toString() {
          return "("+v[0]+","+v[1]+","+v[2]+")";
        }        

        public float Magnitude2() {
          return v[0]*v[0]+v[1]*v[1]+v[2]*v[2];
        }

        public float Magnitude() {
          return sqrt(Magnitude2());
        }
        
        public Vec3D Add(Vec3D b) {
          return new Vec3D(v[0]+b.v[0],v[1]+b.v[1],v[2]+b.v[2]);
        }
        
        public void AddS(Vec3D b) {
          v[0]+=b.v[0];
          v[1]+=b.v[1];
          v[2]+=b.v[2];
        }
        
        public Vec3D Sub(Vec3D b) {
          return new Vec3D(v[0]-b.v[0],v[1]-b.v[1],v[2]-b.v[2]);
        }
        
        public void SubS(Vec3D b) {
          v[0]-=b.v[0];
          v[1]-=b.v[1];
          v[2]-=b.v[2];
        }        
        
        public Vec3D Scale(float f) {
          return new Vec3D(v[0]*f,v[1]*f,v[2]*f);
        }

        public void ScaleS(float f) {
          v[0]*=f;
          v[1]*=f;
          v[2]*=f;
        }
        
        public Vec3D DividedBy(float f) {
          return new Vec3D(v[0]/f, v[1]/f, v[2]/f);
        }
        
        // this and b are both normalized 
        public float Dot(Vec3D b) {
          return v[0]*b.v[0] + v[1]*b.v[1] + v[2]*b.v[2];
        }

        public Vec3D Cross(Vec3D b) {
          float nx = v[1]*b.v[2] - b.v[1]*v[2];
          float ny = v[2]*b.v[0] - b.v[2]*v[0];
          float nz = v[0]*b.v[1] - b.v[0]*v[1];
          return new Vec3D(nx, ny, nz);
        }
        
        public Vec3D Normalize() {
          float t = Magnitude();
          if (t > epsilon)
            return new Vec3D( v[0]/t, v[1]/t, v[2]/t);
          return this;
        }
        
        public void NormalizeS() {
          float t = Magnitude();
          if (t > epsilon)
          {
            v[0]/=t; v[1]/=t; v[2]/=t;
          }
        }        
        
        public Vec3D Perp() {
          /* Right-pointing vector with 0 in the z.*/
          if (v[0] < 0)
            return new Vec3D(-v[1], v[0], 0);
          return new Vec3D(-v[1], -v[0], 0);
        }

        public Vec3D Reverse() {
          return new Vec3D(-1*v[0], -1*v[1], -1*v[2]);
        }

        public Vec3D Reflect(Vec3D norm) {
          return this.Add(this.Reverse().Scale(2.0f*this.Dot(norm)));
        }

                        
        public void ClipS(float b) {
          float bm2 = b*b;
          float rm2 = this.Magnitude2();
          
          if (rm2 > bm2)
            this.ScaleS(bm2/rm2);
        }
}
