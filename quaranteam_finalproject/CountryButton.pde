class CountryButton extends Button {
  String country;
  float latitude;
  float longitude;
  
  CountryButton (float x, float y, float size, String country, float latitude, float longitude) {
    super(x, y, size);
    this.country = country;
    this.latitude = latitude;
    this.longitude = longitude;
  }
  
  void display() {
    rectMode(CENTER);
    fill(0);
    textAlign(CENTER);
    text(country, x, y);
    if (isPressed) {
      fill(c2);
    } else {
      fill(c1);
    }
    square(x, y, size);
  }
  
  void update() {
  }
}
