class Button {
  float x;
  float y;
  color col;
  boolean pressed;
  int type;
  PShape img;

  Button(float x, float y, color col) {
    this.x = x;
    this.y = y;
    this.col = col;
    this.pressed = false;
  }

  Button(float x, float y, color col, PShape img) {
    this.x = x;
    this.y = y;
    this.col = col;
    this.img = img;
    this.pressed = false;
  }

  boolean pressed() {
    if (pressed == false) {
      pressed = true;
      return pressed;
    } else if (pressed == true) {
      pressed= false;
      return pressed;
    }
    return pressed;
  }

  void draw() {
    rectMode(CENTER);
    noStroke();
    fill(col);
    rect(x, y, 40, 40, 10);
    if (img!=null) {
      shapeMode(CENTER);
      shape(img, x, y, 30, 30);
    }

    rectMode(CORNER);
  }
}

class Village {
  float x;
  float y;
  boolean hi;

  Village(float x, float y) {
    this.x = random(x, x+500);
    this.y = random(y, y+500);
    hi = false;
  }

  void highlight() {
    if (hi == false) {
      hi = true;
    } else {
      hi = false;
    }
  }

  void draw() {
    if (hi ==true) {
      stroke(#f44336);
      strokeWeight(1);
    } else {
      stroke(0); 
      strokeWeight(0.5);
    }
    point(x, y);
  }
}

class Town {
  float x;
  float y;
  boolean hi;
  int roads;
  Town(float x, float y) {
    this.x = random(x, x+500);
    this.y = random(y, y+500);
    hi = false;
    roads=0;
  }

  void highlight() {
    if (hi == false) {
      hi = true;
    } else {
      hi = false;
    }
  }

  void draw() {
    if (hi ==true) {
      stroke(#45A2DB);
      strokeWeight(4);
    } else {
      stroke(0); 
      strokeWeight(2);
    }
    point(x, y);
  }
}

class City {
  float x;
  float y;
  boolean hi;
  int roads;
  City(float x, float y) {
    this.x = random(x, x+500);
    this.y = random(y, y+500);
    hi = false;
    roads =0;
  }

  void highlight() {
    if (hi == false) {
      hi = true;
    } else {
      hi = false;
    }
  }

  void draw() {
    if (hi ==true) {
      stroke(#ff9800);
      strokeWeight(5);
    } else {
      stroke(0); 
      strokeWeight(4);
    }
    point(x, y);
  }
}

class LargeCity {
  float x;
  float y;
  boolean hi;

  LargeCity(float x, float y) {
    this.x = random(x, x+500);
    this.y = random(y, y+500);
    hi = false;
  }

  void highlight() {
    if (hi == false) {
      hi = true;
    } else {
      hi = false;
    }
  }

  void draw() {
    if (hi ==true) {
      stroke(#ff9800);
      strokeWeight(8);
    } else {
      stroke(0); 
      strokeWeight(7);
    }
    point(x, y);
  }
}

class Kingdom {
  String kF[];
  int kV[];

  Kingdom(String[] feat) {
    kF = feat;
    kV = new int[24];
    kV[0] = int((random(1000, 50000)/100));
    kV[1] = int(random(10, 50));
    kV[2] = int(random(10000, 500000));
    kV[3] = int(sqrt(kV[2]));
    kV[4] = int(kV[3]/5);
    kV[5] = int(pow((kV[3]/30), 2));
    kV[6] = 30;
    kV[7] = 900;

    if (kV[1] <=10) {
      kV[8] = 14;
    } else if (kV[1] <=15) {
      kV[8] = 21;
    } else if (kV[1] <=20) {
      kV[8] = 28;
    } else if (kV[1] <=30) {
      kV[8] = 43;
    } else if (kV[1] <=40) {
      kV[8] = 57;
    } else if (kV[1] <=45) {
      kV[8] = 64;
    } else {
      kV[8] = 65;
    }

    kV[9] = kV[2] * kV[8] / 100;
    kV[10] = kV[2] - kV[9];
    kV[11] = kV[1] * kV[2];
    kV[12] = int(kV[11] * 0.02);

    if (kV[11] <= 10000) {
      kV[13]=int(kV[11]*0.98); //Village People
    } else if (kV[11] <= 100000) {
      kV[14]=int(kV[11]*0.09); //Townfolk
    } else if (kV[11] <= 1000000) {
      kV[15]=int(kV[11]*0.03); //Cityfolk
    } else {
      kV[13]=int(kV[11]*0.89); //Village People
      kV[14]=int(kV[11]*0.06); //Townfolk
      kV[15]=int(kV[11]*0.025); //Cityfolk  
      kV[16]=int(kV[11]*0.005); //Large Cityfolk
    }
    kV[17] = round(kV[13]/500); //Number of Villages
    kV[18] = round(kV[14]/4000); //Number of Towns
    kV[19] = round(kV[15]/6000); //Number of Cities
    kV[20] = round(kV[16]/50000); //Number of Large Cities

    kV[21] = int(kV[11]/500000*sqrt(kV[0])); //Number of Castles
    kV[22] = int(kV[22]*0.66); //Active Castles
    kV[23] = int(kV[22] - kV[22]); //Abandon Castles
  }
}



float rX;
float rY;
float rSc;
PFont font;
Kingdom k;
Village[] V;
Town[] T;
City[] C;
LargeCity[] LC;

Button Vbutton;
Button Tbutton;
Button Cbutton;
Button reset;
Button save;

Table table;
PShape locButton;
int seed;
void setup() {
  size(900, 620); 
  seed = int(random(1000));
  noiseSeed(seed);
  randomSeed(seed);
  font = loadFont("SansSerif-12.vlw");
  locButton = loadShape("highlight.svg");

  String[] kFeatures = loadStrings("Kingdom_Features.txt");
  k = new Kingdom(kFeatures);
  rSc = 500 / sqrt(k.kV[5]);
  rX = 2 * (width / 3) - 275;
  rY = height/2 -250;
  background(255);


  drawGrid();
  Vbutton = new Button(rX+40, rY+530, #f44336, locButton);
  Tbutton = new Button(rX+90, rY+530, #45A2DB, locButton);
  Cbutton = new Button(rX+140, rY+530, #ff9800, locButton);
  reset = new Button(rX+430, rY+530, #8E8E8E);
  save = new Button(rX+480, rY+530, #333333);
  Vbutton.draw();
  Tbutton.draw();
  Cbutton.draw();
  reset.draw();
  save.draw();
  V = new Village[k.kV[17]];
  T = new Town[k.kV[18]];
  C = new City[k.kV[19]];
  LC = new LargeCity[k.kV[20]];
  for (int i=0; i<V.length; i++) {
    V[i] = new Village(rX, rY);
  }
  for (int i=0; i<T.length; i++) {
    T[i] = new Town(rX, rY);
  }
  for (int i=0; i<C.length; i++) {
    C[i] = new City(rX, rY);
  }
  for (int i=0; i<LC.length; i++) {
    LC[i] = new LargeCity(rX, rY);
  }
  //terrain();

  frameRate(1);


  table = new Table(); //initialize and create the table

    TableRow newRow = table.addRow(); //initialize the second row of the table
  for (int i =0; i<k.kV.length; i++) {
    table.addColumn(k.kF[i]); //contructs the columns and inputs the characteristic names as the data values
    newRow.setInt(k.kF[i], k.kV[i]); //contructs the row and inputs the values as the data values
  }
}

void draw() {
  background(255);
  drawGrid();
  drawkF();
//  for (int i =0; i<C.length; i++) {
//    for (int idx=0; idx<C.length; idx++) {
//      if (C[i].roads<=4) {
//        stroke(#988F78);
//        noFill();
//        strokeWeight(0.75);
//        beginShape();
//        Roads(2, C[i].x, C[i].y, C[idx].x, C[idx].y, C[i]);
//        endShape();
//      }
//    }
//  }
//
//  for (int i =0; i<T.length; i++) {
//    for (int idx=0; idx<T.length; idx++) {
//      if (T[i].roads<=2 && T[idx].roads<=2) {
//        stroke(#CEC09C);
//        noFill();
//        strokeWeight(0.2);
//        beginShape();
//        Roads(2, T[i].x, T[i].y, T[idx].x, T[idx].y, T[i],T[idx]);
//        endShape();
//      }
//    }
//  }

  drawLocations();

  Vbutton.draw();
  Tbutton.draw();
  Cbutton.draw();
  reset.draw();
  save.draw();
}

void drawkF() {
  float kFX = 210;
  float kFY = 90;
  float kFSp = 20;
  for (int i =0; i<k.kF.length; i++) {
    fill(0);
    textFont(font, 12);
    textAlign(RIGHT);
    text(k.kF[i], kFX, i*kFSp+kFY); //kingdom characteristics
    textAlign(LEFT);
    text(k.kV[i], kFX+10, i*kFSp+kFY); //kingdom values
  }
}


void drawGrid() {
  for ( int x=0; x< sqrt (k.kV[5]); x++) {
    for (int y=0; y< sqrt (k.kV[5]); y++) {
      stroke(200);
      strokeWeight(1);
      noFill();
      rect(rX + x * rSc, rY + y * rSc, rSc, rSc);
    }
  }
}

void drawLocations() {
  for (int i=0; i<V.length; i++) {
    V[i].draw();
  }
  for (int i=0; i<T.length; i++) {
    T[i].draw();
  }
  for (int i=0; i<C.length; i++) {
    C[i].draw();
  }
  for (int i=0; i<LC.length; i++) {
    LC[i].draw();
  }
}

void mousePressed() {
  if (mouseX>Vbutton.x-20 && mouseX<Vbutton.x+20 && mouseY>Vbutton.y-20 && mouseY<Vbutton.y+20) {
    for (int i=0; i<V.length; i++) {
      V[i].highlight();
    }
  } else if (mouseX>Tbutton.x-20 && mouseX<Tbutton.x+20 && mouseY>Tbutton.y-20 && mouseY<Tbutton.y+20) {
    for (int i=0; i<T.length; i++) {
      T[i].highlight();
    }
  } else if (mouseX>Cbutton.x-20 && mouseX<Cbutton.x+20 && mouseY>Cbutton.y-20 && mouseY<Cbutton.y+20) {
    for (int i=0; i<C.length; i++) {
      C[i].highlight();
    }

    for (int i=0; i<LC.length; i++) {
      LC[i].highlight();
    }
  } else if (mouseX>reset.x-20 && mouseX<reset.x+20 && mouseY>reset.y-20 && mouseY<reset.y+20) {
    setup();
  } else if (mouseX>save.x-20 && mouseX<save.x+20 && mouseY>save.y-20 && mouseY<save.y+20) {
    saveTable(table, "table-###"+".csv"); //saves the table to a csv file. ->this can later be used to make an excel spreadsheet with the map image
  }
}


void Roads(int levs, float x, float y, float x2, float y2, Town town, Town townTwo) {
  int max = 2;
  if (dist(x, y, x2, y2)<100 && town.roads<=max && townTwo.roads<=max) {
    if (levs==0) {
      vertex(x, y);
      if (town.roads<max && townTwo.roads<max) {
        town.roads+=1;
        townTwo.roads+=1;
      }
    } else {
      float xmid = 0.5*(x+x2);
      float ymid = 0.5*(y+y2);
      float r = 5*(noise(100, 100));
      float r2 = 5*(noise(1000, 1000));

      ymid+=r;
      xmid+=r2;

      Roads(levs-1, x, y, xmid, ymid, town, townTwo);
      Roads(levs-1, xmid, ymid, x2, y2, town, townTwo);
    }
  }
}

void Roads(int levs, float x, float y, float x2, float y2, City city) {

  if (dist(x, y, x2, y2)<100 && city.roads<=4) {
    if (levs==0) {
      vertex(x, y);
      if(city.roads<4){
       city.roads+=1; 
      }
    } else {
      float xmid = 0.5*(x+x2);
      float ymid = 0.5*(y+y2);
      float r = 5*(noise(100, 100));
      float r2 = 5*(noise(1000, 1000));

      ymid+=r;
      xmid+=r2;

      Roads(levs-1, x, y, xmid, ymid, city);
      Roads(levs-1, xmid, ymid, x2, y2, city);
    }
  }
}

