PImage worldmap;
Table table;
int currentYear = 1880; 

void setup() {
  size(1200, 600);
  frameRate(2);

  //worldmap = loadImage("worldmapoutline.jpg");
  //image(worldmap, 0, 0);
  //worldmap.resize(width, height);

  table = loadTable("data/COVID-19_geo_timeseries_ver_0311_clean.csv", "header");
}

void draw() {
  //background(worldmap);
  smooth();
  currentYear ++;

  for (TableRow row : table.rows()) {

    //float mass = row.getFloat("mass");
    //float reclat = row.getFloat("reclat");
    //float reclong = row.getFloat("reclong");
    //int year = row.getInt("year");
    ////println(name, mass);

    ////latitude -90~90
    ////longtitude -180~180

    //float mapX = map(reclong, -180, 180, 0, width);//remaping to the world map
    //float mapY = map(reclat, -90, 90, 0, height);

    //float mapMass = map(mass, 0, 2000000, 6, 8);


    //if (currentYear == year) {
    //  stroke(255, 0, 0);
    //  strokeWeight(mapMass);
    //  point(mapX, mapY);
    //} 
    
    
    
    
  }
}
