// CaptureBreath

// inspired by Breath, Norihisa Hashimoto
// http://zeroworks.jp/breath/
//
// based on a sketch by Yota Odaka(@62grow2e)

import codeanticode.syphon.*;
PImage img;
SyphonClient client;

int cam_w = 320/9*16;
int cam_h = 320;
int fps = 24;
int num_frames = 1000; // how many frames in the breath?
int t = 0;
PImage breath;

void setup() {  
  size(cam_w+num_frames+60, 320, P3D);
  frameRate(fps);
  breath = createImage(num_frames, height, RGB);
  
  client = new SyphonClient(this, "UDPSyphonClient");
  img = createImage(num_frames, height, RGB);

}

void draw() {
  if (client.available()) {
    img = client.getImage(img);
    image(img, 0, 0, cam_w, cam_h);
  }
  
  // where we will draw
  strokeWeight(1);
  stroke(255, 0, 0);
  line(cam_w/2, 0, cam_w/2, height);
  
  breath.copy(img, img.width/2, 0, 1, img.height, t, 0, 1, height);
  image(breath, cam_w+60, 0);
  
  // and update
  t = (t+1)%num_frames;
}

