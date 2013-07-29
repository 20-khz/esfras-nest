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
  }
}