class spikes extends Virus {
  float size;
  float xloc;
  float yloc;
  float scl;
  float sclSpeed;
  float scale;
  float rot;
  float rotSpeed;
  float xSpeed;
  float ySpeed;
  boolean flag;
  PShape spikes;

  spikes (float radius, float xloc, float yloc, PImage img) {
    super(radius, xloc, yloc, img);
    this.xloc = xloc;
    this.yloc = yloc;
    this.radius = radius;
    fill(255,0,0);
    spikes = loadShape("Coronavirus_Lowpoly.obj");
    spikes.setTexture(img);
    sclSpeed = .05;
    rot = 0;
    rotSpeed = .005;
  }
  
  
  void show(){
    rot += rotSpeed;
    scl += sclSpeed;
    radius = abs(sin(scl)) + 4;
    pushMatrix();
      translate(xloc, yloc);
      rotateY(rot);
      scale(radius);
      shapeMode(CORNER);
      tint(255,0,0);
      shape(spikes);
    popMatrix();  
  }
  
}
