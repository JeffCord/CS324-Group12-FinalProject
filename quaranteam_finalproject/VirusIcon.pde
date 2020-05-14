class VirusIcon {
  float x, y, size;

  VirusIcon (float x, float y, float size) {
    this.x = x;
    this.y = y;
    this.size = size;
  }

  void display() {
    fill(150);
    circle(x, y, size);

    fill(220, 0, 0);
    circle(x, y - (size/2), size * 0.2); //top
    circle(x, y + (size/2), size * 0.2); //bottom
    circle(x, y - (size/5), size * 0.2); //top middle
    circle(x, y + (size/5), size * 0.2); //bottom middle

    circle(x - (size/2.5), y - (size/2.5), size * 0.2); //left side
    circle(x - (size/2.5), y + (size/2.5), size * 0.2);
    circle(x - (size/2), y, size * 0.2); //top
    circle(x + (size/2), y, size * 0.2); //bottom

    circle(x + (size/2.5), y - (size/2.5), size * 0.2); //right side
    circle(x + (size/2.5), y + (size/2.5), size * 0.2);
  }
}
