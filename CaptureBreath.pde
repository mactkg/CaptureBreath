// CaptureBreath

// inspired by Breath, Norihisa Hashimoto
// http://zeroworks.jp/breath/
//
// based on a sketch by Yota Odaka(@62grow2e)

import processing.video.*;
Capture cam;

int cam_w = 320/9*16;
int cam_h = 320;
int fps = 24;
int num_frames = 1000; // how many frames in the breath?
int t = 0;
PImage breath;

void setup() {
  // setup camera
  String[] cameras = Capture.list();
  for(int i = 0; i < cameras.length; i++) {
    println("[", i, "] ", cameras[i]); 
  }
  cam = new Capture(this, cameras[18]);
  cam.start();
  
  size(cam_w+num_frames+60, 320);
  frameRate(fps);
  breath = createImage(num_frames, height, RGB);
}

void draw() {
  // mirrored image
  pushMatrix();
  translate(cam_w,0);
  scale(-1, 1);
  image(cam, 0, 0, cam_w, cam_h);
  popMatrix();
  
  // where we will draw
  strokeWeight(1);
  stroke(255, 0, 0);
  line(cam_w/2, 0, cam_w/2, height);
  
  breath.copy(cam, cam.width/2, 0, 1, cam.height, t, 0, 1, height);  
  image(breath, cam_w+60, 0);
  
  // and update
  t = (t+1)%num_frames;
}

// update camera
void captureEvent(Capture c) {
  c.read();
}
