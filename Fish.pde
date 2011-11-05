/**
 * (c) Copyright 1993, 1994, Silicon Graphics, Inc.
 * ALL RIGHTS RESERVED
 * Permission to use, copy, modify, and distribute this software for
 * any purpose and without fee is hereby granted, provided that the above
 * copyright notice appear in all copies and that both the copyright notice
 * and this permission notice appear in supporting documentation, and that
 * the name of Silicon Graphics, Inc. not be used in advertising
 * or publicity pertaining to distribution of the software without specific,
 * written prior permission.
 *
 * THE MATERIAL EMBODIED ON THIS SOFTWARE IS PROVIDED TO YOU "AS-IS"
 * AND WITHOUT WARRANTY OF ANY KIND, EXPRESS, IMPLIED OR OTHERWISE,
 * INCLUDING WITHOUT LIMITATION, ANY WARRANTY OF MERCHANTABILITY OR
 * FITNESS FOR A PARTICULAR PURPOSE.  IN NO EVENT SHALL SILICON
 * GRAPHICS, INC.  BE LIABLE TO YOU OR ANYONE ELSE FOR ANY DIRECT,
 * SPECIAL, INCIDENTAL, INDIRECT OR CONSEQUENTIAL DAMAGES OF ANY
 * KIND, OR ANY DAMAGES WHATSOEVER, INCLUDING WITHOUT LIMITATION,
 * LOSS OF PROFIT, LOSS OF USE, SAVINGS OR REVENUE, OR THE CLAIMS OF
 * THIRD PARTIES, WHETHER OR NOT SILICON GRAPHICS, INC.  HAS BEEN
 * ADVISED OF THE POSSIBILITY OF SUCH LOSS, HOWEVER CAUSED AND ON
 * ANY THEORY OF LIABILITY, ARISING OUT OF OR IN CONNECTION WITH THE
 * POSSESSION, USE OR PERFORMANCE OF THIS SOFTWARE.
 *
 * US Government Users Restricted Rights
 * Use, duplication, or disclosure by the Government is subject to
 * restrictions set forth in FAR 52.227.19(c)(2) or subparagraph
 * (c)(1)(ii) of the Rights in Technical Data and Computer Software
 * clause at DFARS 252.227-7013 and/or in similar or successor
 * clauses in the FAR or the DOD or NASA FAR Supplement.
 * Unpublished-- rights reserved under the copyright laws of the
 * United States.  Contractor/manufacturer is Silicon Graphics,
 * Inc., 2011 N.  Shoreline Blvd., Mountain View, CA 94039-7311.
 *
 * Opengl.gl(TM) is a trademark of Silicon Graphics, Inc.
 */
/* *INDENT-OFF* */
public class Fish extends MovableObject
{
  protected float scaleX;
  protected float scaleY;
  protected float scaleZ;
  protected float rotationPoint;
  protected float thrashConstant = 50.0;
  
  public Fish(Vec3D p) { 
    super(p); 
    Mass = 100.0;
    Behaviour.WanderJitter = 0.25;
    Behaviour.WanderRadius = 10;
    Behaviour.WanderDistance = 50;
    
    scaleX = 0.5;
    scaleY = 0.4;
    scaleZ = 0.4;  // small fish!
    
    rotationPoint = 0;
    
    Name = "Fish";
    
    Species = 10 + r.nextInt(9);
  }
  
float N002[] = {0.000077 ,-0.020611 ,0.999788};
float N003[] = {0.961425 ,0.258729 ,-0.093390};
float N004[] = {0.510811 ,-0.769633 ,-0.383063};
float N005[] = {0.400123 ,0.855734 ,-0.328055};
float N006[] = {-0.770715 ,0.610204 ,-0.183440};
float N007[] = {-0.915597 ,-0.373345 ,-0.149316};
float N008[] = {-0.972788 ,0.208921 ,-0.100179};
float N009[] = {-0.939713 ,-0.312268 ,-0.139383};
float N010[] = {-0.624138 ,-0.741047 ,-0.247589};
float N011[] = {0.591434 ,-0.768401 ,-0.244471};
float N012[] = {0.935152 ,-0.328495 ,-0.132598};
float N013[] = {0.997102 ,0.074243 ,-0.016593};
float N014[] = {0.969995 ,0.241712 ,-0.026186};
float N015[] = {0.844539 ,0.502628 ,-0.184714};
float N016[] = {-0.906608 ,0.386308 ,-0.169787};
float N017[] = {-0.970016 ,0.241698 ,-0.025516};
float N018[] = {-0.998652 ,0.050493 ,-0.012045};
float N019[] = {-0.942685 ,-0.333051 ,-0.020556};
float N020[] = {-0.660944 ,-0.750276 ,0.015480};
float N021[] = {0.503549 ,-0.862908 ,-0.042749};
float N022[] = {0.953202 ,-0.302092 ,-0.012089};
float N023[] = {0.998738 ,0.023574 ,0.044344};
float N024[] = {0.979297 ,0.193272 ,0.060202};
float N025[] = {0.798300 ,0.464885 ,0.382883};
float N026[] = {-0.756590 ,0.452403 ,0.472126};
float N027[] = {-0.953855 ,0.293003 ,0.065651};
float N028[] = {-0.998033 ,0.040292 ,0.048028};
float N029[] = {-0.977079 ,-0.204288 ,0.059858};
float N030[] = {-0.729117 ,-0.675304 ,0.111140};
float N031[] = {0.598361 ,-0.792753 ,0.116221};
float N032[] = {0.965192 ,-0.252991 ,0.066332};
float N033[] = {0.998201 ,-0.002790 ,0.059892};
float N034[] = {0.978657 ,0.193135 ,0.070207};
float N035[] = {0.718815 ,0.680392 ,0.142733};
float N036[] = {-0.383096 ,0.906212 ,0.178936};
float N037[] = {-0.952831 ,0.292590 ,0.080647};
float N038[] = {-0.997680 ,0.032417 ,0.059861};
float N039[] = {-0.982629 ,-0.169881 ,0.074700};
float N040[] = {-0.695424 ,-0.703466 ,0.146700};
float N041[] = {0.359323 ,-0.915531 ,0.180805};
float N042[] = {0.943356 ,-0.319387 ,0.089842};
float N043[] = {0.998272 ,-0.032435 ,0.048993};
float N044[] = {0.978997 ,0.193205 ,0.065084};
float N045[] = {0.872144 ,0.470094 ,-0.135565};
float N046[] = {-0.664282 ,0.737945 ,-0.119027};
float N047[] = {-0.954508 ,0.288570 ,0.075107};
float N048[] = {-0.998273 ,0.032406 ,0.048993};
float N049[] = {-0.979908 ,-0.193579 ,0.048038};
float N050[] = {-0.858736 ,-0.507202 ,-0.072938};
float N051[] = {0.643545 ,-0.763887 ,-0.048237};
float N052[] = {0.955580 ,-0.288954 ,0.058068};
float N058[] = {0.000050 ,0.793007 ,-0.609213};
float N059[] = {0.913510 ,0.235418 ,-0.331779};
float N060[] = {-0.807970 ,0.495000 ,-0.319625};
float N061[] = {0.000000 ,0.784687 ,-0.619892};
float N062[] = {0.000000 ,-1.000000 ,0.000000};
float N063[] = {0.000000 ,1.000000 ,0.000000};
float N064[] = {0.000000 ,1.000000 ,0.000000};
float N065[] = {0.000000 ,1.000000 ,0.000000};
float N066[] = {-0.055784 ,0.257059 ,0.964784};
float N069[] = {-0.000505 ,-0.929775 ,-0.368127};
float N070[] = {0.000000 ,1.000000 ,0.000000};
float P002[] = {0.00, -36.59, 5687.72};
float P003[] = {90.00, 114.73, 724.38};
float P004[] = {58.24, -146.84, 262.35};
float P005[] = {27.81, 231.52, 510.43};
float P006[] = {-27.81, 230.43, 509.76};
float P007[] = {-46.09, -146.83, 265.84};
float P008[] = {-90.00, 103.84, 718.53};
float P009[] = {-131.10, -165.92, 834.85};
float P010[] = {-27.81, -285.31, 500.00};
float P011[] = {27.81, -285.32, 500.00};
float P012[] = {147.96, -170.89, 845.50};
float P013[] = {180.00, 0.00, 2000.00};
float P014[] = {145.62, 352.67, 2000.00};
float P015[] = {55.62, 570.63, 2000.00};
float P016[] = {-55.62, 570.64, 2000.00};
float P017[] = {-145.62, 352.68, 2000.00};
float P018[] = {-180.00, 0.01, 2000.00};
float P019[] = {-178.20, -352.66, 2001.61};
float P020[] = {-55.63, -570.63, 2000.00};
float P021[] = {55.62, -570.64, 2000.00};
float P022[] = {179.91, -352.69, 1998.39};
float P023[] = {150.00, 0.00, 3000.00};
float P024[] = {121.35, 293.89, 3000.00};
float P025[] = {46.35, 502.93, 2883.09};
float P026[] = {-46.35, 497.45, 2877.24};
float P027[] = {-121.35, 293.90, 3000.00};
float P028[] = {-150.00, 0.00, 3000.00};
float P029[] = {-152.21, -304.84, 2858.68};
float P030[] = {-46.36, -475.52, 3000.00};
float P031[] = {46.35, -475.53, 3000.00};
float P032[] = {155.64, -304.87, 2863.50};
float P033[] = {90.00, 0.00, 4000.00};
float P034[] = {72.81, 176.33, 4000.00};
float P035[] = {27.81, 285.32, 4000.00};
float P036[] = {-27.81, 285.32, 4000.00};
float P037[] = {-72.81, 176.34, 4000.00};
float P038[] = {-90.00, 0.00, 4000.00};
float P039[] = {-72.81, -176.33, 4000.00};
float P040[] = {-27.81, -285.31, 4000.00};
float P041[] = {27.81, -285.32, 4000.00};
float P042[] = {72.81, -176.34, 4000.00};
float P043[] = {30.00, 0.00, 5000.00};
float P044[] = {24.27, 58.78, 5000.00};
float P045[] = {9.27, 95.11, 5000.00};
float P046[] = {-9.27, 95.11, 5000.00};
float P047[] = {-24.27, 58.78, 5000.00};
float P048[] = {-30.00, 0.00, 5000.00};
float P049[] = {-24.27, -58.78, 5000.00};
float P050[] = {-9.27, -95.10, 5000.00};
float P051[] = {9.27, -95.11, 5000.00};
float P052[] = {24.27, -58.78, 5000.00};
float P058[] = {0.00, 1212.72, 2703.08};
float P059[] = {50.36, 0.00, 108.14};
float P060[] = {-22.18, 0.00, 108.14};
float P061[] = {0.00, 1181.61, 6344.65};
float P062[] = {516.45, -887.08, 2535.45};
float P063[] = {-545.69, -879.31, 2555.63};
float P064[] = {618.89, -1005.64, 2988.32};
float P065[] = {-635.37, -1014.79, 2938.68};
float P066[] = {0.00, 1374.43, 3064.18};
float P069[] = {0.00, -418.25, 5765.04};
float P070[] = {0.00, 1266.91, 6629.60};
float P071[] = {-139.12, -124.96, 997.98};
float P072[] = {-139.24, -110.18, 1020.68};
float P073[] = {-137.33, -94.52, 1022.63};
float P074[] = {-137.03, -79.91, 996.89};
float P075[] = {-135.21, -91.48, 969.14};
float P076[] = {-135.39, -110.87, 968.76};
float P077[] = {150.23, -78.44, 995.53};
float P078[] = {152.79, -92.76, 1018.46};
float P079[] = {154.19, -110.20, 1020.55};
float P080[] = {151.33, -124.15, 993.77};
float P081[] = {150.49, -111.19, 969.86};
float P082[] = {150.79, -92.41, 969.70};
float iP002[] = {0.00, -36.59, 5687.72};
float iP004[] = {58.24, -146.84, 262.35};
float iP007[] = {-46.09, -146.83, 265.84};
float iP010[] = {-27.81, -285.31, 500.00};
float iP011[] = {27.81, -285.32, 500.00};
float iP023[] = {150.00, 0.00, 3000.00};
float iP024[] = {121.35, 293.89, 3000.00};
float iP025[] = {46.35, 502.93, 2883.09};
float iP026[] = {-46.35, 497.45, 2877.24};
float iP027[] = {-121.35, 293.90, 3000.00};
float iP028[] = {-150.00, 0.00, 3000.00};
float iP029[] = {-121.35, -304.84, 2853.86};
float iP030[] = {-46.36, -475.52, 3000.00};
float iP031[] = {46.35, -475.53, 3000.00};
float iP032[] = {121.35, -304.87, 2853.86};
float iP033[] = {90.00, 0.00, 4000.00};
float iP034[] = {72.81, 176.33, 4000.00};
float iP035[] = {27.81, 285.32, 4000.00};
float iP036[] = {-27.81, 285.32, 4000.00};
float iP037[] = {-72.81, 176.34, 4000.00};
float iP038[] = {-90.00, 0.00, 4000.00};
float iP039[] = {-72.81, -176.33, 4000.00};
float iP040[] = {-27.81, -285.31, 4000.00};
float iP041[] = {27.81, -285.32, 4000.00};
float iP042[] = {72.81, -176.34, 4000.00};
float iP043[] = {30.00, 0.00, 5000.00};
float iP044[] = {24.27, 58.78, 5000.00};
float iP045[] = {9.27, 95.11, 5000.00};
float iP046[] = {-9.27, 95.11, 5000.00};
float iP047[] = {-24.27, 58.78, 5000.00};
float iP048[] = {-30.00, 0.00, 5000.00};
float iP049[] = {-24.27, -58.78, 5000.00};
float iP050[] = {-9.27, -95.10, 5000.00};
float iP051[] = {9.27, -95.11, 5000.00};
float iP052[] = {24.27, -58.78, 5000.00};
float iP061[] = {0.00, 1181.61, 6344.65};
float iP069[] = {0.00, -418.25, 5765.04};
float iP070[] = {0.00, 1266.91, 6629.60};
/* *INDENT-ON* */

void
Fish001()
{
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N005);
    gl.glVertex3fv(P005);
    gl.glNormal3fv(N059);
    gl.glVertex3fv(P059);
    gl.glNormal3fv(N060);
    gl.glVertex3fv(P060);
    gl.glNormal3fv(N006);
    gl.glVertex3fv(P006);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N015);
    gl.glVertex3fv(P015);
    gl.glNormal3fv(N005);
    gl.glVertex3fv(P005);
    gl.glNormal3fv(N006);
    gl.glVertex3fv(P006);
    gl.glNormal3fv(N016);
    gl.glVertex3fv(P016);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N006);
    gl.glVertex3fv(P006);
    gl.glNormal3fv(N060);
    gl.glVertex3fv(P060);
    gl.glNormal3fv(N008);
    gl.glVertex3fv(P008);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N016);
    gl.glVertex3fv(P016);
    gl.glNormal3fv(N006);
    gl.glVertex3fv(P006);
    gl.glNormal3fv(N008);
    gl.glVertex3fv(P008);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N016);
    gl.glVertex3fv(P016);
    gl.glNormal3fv(N008);
    gl.glVertex3fv(P008);
    gl.glNormal3fv(N017);
    gl.glVertex3fv(P017);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N017);
    gl.glVertex3fv(P017);
    gl.glNormal3fv(N008);
    gl.glVertex3fv(P008);
    gl.glNormal3fv(N018);
    gl.glVertex3fv(P018);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N008);
    gl.glVertex3fv(P008);
    gl.glNormal3fv(N009);
    gl.glVertex3fv(P009);
    gl.glNormal3fv(N018);
    gl.glVertex3fv(P018);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N008);
    gl.glVertex3fv(P008);
    gl.glNormal3fv(N060);
    gl.glVertex3fv(P060);
    gl.glNormal3fv(N009);
    gl.glVertex3fv(P009);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N007);
    gl.glVertex3fv(P007);
    gl.glNormal3fv(N010);
    gl.glVertex3fv(P010);
    gl.glNormal3fv(N009);
    gl.glVertex3fv(P009);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N009);
    gl.glVertex3fv(P009);
    gl.glNormal3fv(N019);
    gl.glVertex3fv(P019);
    gl.glNormal3fv(N018);
    gl.glVertex3fv(P018);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N009);
    gl.glVertex3fv(P009);
    gl.glNormal3fv(N010);
    gl.glVertex3fv(P010);
    gl.glNormal3fv(N019);
    gl.glVertex3fv(P019);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N010);
    gl.glVertex3fv(P010);
    gl.glNormal3fv(N020);
    gl.glVertex3fv(P020);
    gl.glNormal3fv(N019);
    gl.glVertex3fv(P019);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N010);
    gl.glVertex3fv(P010);
    gl.glNormal3fv(N011);
    gl.glVertex3fv(P011);
    gl.glNormal3fv(N021);
    gl.glVertex3fv(P021);
    gl.glNormal3fv(N020);
    gl.glVertex3fv(P020);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N004);
    gl.glVertex3fv(P004);
    gl.glNormal3fv(N011);
    gl.glVertex3fv(P011);
    gl.glNormal3fv(N010);
    gl.glVertex3fv(P010);
    gl.glNormal3fv(N007);
    gl.glVertex3fv(P007);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N004);
    gl.glVertex3fv(P004);
    gl.glNormal3fv(N012);
    gl.glVertex3fv(P012);
    gl.glNormal3fv(N011);
    gl.glVertex3fv(P011);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N012);
    gl.glVertex3fv(P012);
    gl.glNormal3fv(N022);
    gl.glVertex3fv(P022);
    gl.glNormal3fv(N011);
    gl.glVertex3fv(P011);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N011);
    gl.glVertex3fv(P011);
    gl.glNormal3fv(N022);
    gl.glVertex3fv(P022);
    gl.glNormal3fv(N021);
    gl.glVertex3fv(P021);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N059);
    gl.glVertex3fv(P059);
    gl.glNormal3fv(N005);
    gl.glVertex3fv(P005);
    gl.glNormal3fv(N015);
    gl.glVertex3fv(P015);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N015);
    gl.glVertex3fv(P015);
    gl.glNormal3fv(N014);
    gl.glVertex3fv(P014);
    gl.glNormal3fv(N003);
    gl.glVertex3fv(P003);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N015);
    gl.glVertex3fv(P015);
    gl.glNormal3fv(N003);
    gl.glVertex3fv(P003);
    gl.glNormal3fv(N059);
    gl.glVertex3fv(P059);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N014);
    gl.glVertex3fv(P014);
    gl.glNormal3fv(N013);
    gl.glVertex3fv(P013);
    gl.glNormal3fv(N003);
    gl.glVertex3fv(P003);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N003);
    gl.glVertex3fv(P003);
    gl.glNormal3fv(N012);
    gl.glVertex3fv(P012);
    gl.glNormal3fv(N059);
    gl.glVertex3fv(P059);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N013);
    gl.glVertex3fv(P013);
    gl.glNormal3fv(N012);
    gl.glVertex3fv(P012);
    gl.glNormal3fv(N003);
    gl.glVertex3fv(P003);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N013);
    gl.glVertex3fv(P013);
    gl.glNormal3fv(N022);
    gl.glVertex3fv(P022);
    gl.glNormal3fv(N012);
    gl.glVertex3fv(P012);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glVertex3fv(P071);
    gl.glVertex3fv(P072);
    gl.glVertex3fv(P073);
    gl.glVertex3fv(P074);
    gl.glVertex3fv(P075);
    gl.glVertex3fv(P076);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glVertex3fv(P077);
    gl.glVertex3fv(P078);
    gl.glVertex3fv(P079);
    gl.glVertex3fv(P080);
    gl.glVertex3fv(P081);
    gl.glVertex3fv(P082);
    gl.glEnd();
}

void
Fish002()
{
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N013);
    gl.glVertex3fv(P013);
    gl.glNormal3fv(N014);
    gl.glVertex3fv(P014);
    gl.glNormal3fv(N024);
    gl.glVertex3fv(P024);
    gl.glNormal3fv(N023);
    gl.glVertex3fv(P023);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N014);
    gl.glVertex3fv(P014);
    gl.glNormal3fv(N015);
    gl.glVertex3fv(P015);
    gl.glNormal3fv(N025);
    gl.glVertex3fv(P025);
    gl.glNormal3fv(N024);
    gl.glVertex3fv(P024);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N016);
    gl.glVertex3fv(P016);
    gl.glNormal3fv(N017);
    gl.glVertex3fv(P017);
    gl.glNormal3fv(N027);
    gl.glVertex3fv(P027);
    gl.glNormal3fv(N026);
    gl.glVertex3fv(P026);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N017);
    gl.glVertex3fv(P017);
    gl.glNormal3fv(N018);
    gl.glVertex3fv(P018);
    gl.glNormal3fv(N028);
    gl.glVertex3fv(P028);
    gl.glNormal3fv(N027);
    gl.glVertex3fv(P027);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N020);
    gl.glVertex3fv(P020);
    gl.glNormal3fv(N021);
    gl.glVertex3fv(P021);
    gl.glNormal3fv(N031);
    gl.glVertex3fv(P031);
    gl.glNormal3fv(N030);
    gl.glVertex3fv(P030);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N013);
    gl.glVertex3fv(P013);
    gl.glNormal3fv(N023);
    gl.glVertex3fv(P023);
    gl.glNormal3fv(N022);
    gl.glVertex3fv(P022);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N022);
    gl.glVertex3fv(P022);
    gl.glNormal3fv(N023);
    gl.glVertex3fv(P023);
    gl.glNormal3fv(N032);
    gl.glVertex3fv(P032);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N022);
    gl.glVertex3fv(P022);
    gl.glNormal3fv(N032);
    gl.glVertex3fv(P032);
    gl.glNormal3fv(N031);
    gl.glVertex3fv(P031);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N022);
    gl.glVertex3fv(P022);
    gl.glNormal3fv(N031);
    gl.glVertex3fv(P031);
    gl.glNormal3fv(N021);
    gl.glVertex3fv(P021);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N018);
    gl.glVertex3fv(P018);
    gl.glNormal3fv(N019);
    gl.glVertex3fv(P019);
    gl.glNormal3fv(N029);
    gl.glVertex3fv(P029);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N018);
    gl.glVertex3fv(P018);
    gl.glNormal3fv(N029);
    gl.glVertex3fv(P029);
    gl.glNormal3fv(N028);
    gl.glVertex3fv(P028);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N019);
    gl.glVertex3fv(P019);
    gl.glNormal3fv(N020);
    gl.glVertex3fv(P020);
    gl.glNormal3fv(N030);
    gl.glVertex3fv(P030);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N019);
    gl.glVertex3fv(P019);
    gl.glNormal3fv(N030);
    gl.glVertex3fv(P030);
    gl.glNormal3fv(N029);
    gl.glVertex3fv(P029);
    gl.glEnd();
}

void
Fish003()
{
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N032);
    gl.glVertex3fv(P032);
    gl.glNormal3fv(N023);
    gl.glVertex3fv(P023);
    gl.glNormal3fv(N033);
    gl.glVertex3fv(P033);
    gl.glNormal3fv(N042);
    gl.glVertex3fv(P042);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N031);
    gl.glVertex3fv(P031);
    gl.glNormal3fv(N032);
    gl.glVertex3fv(P032);
    gl.glNormal3fv(N042);
    gl.glVertex3fv(P042);
    gl.glNormal3fv(N041);
    gl.glVertex3fv(P041);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N023);
    gl.glVertex3fv(P023);
    gl.glNormal3fv(N024);
    gl.glVertex3fv(P024);
    gl.glNormal3fv(N034);
    gl.glVertex3fv(P034);
    gl.glNormal3fv(N033);
    gl.glVertex3fv(P033);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N024);
    gl.glVertex3fv(P024);
    gl.glNormal3fv(N025);
    gl.glVertex3fv(P025);
    gl.glNormal3fv(N035);
    gl.glVertex3fv(P035);
    gl.glNormal3fv(N034);
    gl.glVertex3fv(P034);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N030);
    gl.glVertex3fv(P030);
    gl.glNormal3fv(N031);
    gl.glVertex3fv(P031);
    gl.glNormal3fv(N041);
    gl.glVertex3fv(P041);
    gl.glNormal3fv(N040);
    gl.glVertex3fv(P040);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N025);
    gl.glVertex3fv(P025);
    gl.glNormal3fv(N026);
    gl.glVertex3fv(P026);
    gl.glNormal3fv(N036);
    gl.glVertex3fv(P036);
    gl.glNormal3fv(N035);
    gl.glVertex3fv(P035);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N026);
    gl.glVertex3fv(P026);
    gl.glNormal3fv(N027);
    gl.glVertex3fv(P027);
    gl.glNormal3fv(N037);
    gl.glVertex3fv(P037);
    gl.glNormal3fv(N036);
    gl.glVertex3fv(P036);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N027);
    gl.glVertex3fv(P027);
    gl.glNormal3fv(N028);
    gl.glVertex3fv(P028);
    gl.glNormal3fv(N038);
    gl.glVertex3fv(P038);
    gl.glNormal3fv(N037);
    gl.glVertex3fv(P037);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N028);
    gl.glVertex3fv(P028);
    gl.glNormal3fv(N029);
    gl.glVertex3fv(P029);
    gl.glNormal3fv(N039);
    gl.glVertex3fv(P039);
    gl.glNormal3fv(N038);
    gl.glVertex3fv(P038);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N029);
    gl.glVertex3fv(P029);
    gl.glNormal3fv(N030);
    gl.glVertex3fv(P030);
    gl.glNormal3fv(N040);
    gl.glVertex3fv(P040);
    gl.glNormal3fv(N039);
    gl.glVertex3fv(P039);
    gl.glEnd();
}

void
Fish004()
{
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N040);
    gl.glVertex3fv(P040);
    gl.glNormal3fv(N041);
    gl.glVertex3fv(P041);
    gl.glNormal3fv(N051);
    gl.glVertex3fv(P051);
    gl.glNormal3fv(N050);
    gl.glVertex3fv(P050);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N041);
    gl.glVertex3fv(P041);
    gl.glNormal3fv(N042);
    gl.glVertex3fv(P042);
    gl.glNormal3fv(N052);
    gl.glVertex3fv(P052);
    gl.glNormal3fv(N051);
    gl.glVertex3fv(P051);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N042);
    gl.glVertex3fv(P042);
    gl.glNormal3fv(N033);
    gl.glVertex3fv(P033);
    gl.glNormal3fv(N043);
    gl.glVertex3fv(P043);
    gl.glNormal3fv(N052);
    gl.glVertex3fv(P052);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N033);
    gl.glVertex3fv(P033);
    gl.glNormal3fv(N034);
    gl.glVertex3fv(P034);
    gl.glNormal3fv(N044);
    gl.glVertex3fv(P044);
    gl.glNormal3fv(N043);
    gl.glVertex3fv(P043);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N034);
    gl.glVertex3fv(P034);
    gl.glNormal3fv(N035);
    gl.glVertex3fv(P035);
    gl.glNormal3fv(N045);
    gl.glVertex3fv(P045);
    gl.glNormal3fv(N044);
    gl.glVertex3fv(P044);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N035);
    gl.glVertex3fv(P035);
    gl.glNormal3fv(N036);
    gl.glVertex3fv(P036);
    gl.glNormal3fv(N046);
    gl.glVertex3fv(P046);
    gl.glNormal3fv(N045);
    gl.glVertex3fv(P045);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N036);
    gl.glVertex3fv(P036);
    gl.glNormal3fv(N037);
    gl.glVertex3fv(P037);
    gl.glNormal3fv(N047);
    gl.glVertex3fv(P047);
    gl.glNormal3fv(N046);
    gl.glVertex3fv(P046);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N037);
    gl.glVertex3fv(P037);
    gl.glNormal3fv(N038);
    gl.glVertex3fv(P038);
    gl.glNormal3fv(N048);
    gl.glVertex3fv(P048);
    gl.glNormal3fv(N047);
    gl.glVertex3fv(P047);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N038);
    gl.glVertex3fv(P038);
    gl.glNormal3fv(N039);
    gl.glVertex3fv(P039);
    gl.glNormal3fv(N049);
    gl.glVertex3fv(P049);
    gl.glNormal3fv(N048);
    gl.glVertex3fv(P048);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N039);
    gl.glVertex3fv(P039);
    gl.glNormal3fv(N040);
    gl.glVertex3fv(P040);
    gl.glNormal3fv(N050);
    gl.glVertex3fv(P050);
    gl.glNormal3fv(N049);
    gl.glVertex3fv(P049);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N070);
    gl.glVertex3fv(P070);
    gl.glNormal3fv(N061);
    gl.glVertex3fv(P061);
    gl.glNormal3fv(N002);
    gl.glVertex3fv(P002);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N061);
    gl.glVertex3fv(P061);
    gl.glNormal3fv(N046);
    gl.glVertex3fv(P046);
    gl.glNormal3fv(N002);
    gl.glVertex3fv(P002);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N045);
    gl.glVertex3fv(P045);
    gl.glNormal3fv(N046);
    gl.glVertex3fv(P046);
    gl.glNormal3fv(N061);
    gl.glVertex3fv(P061);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N002);
    gl.glVertex3fv(P002);
    gl.glNormal3fv(N061);
    gl.glVertex3fv(P061);
    gl.glNormal3fv(N070);
    gl.glVertex3fv(P070);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N002);
    gl.glVertex3fv(P002);
    gl.glNormal3fv(N045);
    gl.glVertex3fv(P045);
    gl.glNormal3fv(N061);
    gl.glVertex3fv(P061);
    gl.glEnd();
}

void
Fish005()
{
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N002);
    gl.glVertex3fv(P002);
    gl.glNormal3fv(N044);
    gl.glVertex3fv(P044);
    gl.glNormal3fv(N045);
    gl.glVertex3fv(P045);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N002);
    gl.glVertex3fv(P002);
    gl.glNormal3fv(N043);
    gl.glVertex3fv(P043);
    gl.glNormal3fv(N044);
    gl.glVertex3fv(P044);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N002);
    gl.glVertex3fv(P002);
    gl.glNormal3fv(N052);
    gl.glVertex3fv(P052);
    gl.glNormal3fv(N043);
    gl.glVertex3fv(P043);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N002);
    gl.glVertex3fv(P002);
    gl.glNormal3fv(N051);
    gl.glVertex3fv(P051);
    gl.glNormal3fv(N052);
    gl.glVertex3fv(P052);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N002);
    gl.glVertex3fv(P002);
    gl.glNormal3fv(N046);
    gl.glVertex3fv(P046);
    gl.glNormal3fv(N047);
    gl.glVertex3fv(P047);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N002);
    gl.glVertex3fv(P002);
    gl.glNormal3fv(N047);
    gl.glVertex3fv(P047);
    gl.glNormal3fv(N048);
    gl.glVertex3fv(P048);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N002);
    gl.glVertex3fv(P002);
    gl.glNormal3fv(N048);
    gl.glVertex3fv(P048);
    gl.glNormal3fv(N049);
    gl.glVertex3fv(P049);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N002);
    gl.glVertex3fv(P002);
    gl.glNormal3fv(N049);
    gl.glVertex3fv(P049);
    gl.glNormal3fv(N050);
    gl.glVertex3fv(P050);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N050);
    gl.glVertex3fv(P050);
    gl.glNormal3fv(N051);
    gl.glVertex3fv(P051);
    gl.glNormal3fv(N069);
    gl.glVertex3fv(P069);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N051);
    gl.glVertex3fv(P051);
    gl.glNormal3fv(N002);
    gl.glVertex3fv(P002);
    gl.glNormal3fv(N069);
    gl.glVertex3fv(P069);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N050);
    gl.glVertex3fv(P050);
    gl.glNormal3fv(N069);
    gl.glVertex3fv(P069);
    gl.glNormal3fv(N002);
    gl.glVertex3fv(P002);
    gl.glEnd();
}

void
Fish006()
{
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N066);
    gl.glVertex3fv(P066);
    gl.glNormal3fv(N016);
    gl.glVertex3fv(P016);
    gl.glNormal3fv(N026);
    gl.glVertex3fv(P026);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N015);
    gl.glVertex3fv(P015);
    gl.glNormal3fv(N066);
    gl.glVertex3fv(P066);
    gl.glNormal3fv(N025);
    gl.glVertex3fv(P025);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N025);
    gl.glVertex3fv(P025);
    gl.glNormal3fv(N066);
    gl.glVertex3fv(P066);
    gl.glNormal3fv(N026);
    gl.glVertex3fv(P026);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N066);
    gl.glVertex3fv(P066);
    gl.glNormal3fv(N058);
    gl.glVertex3fv(P058);
    gl.glNormal3fv(N016);
    gl.glVertex3fv(P016);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N015);
    gl.glVertex3fv(P015);
    gl.glNormal3fv(N058);
    gl.glVertex3fv(P058);
    gl.glNormal3fv(N066);
    gl.glVertex3fv(P066);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N058);
    gl.glVertex3fv(P058);
    gl.glNormal3fv(N015);
    gl.glVertex3fv(P015);
    gl.glNormal3fv(N016);
    gl.glVertex3fv(P016);
    gl.glEnd();
}

void
Fish007()
{
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N062);
    gl.glVertex3fv(P062);
    gl.glNormal3fv(N022);
    gl.glVertex3fv(P022);
    gl.glNormal3fv(N032);
    gl.glVertex3fv(P032);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N062);
    gl.glVertex3fv(P062);
    gl.glNormal3fv(N032);
    gl.glVertex3fv(P032);
    gl.glNormal3fv(N064);
    gl.glVertex3fv(P064);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N022);
    gl.glVertex3fv(P022);
    gl.glNormal3fv(N062);
    gl.glVertex3fv(P062);
    gl.glNormal3fv(N032);
    gl.glVertex3fv(P032);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N062);
    gl.glVertex3fv(P062);
    gl.glNormal3fv(N064);
    gl.glVertex3fv(P064);
    gl.glNormal3fv(N032);
    gl.glVertex3fv(P032);
    gl.glEnd();
}

void
Fish008()
{
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N063);
    gl.glVertex3fv(P063);
    gl.glNormal3fv(N019);
    gl.glVertex3fv(P019);
    gl.glNormal3fv(N029);
    gl.glVertex3fv(P029);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N019);
    gl.glVertex3fv(P019);
    gl.glNormal3fv(N063);
    gl.glVertex3fv(P063);
    gl.glNormal3fv(N029);
    gl.glVertex3fv(P029);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N063);
    gl.glVertex3fv(P063);
    gl.glNormal3fv(N029);
    gl.glVertex3fv(P029);
    gl.glNormal3fv(N065);
    gl.glVertex3fv(P065);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glNormal3fv(N063);
    gl.glVertex3fv(P063);
    gl.glNormal3fv(N065);
    gl.glVertex3fv(P065);
    gl.glNormal3fv(N029);
    gl.glVertex3fv(P029);
    gl.glEnd();
}

void
Fish009()
{
    gl.glBegin(GL.GL_POLYGON);
    gl.glVertex3fv(P059);
    gl.glVertex3fv(P012);
    gl.glVertex3fv(P009);
    gl.glVertex3fv(P060);
    gl.glEnd();
    gl.glBegin(GL.GL_POLYGON);
    gl.glVertex3fv(P012);
    gl.glVertex3fv(P004);
    gl.glVertex3fv(P007);
    gl.glVertex3fv(P009);
    gl.glEnd();
}

void
Fish_1()
{
    Fish004();
    Fish005();
    Fish003();
    Fish007();
    Fish006();
    Fish002();
    Fish008();
    Fish009();
    Fish001();
}

void
Fish_2()
{
    Fish005();
    Fish004();
    Fish003();
    Fish008();
    Fish006();
    Fish002();
    Fish007();
    Fish009();
    Fish001();
}

void
Fish_3()
{
    Fish005();
    Fish004();
    Fish007();
    Fish003();
    Fish002();
    Fish008();
    Fish009();
    Fish001();
    Fish006();
}

void
Fish_4()
{
    Fish005();
    Fish004();
    Fish008();
    Fish003();
    Fish002();
    Fish007();
    Fish009();
    Fish001();
    Fish006();
}

void
Fish_5()
{
    Fish009();
    Fish006();
    Fish007();
    Fish001();
    Fish002();
    Fish003();
    Fish008();
    Fish004();
    Fish005();
}

void
Fish_6()
{
    Fish009();
    Fish006();
    Fish008();
    Fish001();
    Fish002();
    Fish007();
    Fish003();
    Fish004();
    Fish005();
}

void
Fish_7()
{
    Fish009();
    Fish001();
    Fish007();
    Fish005();
    Fish002();
    Fish008();
    Fish003();
    Fish004();
    Fish006();
}

void
Fish_8()
{
    Fish009();
    Fish008();
    Fish001();
    Fish002();
    Fish007();
    Fish003();
    Fish005();
    Fish004();
    Fish006();
}

int fish_htail;
float fish_vtail;

void Draw()
{
    float[] mat = new float[16]; // 4x4
    int n;
    float seg1, seg2, seg3, seg4, segup;
    float thrash, chomp;
    float fish_velocity = Velocity.Magnitude();
    float fish_rotvelocity = 0; //RotationalVelocity.Magnitude();        
    float[] mat_diffuse_color = {1.0f,1.0f,1.0f,1.0f};
    
    /* Colorize based on species number */
    switch (Species) {
      case 10:
        setMaterialDiffuseColor(1.0f,0.3f,0.3f,1.0f);
        break;
      case 11:
        setMaterialDiffuseColor(0.5f,0.9f,0.3f,1.0f);
        break;
      case 12:
        setMaterialDiffuseColor(0.8f,0.5f,0.6f,1.0f);
        break;
      case 13:
        setMaterialDiffuseColor(0.8f,0.7f,0.1f,1.0f);
        break;
      case 14:
        setMaterialDiffuseColor(0.1f,0.4,0.4f,1.0f);
        break;
      case 15:
        setMaterialDiffuseColor(0.0f,1.0f,0.6f,1.0f);
        break;
      case 16:
        setMaterialDiffuseColor(0.8f,0.5f,1.0f,1.0f);
        break;
      case 17:
        setMaterialDiffuseColor(0.3f,0.3f,0.6f,1.0f);
        break;
      case 18:
        setMaterialDiffuseColor(0.4f,0.9f,0.3f,1.0f);
        break;
      case 19:
        setMaterialDiffuseColor(0.9f,0.2f,0.9f,1.0f);
        break;
      case 1: // Shark
        setMaterialDiffuseColor(0.8f,0.8f,0.8f,1.0f);
        break;
      default:
        setMaterialDiffuseColor(0.0f,0.0f,0.0f,1.0f);
    }    
    
    /* Orient to given coordinate system */
    gl.glRotatef(-90.0, 1.0, 0.0, 0.0);        
    gl.glRotatef(-90.0, 0.0, 1.0, 0.0);    
    gl.glRotatef(-90.0, 0.0, 0.0, 1.0);          

    fish_htail = (int) (fish_htail - (int) (5.0 * fish_velocity)) % 360;

    thrash = thrashConstant * fish_velocity;

    seg1 = 0.6 * thrash * sin(fish_htail * RRAD);
    seg2 = 1.8 * thrash * sin((fish_htail + 45.0) * RRAD);
    seg3 = 3.0 * thrash * sin((fish_htail + 90.0) * RRAD);
    seg4 = 4.0 * thrash * sin((fish_htail + 110.0) * RRAD);

    chomp = 0.0;
    
    if (fish_velocity > 0.5) {
//        chomp = -(fish_velocity - 2.0) * 200.0;
          chomp = -( Math.abs(fish_htail+180) ) ;
    }    
        
    P004[1] = iP004[1] + chomp;
    P007[1] = iP007[1] + chomp;
    P010[1] = iP010[1] + chomp;
    P011[1] = iP011[1] + chomp;

    P023[0] = iP023[0] + seg1;
    P024[0] = iP024[0] + seg1;
    P025[0] = iP025[0] + seg1;
    P026[0] = iP026[0] + seg1;
    P027[0] = iP027[0] + seg1;
    P028[0] = iP028[0] + seg1;
    P029[0] = iP029[0] + seg1;
    P030[0] = iP030[0] + seg1;
    P031[0] = iP031[0] + seg1;
    P032[0] = iP032[0] + seg1;
    P033[0] = iP033[0] + seg2;
    P034[0] = iP034[0] + seg2;
    P035[0] = iP035[0] + seg2;
    P036[0] = iP036[0] + seg2;
    P037[0] = iP037[0] + seg2;
    P038[0] = iP038[0] + seg2;
    P039[0] = iP039[0] + seg2;
    P040[0] = iP040[0] + seg2;
    P041[0] = iP041[0] + seg2;
    P042[0] = iP042[0] + seg2;
    P043[0] = iP043[0] + seg3;
    P044[0] = iP044[0] + seg3;
    P045[0] = iP045[0] + seg3;
    P046[0] = iP046[0] + seg3;
    P047[0] = iP047[0] + seg3;
    P048[0] = iP048[0] + seg3;
    P049[0] = iP049[0] + seg3;
    P050[0] = iP050[0] + seg3;
    P051[0] = iP051[0] + seg3;
    P052[0] = iP052[0] + seg3;
    P002[0] = iP002[0] + seg4;
    P061[0] = iP061[0] + seg4;
    P069[0] = iP069[0] + seg4;
    P070[0] = iP070[0] + seg4;

    fish_vtail += ((fish_rotvelocity - fish_vtail) * 0.1);

    if (fish_vtail > 0.5) {
        fish_vtail = 0.5;
    } else if (fish_vtail < -0.5) {
        fish_vtail = -0.5;
    }
    segup = thrash * fish_vtail;

    P023[1] = iP023[1] + segup;
    P024[1] = iP024[1] + segup;
    P025[1] = iP025[1] + segup;
    P026[1] = iP026[1] + segup;
    P027[1] = iP027[1] + segup;
    P028[1] = iP028[1] + segup;
    P029[1] = iP029[1] + segup;
    P030[1] = iP030[1] + segup;
    P031[1] = iP031[1] + segup;
    P032[1] = iP032[1] + segup;
    P033[1] = iP033[1] + segup * 5.0;
    P034[1] = iP034[1] + segup * 5.0;
    P035[1] = iP035[1] + segup * 5.0;
    P036[1] = iP036[1] + segup * 5.0;
    P037[1] = iP037[1] + segup * 5.0;
    P038[1] = iP038[1] + segup * 5.0;
    P039[1] = iP039[1] + segup * 5.0;
    P040[1] = iP040[1] + segup * 5.0;
    P041[1] = iP041[1] + segup * 5.0;
    P042[1] = iP042[1] + segup * 5.0;
    P043[1] = iP043[1] + segup * 12.0;
    P044[1] = iP044[1] + segup * 12.0;
    P045[1] = iP045[1] + segup * 12.0;
    P046[1] = iP046[1] + segup * 12.0;
    P047[1] = iP047[1] + segup * 12.0;
    P048[1] = iP048[1] + segup * 12.0;
    P049[1] = iP049[1] + segup * 12.0;
    P050[1] = iP050[1] + segup * 12.0;
    P051[1] = iP051[1] + segup * 12.0;
    P052[1] = iP052[1] + segup * 12.0;
    P002[1] = iP002[1] + segup * 17.0;
    P061[1] = iP061[1] + segup * 17.0;
    P069[1] = iP069[1] + segup * 17.0;
    P070[1] = iP070[1] + segup * 17.0;

    gl.glPushMatrix();

    gl.glTranslatef(0.0, 0.0, -1500.0+rotationPoint); // adjust rotation point

    gl.glGetFloatv(GL.GL_MODELVIEW_MATRIX, mat);

    n = 0;
    if (mat[2] >= 0.0) {
        n += 1;
    }
    if (mat[4+2] >= 0.0) {
        n += 2;
    }
    if (mat[8+2] >= 0.0) {
        n += 4;
    }

    gl.glScalef(scaleX, scaleY, scaleZ);

    gl.glEnable(GL.GL_CULL_FACE);
    
    switch (n) {
    case 0:
        Fish_1();
        break;
    case 1:
        Fish_2();
        break;
    case 2:
        Fish_3();
        break;
    case 3:
        Fish_4();
        break;
    case 4:
        Fish_5();
        break;
    case 5:
        Fish_6();
        break;
    case 6:
        Fish_7();
        break;
    case 7:
        Fish_8();
        break;
    }
    gl.glDisable(GL.GL_CULL_FACE);

    gl.glPopMatrix();
    
} 

} // Fish
