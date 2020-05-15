class CountryButton extends Button {
  String country;
  int cases;
  float latitude;
  float longitude;
  color c1 = color(255, 0, 0, 255);
  color c2 = color(255, 0, 0, 150);
  float z;
  float textSize;

  CountryButton (float x, float y, float size, String country, int cases, float latitude, float longitude) {
    super(x, y, size);
    this.country = country;
    this.cases = cases;
    this.latitude = latitude;
    this.longitude = longitude;
    z = 0;
    textSize = 10;
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
    textSize(textSize);
    textAlign(CENTER);
    text(country, x, y, z);
  }

}
