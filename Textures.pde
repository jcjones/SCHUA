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
 int[] textureCollection = new int[5];
boolean texturesOn = true;

void PrepareTexture(String filename, boolean wrap, int ID) {
  /* LOAD TEXTURES */  
  PImage tex = loadImage(filename);

  IntBuffer buffer = IntBuffer.wrap(tex.pixels);
  buffer.rewind();

  // Be efficient in jOGL
  gl.glPixelStorei(GL.GL_UNPACK_ALIGNMENT, 1);
  // select our current texture
  gl.glBindTexture(GL.GL_TEXTURE_2D, ID);
  // copy texture to video card's texture memory -- our load uses BGRA_EXT.
  gl.glTexImage2D(GL.GL_TEXTURE_2D, 0, 4, tex.width, tex.height, 0, GL.GL_BGRA, GL.GL_UNSIGNED_BYTE, buffer);
  
  // Set wrapping
  gl.glTexParameteri(GL.GL_TEXTURE_2D, GL.GL_TEXTURE_WRAP_S, GL.GL_REPEAT);
  gl.glTexParameteri(GL.GL_TEXTURE_2D, GL.GL_TEXTURE_WRAP_T, GL.GL_REPEAT);
  
  // when texture area is large, bilinear filter the first mipmap
  gl.glTexParameterf(GL.GL_TEXTURE_2D, GL.GL_TEXTURE_MAG_FILTER, GL.GL_LINEAR);
  // when texture area is small, bilinear filter the nearest  
  gl.glTexParameterf(GL.GL_TEXTURE_2D, GL.GL_TEXTURE_MIN_FILTER, GL.GL_LINEAR);
  
  // select modulate to mix texture with color for shading
  gl.glTexEnvf( GL.GL_TEXTURE_ENV, GL.GL_TEXTURE_ENV_MODE, GL.GL_MODULATE );
  
  gl.glMaterialfv(GL.GL_FRONT_AND_BACK, GL.GL_SHININESS, mat_shininess, 0);
  gl.glMaterialfv(GL.GL_FRONT_AND_BACK, GL.GL_SPECULAR, mat_specular, 0);
  gl.glMaterialfv(GL.GL_FRONT_AND_BACK, GL.GL_DIFFUSE, mat_diffuse, 0);
  gl.glMaterialfv(GL.GL_FRONT_AND_BACK, GL.GL_AMBIENT, mat_ambient, 0);  

  /* END LOAD TEXTURES */
}

/* This function is final to suggest that it be inlined */
final void setMaterialDiffuseColor(float r, float g, float b, float a) {
    float[] mat_diffuse_color = {r,g,b,a};
    gl.glMaterialfv(GL.GL_FRONT_AND_BACK, GL.GL_DIFFUSE, mat_diffuse_color, 0);    
}

void LoadTextures() {
  /* Allocate memory for N textures below */
  gl.glGenTextures(4, textureCollection, 0);

  PrepareTexture("basic.jpg", false, textureCollection[0]); 
  PrepareTexture("dolphin.jpg", false, textureCollection[1]); 
  PrepareTexture("shark.jpg", false, textureCollection[2]); 
  PrepareTexture("basic.jpg", false, textureCollection[3]);   
}

void textureStop() {
  gl.glMatrixMode(GL.GL_TEXTURE);
  gl.glPopMatrix();
  gl.glMatrixMode(GL.GL_MODELVIEW);  
  
  gl.glDisable(GL.GL_TEXTURE_GEN_T);
  gl.glDisable(GL.GL_TEXTURE_GEN_S);
  gl.glDisable(GL.GL_TEXTURE_2D);
}

/* This is the sea-looking top texture. */
void textureBasic(float textureScale) {
  if (texturesOn)
  {
    float s_plane[] = { 0, 1, 0, 0 };
    float t_plane[] = { 1, 0, 0, 0 };
    
    // Set Texture
    gl.glEnable(GL.GL_TEXTURE_2D);
    // Select texture
    gl.glBindTexture(GL.GL_TEXTURE_2D, textureCollection[0]);
    // Generate texture coordinates
    gl.glTexGeni(GL.GL_S, GL.GL_TEXTURE_GEN_MODE, GL.GL_EYE_LINEAR);
    gl.glTexGeni(GL.GL_T, GL.GL_TEXTURE_GEN_MODE, GL.GL_EYE_LINEAR);
    // Setup the EYE_LINEAR options
    gl.glTexGenfv(GL.GL_S, GL.GL_EYE_PLANE, s_plane, 0);
    gl.glTexGenfv(GL.GL_T, GL.GL_EYE_PLANE, t_plane, 0);
  
    // Enable texture coordinates
    gl.glEnable(GL.GL_TEXTURE_GEN_S);
    gl.glEnable(GL.GL_TEXTURE_GEN_T);
  }
  
  // Scale the texture
  gl.glMatrixMode(GL.GL_TEXTURE);
  gl.glPushMatrix();
  
  gl.glLoadIdentity();
  gl.glScalef(textureScale, textureScale, 1);
  gl.glMatrixMode(GL.GL_MODELVIEW);  
}


