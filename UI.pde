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
 public class Widget 
{
  protected String label;
  int Xpos, Ypos, Width, Height;
  PFont font;
  int fontSz;
  int padding = 5;

  public boolean mouseIn(int mx, int my) {
    return ( abs(mx-Xpos)<(Width/2) && abs(my-Ypos)<(Height/2) );
  }
  
  public void move(int x, int y) {
    Xpos = x; Ypos = y;
  }
  
  public void resize(int w, int h) {
    Width = w; Height = h;
  }
  
  public void update(int mx, int my) {
  }
  
  public void draw(int mx, int my) {
  }
  
  public void setLabel(String t) {
    label = t;
  }
  
  public void setFont(PFont f, int s) {
    font = f;
    fontSz = s;
  }
  
}

public class Label extends Widget
{
  color TextColor;
  int alignment;

  public Label (int x, int y, int Wid, int Hig, color tc, int a)
  {
    Xpos = x; Ypos = y; Width = Wid; Height = Hig; TextColor = tc; 
    alignment = a;
    label = "";
    font = smallFont;
    fontSz = 12;
  }
  
  public void draw(int mx, int my) 
  {
    stroke(TextColor);
    
    fill(TextColor);
    textFont(font, fontSz);
    
    textAlign(alignment);
    text(label, Xpos+padding, Ypos+padding, Width-padding, Height-padding);    
    textAlign(CENTER);
  }
}

public class Button extends Widget
{
  color Base;
  color Clicked;
  color Mouseover;
  
  public Button(int x, int y, int w, int h, color b, color c, color mo)
  {
    Xpos = x; Ypos = y; Width = w; Height = h; Base = b; Clicked = c; Mouseover = mo;
    label = "";
    font = smallFont;
    fontSz = 12;
  }
  
  public void draw(int mx, int my)
  {
    if (mouseIn(mx,my)) {
      if (currentlyActiveWidget == this || 
         (currentlyActiveWidget == null && mousePressed && mouseButton == LEFT)) {
        currentlyActiveWidget = this;
        fill(Clicked);
      } else {
        fill(Mouseover);
      }
    } else {
      fill(Base);
    }
    rect((float)Xpos-(Width/2), (float)Ypos-(Height/2), (float)Width, (float)Height);
    fill(255,255,255); 
    textFont(font, fontSz);
    text(label, Xpos-(Width/2)+(.6*padding), Ypos-(Height/2)+padding, Width-padding, Height-padding);
  }  
}

public class Slider extends Widget
{
  float minValue;
  float maxValue;  
  double Value;
  int boxSize;
  boolean isHorizontal;
  Button button;

  public Slider (int xi, int yi, int wi, int bw, int bh, double v, color b, color c, color mo, boolean hz) {
    Xpos = xi;
    Ypos = yi;
    Height = bh;
    Width = wi;
    Value = v;
    isHorizontal=hz;
    button = new Button(0, 0, bw, bh, b, c, mo);
    if (isHorizontal)
      boxSize = bh/2;
    else
      boxSize = bw/2;
    label = "";
    font = smallFont;
    fontSz = 12;
  }

  public void draw(int mx, int my)
  {
    stroke(255,255,255);
    
    if (isHorizontal) {
      line(Xpos, Ypos, Xpos+Width, Ypos);
      button.move(Xpos+(int)(Width*Value), Ypos);
    }
    else {
      line(Xpos, Ypos, Xpos, Ypos+Width);
      button.move(Xpos, Ypos+(int)(Width*Value));
    }
    
    button.draw(mx, my);
    if (currentlyActiveWidget == button)
      currentlyActiveWidget = this;

    stroke(0);
    
    fill(255,255,255);
    textFont(font, fontSz);
    text(label, Xpos+padding, Ypos+padding, Width-padding, Height-padding);
  }

  public void update(int mx, int my) {
    if (isHorizontal)
      Value = (double)(mx-Xpos-boxSize)/Width;
    else
      Value = (double)(my-Ypos-boxSize)/Width;

    if (Value > 1.0) Value = 1.0;
    if (Value < 0.0) Value = 0.0;    
  } 

  public float getValue() {
    return (float)Value;
  }

}
