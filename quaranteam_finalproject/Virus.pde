class Virus {
  float radius;
  float xloc;
  float yloc;
  float rot;
  float rotSpeed;
  float xSpeed;
  float ySpeed;
  PShape body;
  
  Virus(float radius, float xloc, float yloc, PImage img){
   this.radius = radius;
   this.xloc = xloc;
   this.yloc = yloc;
   noStroke();
   body = createShape(SPHERE, radius);
   body.setTexture(img);
   rot = 0;
   rotSpeed = .005;
   xSpeed = 1;
   ySpeed = 1;
  }
  
  void show() {
   rot += rotSpeed;
   push();
   translate(xloc,yloc);
   rotateY(rot);
   shapeMode(CORNER);
   tint(255,0,0);
   shape(body);
   pop();
  }
  
  void move() { 
    xloc += xSpeed;
    yloc += ySpeed;
  }
}
