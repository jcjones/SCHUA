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

import processing.opengl.*;
import net.java.games.jogl.*;
import com.sun.image.codec.jpeg.*;
import java.util.ArrayList;

GL gl;
GLU glu;
float light_ambient[] = { 0.0, 0.0, 0.0, 1.0 };
float light_diffuse[] = { 1.0, 1.0, 1.0, 1.0 };
float light_position[] = { 0.0, -1.0, 0.0, 0.0 };
float mat_shininess[] = {90.0};
float mat_specular[] = {0.8, 0.8, 0.8, 1.0};
float mat_diffuse[] = {0.46, 0.66, 0.795, 1.0};
float mat_ambient[] = {0.0, 0.1, 0.2, 1.0};
float lmodel_ambient[] = {0.4, 0.4, 0.4, 1.0};
float lmodel_localviewer[] = {0.0};

float RRAD = 0.01745;

float theta = 0.0f;
float phi = 0.0f;
float zoom = 25000.0f; // start inside sphere

float XenoFactor = 1.0f;
float SepFactor = 1.0f;
float AliFactor = 1.0f;
float CohFactor = 1.0f;

int fps = 24;
float deltaTime = fps/100.0f; // fps in thosandths of a second

int debugLevel = 0;
int maxDebugLevel = 5;

int globalSerialNumber = 0;

float scaleVal = 0.75;

boolean drawAxes = false;
boolean drawGlobe = true;
boolean running = true;

/* World Borders */
float OuterWallRadius = 20000.0f;
float OuterWallMargin = 6000.0f;
float InnerWallRadius = 1000.0f;

ArrayList fishes;

Widget currentlyActiveWidget = null;
ArrayList widgets;
Slider sliderSepar, sliderAlign, sliderCohes, sliderXenop;
Button buttonFood, buttonFish, buttonShark, buttonDolphin, buttonGlobe, buttonLink;
Label labelDirections, labelCopyright;

PFont smallFont, mediumFont, largeFont;

int microTimeStep = 0; // Used to keep from running some CPU intensive behavior calculations every frame

void glInit()
{
/* Water color */
gl.glClearColor(0.0f,0.39f,0.7f,0.0f);

/* Camera Setup */
gl.glViewport(0,0,width, height);
gl.glMatrixMode(GL.GL_PROJECTION);
gl.glLoadIdentity();
gl.glFrustum(-1.0,1.0,-1.0,1.0,2.0f,1000.0f);
gl.glMatrixMode(GL.GL_MODELVIEW);
glu.gluLookAt(0.0f,0.0f,-1000.0f, 0.0f,0.0f,0.0f, 0.0f,1.0f,0.0f);

// Really Nice Perspective Calculations
gl.glHint(GL.GL_PERSPECTIVE_CORRECTION_HINT, GL.GL_NICEST);			

// This is in Textures.pde
LoadTextures();

// Miscellany stuff
gl.glColor4f(1.0f,1.0f,1.0f,0.6f);

/* Shading / Lighting Setup */
//gl.glEnable(GL.GL_BLEND);
//gl.glBlendFunc(GL.GL_SRC_ALPHA,GL.GL_ONE_MINUS_SRC_ALPHA);
gl.glDisable(GL.GL_DEPTH_TEST);
gl.glEnable(GL.GL_CULL_FACE);
gl.glEnable(GL.GL_NORMALIZE);
gl.glShadeModel(GL.GL_SMOOTH);

/* Lighting */
gl.glLightfv(GL.GL_LIGHT0, GL.GL_AMBIENT, light_ambient);
gl.glLightfv(GL.GL_LIGHT0, GL.GL_DIFFUSE, light_diffuse);
gl.glLightfv(GL.GL_LIGHT0, GL.GL_POSITION, light_position);
gl.glLightModelfv(GL.GL_LIGHT_MODEL_AMBIENT, lmodel_ambient);
gl.glLightModelfv(GL.GL_LIGHT_MODEL_LOCAL_VIEWER, lmodel_localviewer);
gl.glEnable(GL.GL_LIGHTING);
gl.glEnable(GL.GL_LIGHT0);
}

void setup()
{
  size(800,800, OPENGL);
  gl = ((PGraphicsGL) g).gl;
  glu = ((PGraphicsGL) g).glu;
  glInit();

  frame.setTitle("SCHUA: The Schooling User-Interactive Aquarium (http://pugsplace.net/)!");   
      
  framerate(fps);
  
  fishes = new ArrayList();
  widgets = new ArrayList();
  
  /* Build widgets */
  int buttonSize = 15;
  int sliderLength = 80;
  int rowBottom = height-25;
  int rowMiddle = height-75;
  int left = 40;
  int leftTwo = 150;
  int right = width-0-sliderLength;
  int rightTwo = width-100-sliderLength;  
  
  smallFont = loadFont("Sylfaen-12.vlw");
  mediumFont = loadFont("BitstreamVeraSerif-Bold-16.vlw");
  largeFont = loadFont("BitstreamVeraSans-Bold-32.vlw");  
//  smallFont = loadFont("CharterBT-Roman-12.vlw");  
//  largeFont = loadFont("LucidaSans-Demi-32.vlw");  
  textAlign(CENTER);

  /* Add sliders*/ 
  sliderSepar = new Slider(left, rowBottom, sliderLength, buttonSize, buttonSize, 0.5, color(120,120,120,150), color(255,255,0), color(0,255,0,200), true);  
  sliderSepar.setLabel("- Separation +");
  sliderAlign = new Slider(left, rowMiddle, sliderLength, buttonSize, buttonSize, 0.5, color(120,120,120,150), color(255,255,0), color(0,255,0,200), true);  
  sliderAlign.setLabel("- Alignment +");
  sliderCohes = new Slider(leftTwo, rowBottom, sliderLength, buttonSize, buttonSize, 0.5, color(120,120,120,150), color(255,255,0), color(0,255,0,200), true);
  sliderCohes.setLabel("- Cohesion +");
  sliderXenop = new Slider(leftTwo, rowMiddle, sliderLength, buttonSize, buttonSize, 0.5, color(120,120,120,150), color(255,255,0), color(0,255,0,200), true);
  sliderXenop.setLabel("- Xenophobia +");
  /* Add button s*/
  buttonFood = new Button(width/2, height-30, 250, 40, color(120,120,120,150), color(255,255,0), color(0,255,0,200));
  buttonFood.setLabel("Add Food");
  buttonFood.setFont(largeFont, 32);
  buttonFish = new Button(rightTwo, rowMiddle, 50, 40, color(120,120,120,150), color(255,255,0), color(0,255,0,200));
  buttonFish.setLabel("Add 10 Fish");
  buttonDolphin = new Button(right, rowMiddle, 50, 40, color(120,120,120,150), color(255,255,0), color(0,255,0,200));
  buttonDolphin.setLabel("Add Dolphin");
  buttonShark = new Button(right, rowBottom, 50, 40, color(120,120,120,150), color(255,255,0), color(0,255,0,200));
  buttonShark.setLabel("Add Shark");  
  buttonGlobe = new Button(rightTwo, rowBottom, 50, 40, color(120,120,120,150), color(255,255,0), color(0,255,0,200));
  buttonGlobe.setLabel("Toggle Globe");
  buttonLink = new Button(width-30, 20, 45, 20, color(120,120,120,150), color(255,255,0), color(0,255,0,200));
  buttonLink.setLabel("WWW");    
  labelDirections = new Label(10, 15, 300, 300, color(255,155,150), LEFT);
  labelDirections.setFont(mediumFont, 16);  
  labelDirections.setLabel("Mouse controls:\nLeft mouse + Drag = Rotate Globe.\nRight mouse + Drag = Zoom");

  labelCopyright = new Label(width/2-150, 5, 300, 300, color(255,255,255), CENTER);
  labelCopyright.setLabel("This program is free software. See LICSENSE for details.");
    
  widgets.add(sliderSepar); widgets.add(sliderAlign); widgets.add(sliderCohes); widgets.add(sliderXenop); widgets.add(buttonFood); widgets.add(buttonShark); widgets.add(buttonDolphin); widgets.add(buttonFish); widgets.add(buttonGlobe); widgets.add(buttonLink); widgets.add(labelDirections); widgets.add(labelCopyright);

  for (int i=0; i<10; i++)
    fishes.add(new Fish(randomPosition()));
} 


void mouseDragged()
{
  if (!mousePressed)
    return;
    
  if (currentlyActiveWidget != null) {
    currentlyActiveWidget.update(mouseX, mouseY);  
    return;
  }
    
  if (mouseButton == LEFT) {
      phi = (((float)mouseX/width)-0.5f)*-360.0f;
      theta = (((float)mouseY/height)-0.5f)*360.0f;     
  } else if (mouseButton == RIGHT)  {
    zoom = (((float)mouseY/height)-0.5f)*50000.0f;
  }
}

void mouseReleased()
{
  if (currentlyActiveWidget != null) {
    // Run our poor man's callback-analogues if releasing in the widget
    if (currentlyActiveWidget.mouseIn(mouseX, mouseY))
    {
      handleUIActions();
    }
    // Done with this widget 
    currentlyActiveWidget = null;
  }
}

void keyPressed() { 
  if(key == 'a') { 
    drawAxes = !drawAxes;
  }
  
  /* Add Fishes*/
  if (key == 'f') {
    fishes.add(new Fish(randomPosition()));
  }
  if (key == 'd') {
    fishes.add(new Dolphin(randomPosition()));
  }
  if (key == 's') {
    fishes.add(new Shark(randomPosition()));
  }
  if (key == 'F') {
    for (int i=0; i<10; i++)
      fishes.add(new Fish(randomPosition()));
  }
  if (key == 'D') {
    for (int i=0; i<10; i++)  
      fishes.add(new Dolphin(randomPosition()));
  }
  if (key == 'S') {
    for (int i=0; i<10; i++)  
      fishes.add(new Shark(randomPosition()));
  }
  if (key == 'G') {
    for (int i=0; i<10; i++)  
      fishes.add(new Food(randomFoodPosition()));
  }
  
  /* Utilities */  
  if (key == 'g')
  {
    drawGlobe = !drawGlobe;
  }
  if (key == 'R')
  {
    fishes.clear();
    phi = theta = zoom = 0.0f;
  }
  
  if (key == 'r' && fishes.size() > 0) {
    fishes.remove(0);
  }
  if (key == 'p') {
    running = !running;
  }
  if (key == 't') {
    texturesOn = !texturesOn;
  }
  if (key == 'v') {
    if (debugLevel++ > maxDebugLevel) debugLevel = 0;
  }
  if (key == 'h' && fishes.size() > 0) {
    MovableObject o = (MovableObject)fishes.get(0);
    o.Behaviour = new HumanSteering(o);
    println("Human Steering On for " + o.Name() );
  }
  if (key == '+') {
    scaleVal++;
  }
  if (key == '-') {
    if (scaleVal > 1)
      scaleVal--;
  }
  if (key == 'q') {
    // Quit somehow?
  }
}

void PrintMatrix(String a) 
{
    println("======"+a+"======");
    float[] mat = new float[16];
    gl.glGetFloatv(GL.GL_MODELVIEW_MATRIX, mat);
    for (int i=0;i<16;++i)
      if (i%4!=3)
        print(mat[i]+", ");
      else
        println(mat[i]);
    println("------"+a+"------");
}

final void debug(int n, String a)
{
  if (n == debugLevel)
    println("("+n+") "+a);
}

void draw()
{
  /* fine-tuned micro time step handling for delay of unimportant calculations */
  microTimeStep++;
  if (microTimeStep > 10)
    microTimeStep = 0;
  /* done fine tuned micro time step */
    
  gl.glMatrixMode(GL.GL_MODELVIEW);
  gl.glClear(GL.GL_COLOR_BUFFER_BIT | GL.GL_DEPTH_BUFFER_BIT);
  gl.glPushMatrix();
  
  // Scale things down
  gl.glScalef(0.03f,0.03f,0.03f);

  /* Orient everything properly */
  gl.glRotatef(180.0f,0.0f,0.0f,1.0f);

  /* Camera Setup */
  gl.glTranslatef(0.0f, 0.0f, -50000+zoom);  

  gl.glRotatef(theta, 1.0f, 0.0f, 0.0f);
  gl.glRotatef(phi, 0.0f, 1.0f, 0.0f);
  
// glu.gluLookAt(0.0f,0.0f,-1000.0f, 0.0f,0.0f,0.0f, 0.0f,1.0f,0.0f);

  /* Draw Axes */
  gl.glPushMatrix();
  if (!fishes.isEmpty())
    ((MovableObject)fishes.get(0)).DrawAxes();
  gl.glPopMatrix();
  
  /* Enable lighting */
  gl.glEnable(GL.GL_LIGHTING);  
  gl.glEnable(GL.GL_LIGHT0);

  /* ==== Draw bowl ==== */
  GLUquadric quadric = glu.gluNewQuadric();    //In Jogl
  
  textureBasic(1); // Turn on overall texture
  gl.glTexGeni(GL.GL_S, GL.GL_TEXTURE_GEN_MODE, GL.GL_SPHERE_MAP); // Sphere mapping
  gl.glTexGeni(GL.GL_T, GL.GL_TEXTURE_GEN_MODE, GL.GL_SPHERE_MAP);  
  setMaterialDiffuseColor(0.0f, 0.5f, 0.91f, 1.0f);	
  gl.glColor4f(1.0f,1.0f,1.0f,0.5f);			
  
  gl.glBlendFunc(GL.GL_SRC_ALPHA,GL.GL_ONE);                    // Perform alpha blending
  gl.glEnable(GL.GL_BLEND);

  if (drawGlobe) {
    glu.gluQuadricDrawStyle(quadric, GLU.GLU_FILL);  
    glu.gluSphere(quadric, OuterWallRadius+OuterWallMargin, 32, 32);		// Draw Sphere Using New Texture
  }
  
  gl.glDisable(GL.GL_BLEND);					// Disable Blending
  textureStop();                                                // Stop the sphere texture

  /* Draw wireframe */        
  setMaterialDiffuseColor(0.0f,0.0f,1.0f,0.8f);
  glu.gluQuadricDrawStyle(quadric, GLU.GLU_LINE);               // Draw the wireframe so that the user has reference points
  glu.gluSphere(quadric, OuterWallRadius+OuterWallMargin*1.01, 16, 16);
  
  glu.gluDeleteQuadric(quadric);

  /* ==== DONE drawing bowl ==== */

  textureBasic(0.0005); // Turn on overall texture
  
  if (zoom < 22000) 
    gl.glDisable(GL.GL_DEPTH_TEST);
  else 
    gl.glEnable(GL.GL_DEPTH_TEST);
    
  /* Draw each fish */
  for (int i=0; i<fishes.size(); ++ i) {
    MovableObject current = (MovableObject)fishes.get(i);
    if (running)
      current.Update(deltaTime);
    
    gl.glPushMatrix();
    FishTransform(current);
    current.DrawAxes(); // This is toggled within within the function
    gl.glScalef(scaleVal, scaleVal, scaleVal);  // Make things smallerish
    // Fatness? 
    
    current.Draw();
    gl.glPopMatrix();
  }    
  
  textureStop(); // Turn off overall texture
  gl.glPopMatrix();
  
  gl.glDisable(GL.GL_LIGHTING); // Don't light the widgets
  gl.glDisable(GL.GL_LIGHT0);  
  gl.glEnable(GL.GL_BLEND); // Do blend alphaly
  gl.glBlendFunc(GL.GL_SRC_ALPHA, GL.GL_ONE_MINUS_SRC_ALPHA); // Set blend function to one compatible with Processing
  gl.glDisable(GL.GL_DEPTH_TEST);
  
  for (int i=0; i<widgets.size(); ++i) {
    ((Widget)widgets.get(i)).draw(mouseX, mouseY);
  }
  
  if (microTimeStep%5 == 0)
    pollSliders(); // don't run all the time
}

void FishTransform(MovableObject fish)
{
    gl.glTranslatef(fish.Position.v[0], fish.Position.v[1], -fish.Position.v[2]);
    RotateMatrixAlongHeading(fish.Heading, fish.Side);    
    gl.glRotatef(fish.AxisRotation, fish.Heading.v[0], fish.Heading.v[1], fish.Heading.v[2]);
}

void handleUIActions()
{
  if (currentlyActiveWidget == buttonFood) {
    for (int i=0; i<10; i++)  
      fishes.add(new Food(randomFoodPosition()));      
    return;
  }
  if (currentlyActiveWidget == buttonFish) {
    for (int i=0; i<10; i++)
      fishes.add(new Fish(randomPosition()));  
    return;
  }
  if (currentlyActiveWidget == buttonDolphin) {
    fishes.add(new Dolphin(randomPosition()));  
    return;
  }
  if (currentlyActiveWidget == buttonShark) {
    fishes.add(new Shark(randomPosition()));  
    return;  
  }
  if (currentlyActiveWidget == buttonGlobe) {
    drawGlobe = !drawGlobe;
    return;   
  }
  if (currentlyActiveWidget == buttonLink) {
    link("http://www.pugsplace.net/2005/12/14/schua/");
    return;
  }
}

void pollSliders()
{
  XenoFactor= sliderXenop.getValue()*2;
  SepFactor = sliderSepar.getValue()*2;
  AliFactor = sliderAlign.getValue()*2;
  CohFactor = sliderCohes.getValue()*2;
}

void eat(MovableObject crunchyThing, MovableObject hunter)
{
  int idx = fishes.indexOf(crunchyThing);
  if (idx > -1) {
    fishes.remove(idx);
    hunter.NumberOfThingsEaten++;
    debug(0, crunchyThing.Name() + " is eaten by " + hunter.Name());  
  }
}
