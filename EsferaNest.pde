/**
 * Modified from a sketch by David Pena. 
 * Esfera
 * by David Pena.  
 *  
 */
import ddf.minim.*;

Minim minim;
AudioInput in;

int count = 16000;
Strand[] strands ;
float radius = 100;
float rx;
float ry;
float rotationX = 0;
float rotationY = 0;

void setup() 
{
  size(1024, 768, P3D);
  radius = height/3.5;
  strands = new Strand[count];
  // Determine each strand
  for (int i = 0; i < strands.length; i++) {
    strands[i] = new Strand();
  }
  noiseDetail(5);

  rx = 0;
  ry = 0;

  minim = new Minim(this);
  // use the getLineIn method of the Minim object to get an AudioInput
  in = minim.getLineIn();
}

void draw() 
{
  background(0);  
  // Center mouse in middle and scale
  rotationX += 0.5;
  rotationY += 0.5;
  translate(width/2, height/2);
  //Draw
  fill(0);
  noStroke();
  sphere(radius);
  // Camera
  rotateY(rotationX);
  rotateX(rotationY);

  for (int i = 0; i < strands.length; i++) {
    strands[i].update();
    strands[i].render();
  }
}


class Strand
{
  float z;
  float rotation;
  float strandScale;
  float theta;

  Strand() 
  { 
    z = random(-radius, radius);
    rotation = random(TWO_PI);
    strandScale = random(1.15, 1.2);
    theta = asin(z/radius);
  }

  /* Render the shape. Strands point towards the center */
  void render() 
  {
    float x1 = radius * cos(theta) * cos(rotation);
    float y1 = radius * cos(theta) * sin(rotation);
    float z1 = radius * sin(theta);

    float x2 = x1 * strandScale;
    float y2 = y1 * strandScale;
    float z2 = z1 * strandScale;

    strokeWeight(1);
    beginShape(LINES);
    stroke(0);
    vertex(x1, y1, z1);
    stroke(200, 150);
    vertex(x2, y2, z2);
    endShape();
  }

  void update()
  {

    radius = in.left.get(256) * 500;
    println(radius);
  }
}