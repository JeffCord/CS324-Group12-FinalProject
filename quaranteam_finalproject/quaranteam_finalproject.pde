PImage worldmap;
Table table;
int currentYear = 1880; 

void setup() {
  size(1200, 600);
  frameRate(2);

  //worldmap = loadImage("worldmapoutline.jpg");
  //image(worldmap, 0, 0);
  //worldmap.resize(width, height);

  table = loadTable("data/time_series_covid19_confirmed_global_clean.csv", "header"); //COVID-19_geo_timeseries_ver_0311_clean.csv
}

void draw() {
  //background(worldmap);
  smooth();
  currentYear ++;

  for (TableRow row : table.rows()) {

    String name = row.getString("name"); //get the first row
    String province = row.getString("Province/State");
    String country = row.getString("Country/Region");

    float latitude = row.getFloat("Lat");
    float longtitude = row.getFloat("Long");

    ////latitude -90~90
    ////longtitude -180~180

    float mapX = map(longtitude, -180, 180, 0, width);//remaping to the world map
    float mapY = map(latitude, -90, 90, 0, height);

    float case = map(case, 0, 2000000, 6, 8);

    //if (currentYear == year) {
    //  stroke(255, 0, 0);
    //  strokeWeight(case);
    //  point(mapX, mapY);
    //} 
    
    
    
    
  }
}
