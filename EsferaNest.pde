/**
 * Modified from a sketch by David Pena. 
 * Esfera
 * by David Pena.  
 *  
 */
import ddf.minim.*;
import ddf.minim.analysis.*;
// [TODO] Without this the import breaks 
import ddf.minim.analysis.FFT;

Minim minim;
AudioInput in;

FFT fftLin;
FFT fftLog;

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

void setupMinim()
{
  minim = new Minim(this);
  // use the getLineIn method of the Minim
  // object to get an AudioInput
  in = minim.getLineIn();
  /* 
  * create an FFT object that has a time-domain buffer the same
  * size as jingle's sample buffer note that this needs to be a 
  * power of two and that it means the size of the spectrum will 
  * be 1024.
  */
  fftLin = new FFT(in.bufferSize(), in.sampleRate());
  // calculate the averages by grouping frequency bands linearly. 
  // use 30 averages.
  fftLin.linAverages(30);
  // create an FFT object for calculating logarithmically spaced 
  // averages
  fftLog = new FFT( in.bufferSize(), in.sampleRate() );
  /* 
  * calculate averages based on a miminum octave width of 22 Hz
  * split each octave into three bands
  * this should result in 30 averages
  */
  fftLog.logAverages(22, 3);
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