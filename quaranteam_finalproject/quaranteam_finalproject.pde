import java.util.Map;
import processing.sound.*;

SoundFile pop1;
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
PImage virusText;
PImage bodyText;
CountryButton [] cButtons;
CountryButton selectedButton = null;
Virus body_1;
spikes spikes_1;

int caseNum = -1;

void setup() {
  size(800, 800, P3D);
  
  //if (frameCount % 6 == 0) {
    //frameRate(2);
  //}
  cases = new IntDict();
  latitude = new FloatDict();
  longitude = new FloatDict();

  pop1 = new SoundFile(this, "pop1.wav");
  pop1.amp(0.3);

  soundIcon = loadImage("1200px-Speaker_Icon.png");
  muteIcon = loadImage("800px-Mute_Icon.png");

  table = loadTable("data/time_series_covid19_confirmed_global_clean.csv", "header");

  virusText = loadImage("red.jpg");
  bodyText = loadImage("body.jpg");
  body_1 = new Virus(100, random(0, 200), random(0, 100), bodyText);
  spikes_1 = new spikes(body_1.radius*.044, body_1.xloc, body_1.yloc, virusText);

  // populate the table with data
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

  // populate the buttons array
  cButtons = new CountryButton [countryCount];
  float spacing = 15;
  int i = 0;
  float xPos = 30;
  float yPos = 0;
  float buttonSize = 40;
  for (String caseKey : cases.keys()) {
    if (i % 14 == 0) {
      yPos = yPos + buttonSize + spacing;
      xPos = 30;
    } else {
      xPos += buttonSize + spacing;
    }
    cButtons[i] = new CountryButton(xPos, yPos, buttonSize, caseKey, cases.get(caseKey), latitude.get(caseKey), longitude.get(caseKey));
    i++;
  }
}


void draw() {
  caseNum ++;


  if (state.equals("main")) {
    background(225);//#07E8A6
    body_1.show();
    spikes_1.show();
    body_1.move();
    spikes_1.xloc = body_1.xloc;
    spikes_1.yloc = body_1.yloc;
    fill(0);
    textAlign(CENTER);
    textSize(26);
    //text("Welcome\nPress SPACE to view COVID-19 data.", width/2, height/2, 150);
    text("Welcome\n\nPress SPACE\nto view COVID-19 data for each country.", width/2, 200, 150);



    for (TableRow row : table.rows()) {
      String province = row.getString("Province/State");
      String country = row.getString("Country/Region");
      float latitude = row.getFloat("Lat");
      float longtitude = row.getFloat("Long");
      int totalCases = row.getInt("93");


      float mapX = map(longtitude, -180, 180, 0, width - 10); //selectedButton.lonitude
      float mapY = map(latitude, -90, 90, height/2, height-10); //selectedButton.latitude
      
      noFill();
      stroke(0);
      strokeWeight(1);
      rect(0+10, height/2, width-20, height/2 - 10);

      if (caseNum == totalCases) { //selectedButton.cases
        stroke(255, 0, 0);
        fill(#FF7F50);
        textSize(15);

        if (totalCases < 1000) {
          strokeWeight(5);
          point(mapX, mapY);
          text(totalCases, mapX+10, mapY+1);
          text(country, mapX+1, mapY+12);
        } else if (totalCases < 5000) {
          strokeWeight(20);
          point(mapX, mapY);
          text(totalCases, mapX+10, mapY+1);
          text(country, mapX+1, mapY+12);
        } else if ((totalCases < 10000) | (totalCases >=5000)) {
          strokeWeight(50);
          point(mapX, mapY);
          text(totalCases, mapX+10, mapY+1);
          text(country, mapX+1, mapY+12);
        } else if ((totalCases < 20000) | (totalCases >= 10000)) {
          strokeWeight(80);
          point(mapX, mapY);
          text(totalCases, mapX+10, mapY+1);
          text(country, mapX+1, mapY+12);
        }
      }
    }




    if (key == ' ') {
      state = "select";
    }
  } else if (state.equals("select")) {
    background(#08ECFF);

    int i = 0;
    boolean willChangeState = false;
    for (String caseKey : cases.keys()) {
      willChangeState = cButtons[i].update();
      cButtons[i].display();
      cButtons[i].isOver();
      
      if (cButtons[i].on == true) {
        cButtons[i].size = 50;
        cButtons[i].textSize = 15;
        cButtons[i].z = 10;
      } else {
        cButtons[i].size = 40;
        cButtons[i].textSize = 10;
        cButtons[i].z = 0;
      }

      if (willChangeState) {
        state = "country";
        selectedButton = cButtons[i];
        willChangeState = false;
      }
      i++;
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
  } else if (state.equals("country")) {
    background(#00F1F7);
    int casesTotal = selectedButton.cases;
    VirusIcon vIcon = new VirusIcon(width/2, height/2, 100 + (casesTotal * 0.001));
    vIcon.display();

    fill(0);
    textAlign(CENTER);
    textSize(30);
    text("Confirmed Cases:\n" + casesTotal, width/2, height/2);
    String data = selectedButton.country + "\nCoordinates: " + selectedButton.latitude + ", " + selectedButton.longitude;
    text(data, width/2, height - 200);

    textSize(20);
    text("Press SPACE to go back to the selection screen.", width/2, height - 30);
  } else if (state.equals("quit")) {
    background(#07E8A6);
    fill(0);
    textAlign(CENTER);
    textSize(64);
    text("Good bye", width/2, height/2 - 40);
  }
}

void keyPressed() {
  if (key == 'm' || key == 'M') {
    if (mutePressable) {
      muted = !muted;
      mutePressable = false;
    }
  } else if (state.equals("country")) {
    if (key == ' ') {
      state = "select";
      selectedButton = null;
    } else if (key == 'q' || key == 'Q') {
      state = "quit";
      selectedButton = null;
    }
  }
}

void keyReleased() {
  if (!mutePressable) {
    mutePressable = true;
  }
}
