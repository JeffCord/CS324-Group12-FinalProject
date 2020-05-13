import java.util.Map;

//PImage worldmap;
PImage soundIcon;
PImage muteIcon;
Table table;
int currentDay = 0;
IntDict cases;
FloatDict latitude, longitude;
boolean muted = false;
boolean mutePressable = true;
String state = "main";
int countryCount = 0;
CountryButton [] cButtons;

void setup() {
  size(800, 800);
  cases = new IntDict();
  latitude = new FloatDict();
  longitude = new FloatDict();

  soundIcon = loadImage("1200px-Speaker_Icon.png");
  muteIcon = loadImage("800px-Mute_Icon.png");

  table = loadTable("data/time_series_covid19_confirmed_global_clean.csv", "header");

  for (TableRow row : table.rows()) {
    String country = row.getString("Country/Region");
    int totalCases = row.getInt("93");
    float lat = row.getFloat("Lat");
    float lon = row.getFloat("Long");
    if (cases.hasKey(country)) {
      cases.add(country, totalCases);
    } else {
      countryCount ++;
      cases.set(country, totalCases);
      latitude.set(country, lat);
      longitude.set(country, lon);
    }
  }
  cButtons = new CountryButton [countryCount];
}


void draw() {
  if (state.equals("main")) {
    background(#07E8A6);
    fill(0);
    textAlign(CENTER);
    textSize(36);
    text("Welcome\nPress SPACE to view COVID-19 data.", width/2, height/2);
    if (key == ' ') {
      state = "select";
    }
  } else if (state.equals("select")) {
    background(#08ECFF);
    
    for (String caseKey: cases.keys()) {
      println(caseKey);
    }
    
    if (muted) {
      muteIcon.resize(0, 30);
      image(muteIcon, 0, 0);
    } else {
      soundIcon.resize(0, 30);
      image(soundIcon, 0, 0);
    }
    fill(0);
    textSize(16);
    text("Press 'M' to mute.", 100, 22);
    
    text("Press 'Q' to quit.", width - 90, 22);
    if (key == 'q' || key == 'Q') {
      state = "quit";
    } 
    
    smooth();
    currentDay ++;
  } else if (state.equals("quit")) {
    background(#07E8A6);
    fill(0);
    textAlign(CENTER);
    textSize(64);
    text("Good bye", width/2, height/2);
  }
}

void keyPressed() {
  if (key == 'm' || key == 'M') {
    if (mutePressable) {
      muted = !muted;
      mutePressable = false;
    }
  }
}

void keyReleased() {
  if (!mutePressable) {
    mutePressable = true;
  }
}
