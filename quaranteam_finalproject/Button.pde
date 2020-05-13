class Button {
  float x, y, size;
  boolean pressable = true;
  boolean on = false;

  Button (float x, float y, float size) {
    this.x = x;
    this.y = y;
    this.size = size;
  }

  String update() {
    if (mousePressed) {
      if (mouseButton == LEFT && pressable) {
        if (mouseX >= x - (size/2) && mouseX <= x + (size/2) && mouseY >= y - (size/2) && mouseY <= y +(size/2)) {
          pressable = false;
          on = !on;
          if (!muted) {
            pop1.play();
          }
        }
      }
    } else if (!mousePressed || mouseButton != LEFT) {
      pressable = true;
      on = false;
    }
    return null;
  }
}
