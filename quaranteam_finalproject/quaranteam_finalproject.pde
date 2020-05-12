PImage worldmap;
PImage soundIcon;
PImage muteIcon;
Table table;
int currentDay = 0;



void setup() {
  size(1200, 600);

  worldmap = loadImage("worldmapoutline.jpg");
  image(worldmap, 0, 0);
  worldmap.resize(width, height);

  soundIcon = loadImage("1200px-Speaker_Icon.png");
  muteIcon = loadImage("800px-Mute_Icon.png");



  table = loadTable("data/time_series_covid19_confirmed_global_clean.csv", "header");
}

void draw() {
  background(worldmap);
  soundIcon.resize(0,40);
  image(soundIcon, 0, 0);
  muteIcon.resize(0,40);
  image(muteIcon, 50, 0);
  smooth();
  currentDay ++;

  for (TableRow row : table.rows()) {
    String province = row.getString("Province/State");
    String country = row.getString("Country/Region");
    float latitude = row.getFloat("Lat");
    float longtitude = row.getFloat("Long");


    for (int dayNumber = 0; dayNumber < 94; dayNumber = dayNumber+1) {
      int caseNumber = row.getInt(dayNumber);

      //latitude -90~90
      //longtitude -180~180

      float mapX = map(longtitude, -180, 180, 0, width);//remaping to the world map
      float mapY = map(latitude, -90, 90, 0, height);

      float cases = map(caseNumber, 0, 2000000, 6, 8);


      if (currentDay == dayNumber) {
        stroke(255, 0, 0);
        strokeWeight(cases);
        point(mapX, mapY);
        fill(0);
        text(cases,mapX+1, mapY+1);
      }
    }
  }
}
