class CountryButton extends Button {
  String country;
  int cases;
  float latitude;
  float longitude;
  color c1 = color(255, 0, 0, 255);
  color c2 = color(255, 0, 0, 150);


  CountryButton (float x, float y, float size, String country, int cases, float latitude, float longitude) {
    super(x, y, size);
    this.country = country;
    this.cases = cases;
    this.latitude = latitude;
    this.longitude = longitude;
  }

  void display() {
    rectMode(CENTER);
    noStroke();
    if (on) {
      fill(c2);
    } else {
      fill(c1);
    }
    square(x, y, size);
    fill(0);
    textSize(10);
    textAlign(CENTER);
    text(country, x, y);
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
          return "country";
        }
      }
    } else if (!mousePressed || mouseButton != LEFT) {
      pressable = true;
      on = false;
    }
    return "select";
  }
}
