/**
 
 Author: Derya C
 Date: 2015-10-08
 
 **/

int w = 120;      // Breite Ellipse
int h = 50;       // Höhe Ellipse
int r = 30;       // r = Runde Ecken, Keine Ecke


// 2. Übung->kartesisches Koordinatensystem
float xi0 = 0.5 * width;  
float yi0 = 0.8 * height;

float M = 20;  // Für den Maßstab
float balkenVertikal = 15 / M;

float angleL = 45 - 180;  // Winkel für die Drehung der Kanonen
float angleR = -45 + 180;

int count;

String buttonLeft;
String buttonRight;

// 3. Übung-> Zeitachse
int timeScale = 1;
int frmRate = 80;   // wie viele Bilder in der Sekunde angezeigt werden sollen
float dt = 1.0 / frmRate;  
float g = 9.81f;

float xt = 0;
float yt = 0;
float vx = 0;
float vy = 0;
float pulverladungR = 30;
float pulverladungL = 30;
float pulverladungMaximum = 60;
float pulverladungMinimum = 1;


float blackBeaX = 10;
float blackBeaY = 6.5;
/**
 float x0 = blackBeaX;
 float y0 = blackBeaY;
 **/
float t = 0;


float blueBeaX = 0;
float blueBeaY = 1.5;
float blueBeaRadius = 60;


int countLeft = 0;
int countRight = 0;
boolean clickedLeft = false;

BlackBea schwarzeKugel;   // schw. Kugel in der neuen Klasse

// 4. Übung
float maxRotR = 150;    // max. Rotation der Kanone für die r
float minRotR = 101;    // min. Rotation der Kanone für die r
float maxRotL = -101;   // max. Rotation der Kanone für die l
float minRotL = -150;   // min. Rotation der Kanone für die l

int weg = -100;    // Koord. damit blackBea "verschwindet"

// Khaki/Wand Koord.
float khakiRx = 9;     // Rechts Khaki/Wand
float khakiRy = 4.5;
float khakiLx = -11;    // Links Khaki/Wand
float khakiLy = 4.5;
float khakiWidth = 40;
float khakiHeight = 90;

// Werte für Rückstoß
Kanone kanoneL; 
Kanone kanoneR; 
float kanoneGewicht = 1000; // Gewicht in kg
float kanoneLvX = 0; // Geschwindigkeit der Kanone links
float kanoneRvX = 0; // Geschwindigkeit der Kanone rechts
float kanoneLx = 0; // Verschiebung der Kanone links
float kanoneRx = 0; // Verschiebung der Kanone rechts
float kanoneKoeffizent = 0.8; // Reibungskoeffizient
float kanoneRollEnde = 1; // Stopper hinter den Kanonen

// 5. Übung
BlueBea blaueKugel;

// 6. Übung 
float cW = 0.45; // Strömungsbeiwert
float rho = 1.3; // Luftdichte in kg/m^3
float luftKonstante = rho * cW * PI / 2;   // Zeitkonstante nach Newton

// 7. Übung, Wind
float windGrenze = 4;
float wind = random(2 * windGrenze) - windGrenze;
boolean windChange = false;

void setup() {
  size(800, 400);            // Arbeitsfläche
  surface.setTitle("Derya Celebi - Bombing Game");  // Titel

  xi0 = 0.5 * width;  
  yi0 = 0.8 * height;

  schwarzeKugel = new BlackBea(blackBeaX, blackBeaY, 30);
  blaueKugel = new BlueBea(blueBeaX, blueBeaY, blueBeaRadius);
  kanoneL = new Kanone(-16.5, 0.5, angleL);
  kanoneR = new Kanone(16.5, 0.25, angleR);
  
  // zweiter Teil der Zeitkonstante
  luftKonstante = luftKonstante * (schwarzeKugel.blackBeaRadius / M / 2) * (schwarzeKugel.blackBeaRadius / M / 2) / schwarzeKugel.blackBeaGewicht;
}

void draw() {

  background(255);  // weisser Hintergrund


  pushMatrix();
  //translate(xi0, yi0);

  fill(0, 255, 0);
  rect(calcCoordX(-16.5), calcCoordY(12.5), w, h, r);     // Links Oben Grün
  fill(0, 0, 0);
  textSize(20);
  // Mouse count für linken Score
  /**if(countLeft == 0) {
   buttonLeft = "SCORES";
   } 
   else {
   buttonLeft = " " + countLeft;
   }**/

  /**if(colli) {
   blackBeaX = vx1 * t + x0;
   blackBeaY = (-g * t * t / 2) + (vy1 * t) + y0;
   float ente = (schwarzeKugel.blackBeaRadius/2 * schwarzeKugel.blackBeaRadius/2 + blueBeaRadius/2 * blueBeaRadius/2);
   
   if((clicked && diff(schwarzeKugel.blackBeaX, schwarzeKugel.blackBeaY, blueBeaX, blueBeaY) <= ente)) {
   countLeft++; 
   
   
   countRight++;
   clicked = false;
   }
   
   
   }**/


  // PulverLadung Knöpfe
  // Linke Seite
  if (getMouseX() < -10 + 1 && getMouseY() > -1 - 1 && getMouseX() > -10 && getMouseY() < -1) { //  Rot färben, wenn Maus auf Button kommt
    fill(255, 0, 0);  // rot
    if (mousePressed && (mouseButton == LEFT)) 
    {  
      if(pulverladungL + 0.2 <= pulverladungMaximum){
        pulverladungL = pulverladungL + 0.2;
      }
    }
  } else {
    fill(0, 255, 0);
  }

  rect(calcCoordX(-10), calcCoordY(-1), 1 * M, 1 * M);     // Links Plus Grün
  fill(0, 0, 0); 
  triangle(calcCoordX(-9.9),calcCoordY(-1.9),calcCoordX(-9.1),calcCoordY(-1.9),calcCoordX(-9.5),calcCoordY(-1.1));
  
  if (getMouseX() < -10 + 1 && getMouseY() > -2.2 - 1 && getMouseX() > -10 && getMouseY() < -2.2) { //  Rot färben, wenn Maus auf Button kommt
    fill(255, 0, 0);  // rot
    if (mousePressed && (mouseButton == LEFT)) 
    {  
      if(pulverladungL - 0.2 >= pulverladungMinimum){
        pulverladungL = pulverladungL - 0.2;
      }
    }
  } else {
    fill(0, 255, 0);
  }

  rect(calcCoordX(-10), calcCoordY(-2.2), 1 * M, 1 * M);     // Links Minus Grün
  fill(0, 0, 0); 
  triangle(calcCoordX(-9.9),calcCoordY(-2.3),calcCoordX(-9.1),calcCoordY(-2.3),calcCoordX(-9.5),calcCoordY(-3.1));
  // Pulverladung Anzeige
  fill(255, 255, 255); // weißer Hintergrund
  triangle(calcCoordX(-8.5),calcCoordY(-3),calcCoordX(-3.5),calcCoordY(-3),calcCoordX(-3.5),calcCoordY(-1));
  fill(0, 0, 0); // schwarze Füllung
  float pulverStandL = pulverladungL / (pulverladungMaximum - pulverladungMinimum);
  triangle(calcCoordX(-8.5),calcCoordY(-3),calcCoordX(-8.5 + pulverStandL * 5),calcCoordY(-3),calcCoordX(-8.5 + pulverStandL * 5),calcCoordY(-3 + 2 * pulverStandL));
  
  // Rechte Seite
  if (getMouseX() < 9 + 1 && getMouseY() > -1 - 1 && getMouseX() > 9 && getMouseY() < -1) { //  Rot färben, wenn Maus auf Button kommt
    fill(255, 0, 0);  // rot
    if (mousePressed && (mouseButton == LEFT)) 
    {  
      if(pulverladungR + 0.2 <= pulverladungMaximum){
        pulverladungR = pulverladungR + 0.2;
      }
    }
  } else {
    fill(255, 128, 0);
  }

  rect(calcCoordX(9), calcCoordY(-1), 1 * M, 1 * M);     // Rechts Plus Orange
  fill(0, 0, 0); 
  triangle(calcCoordX(9.9),calcCoordY(-1.9),calcCoordX(9.1),calcCoordY(-1.9),calcCoordX(9.5),calcCoordY(-1.1));
  
  if (getMouseX() < 9 + 1 && getMouseY() > -2.2 - 1 && getMouseX() > 9 && getMouseY() < -2.2) { //  Rot färben, wenn Maus auf Button kommt
    fill(255, 0, 0);  // rot
    if (mousePressed && (mouseButton == LEFT)) 
    {  
      if(pulverladungR - 0.2 >= pulverladungMinimum){
        pulverladungR = pulverladungR - 0.2;
      }
    }
  } else {
    fill(255, 128, 0);
  }

  rect(calcCoordX(9), calcCoordY(-2.2), 1 * M, 1 * M);     // Rechts Minus Orange
  fill(0, 0, 0); 
  triangle(calcCoordX(9.9),calcCoordY(-2.3),calcCoordX(9.1),calcCoordY(-2.3),calcCoordX(9.5),calcCoordY(-3.1));
  // Pulverladung Anzeige
  fill(255, 255, 255); // weißer Hintergrund
  triangle(calcCoordX(8.5),calcCoordY(-3),calcCoordX(3.5),calcCoordY(-3),calcCoordX(3.5),calcCoordY(-1));
  fill(0, 0, 0); // schwarze Füllung
  float pulverStandR = pulverladungR / (pulverladungMaximum - pulverladungMinimum);
  triangle(calcCoordX(8.5),calcCoordY(-3),calcCoordX(8.5 - pulverStandR * 5),calcCoordY(-3),calcCoordX(8.5 - pulverStandR * 5),calcCoordY(-3 + 2 * pulverStandR));
  

  text(countLeft, calcCoordX(-15.5), calcCoordY(11));   // Text Oben Links


  fill(255, 128, 0);
  rect(calcCoordX(10.5), calcCoordY(12.5), w, h, r);    // Rechts Oben Orange
  fill(0, 0, 0);
  textSize(20);
  // Mouse count für rechten Score
  /**if(countRight == 0) {
   buttonRight = "SCORES";
   }
   else {
   buttonRight = "" + countRight;
   }**/
  text(countRight, calcCoordX(11.5), calcCoordY(11));   // Text Oben Rechts

  if (getMouseX() < -16.5 + w / M && getMouseY() > -1 - h / M && getMouseX() > -16.5 && getMouseY() < -1) { //  Rot färben wenn es über Fire kommt, wenn Maus auf Button kommt
    fill(255, 0, 0);  // rot
    if (mousePressed && (mouseButton == LEFT)) 
    {  // count by mouse pressed
      schwarzeKugel.fireBlackBeaL();
      clickedLeft = true;
    }
  } else {
    fill(0, 255, 0);
  }

  rect(calcCoordX(-16.5), calcCoordY(-1), w, h, r);     // Links Unten Grün
  fill(0, 0, 0);
  textSize(20);
  text("FIRE", calcCoordX(-14.5), calcCoordY(-2.5));     // Text Unten Links


  if (getMouseX() < 10.5 + w / M && getMouseY() > -1 - h / M && getMouseX() > 10.5 && getMouseY() < -1) {    // Rot färben wenn es über Fire kommt, wenn Maus auf Button kommt
    fill(255, 0, 0);   // rot

    if (mousePressed && (mouseButton == LEFT)) 
    { // count by mouse pressed-> Score-counter
      schwarzeKugel.fireBlackBeaR();
      clickedLeft = false;
    }
  } else {
    fill(255, 128, 0);
  }



  rect(calcCoordX(10.5), calcCoordY(-1), w, h, r);    // Rechts Unten Orange
  fill(0, 0, 0);
  textSize(20);
  text("FIRE", calcCoordX(12.5), calcCoordY(-2.5));   // Text Unten Rechts

  fill(0, 0, 0);
  rect(calcCoordX(-0.5 * width / M), calcCoordY(0), 800, balkenVertikal * M);      // Schwarzer Balken

  blaueKugel.display();
  
  //fill(51, 153, 255);
  //ellipse(calcCoordX(blueBeaX), calcCoordY(blueBeaY), 60, 60);    // Blaue Kugel

  //fill(0, 0, 0);
  //ellipse(calcCoordX(blackBeaX), calcCoordY(blackBeaY), 30, 30);   // Schwarzer Kreis
  schwarzeKugel.colli();
  schwarzeKugel.display();

  fill(51, 102, 0);
  rect(calcCoordX(khakiLx), calcCoordY(khakiLy), khakiWidth, khakiHeight);   // Khaki Balken Links

  fill(51, 102, 0);
  rect(calcCoordX(khakiRx), calcCoordY(khakiRy), khakiWidth, khakiHeight);    // Khaki Balken Rechts

  kanoneL.display();
  /*pushMatrix();
   fill(0, 0, 0);   // Kanone Links
   translate(calcCoordX(-16.5 + kanoneLx), calcCoordY(0.5));
   rotate(radians(angleL));
   rect(-20, -10, 40, 100);
   fill(255, 255, 255);
   ellipse(0, 0, 20, 20);    // Weisser Kreis Links In Der Kanone
   popMatrix();*/

  kanoneR.display();
  /*pushMatrix();
   fill(0, 0, 0);         // Kanone Rechts
   translate(calcCoordX(16.5 + kanoneRx), calcCoordY(0.25));
   rotate(radians(angleR));
   rect(-20, -10, 40, 100);
   fill(255, 255, 255);
   ellipse(0, 0, 20, 20);    // Weisser Kreis Rechts In Der Kanone
   popMatrix();*/


  popMatrix();

  keyLeftRight();
  
  // Wind anzeigen
  fill(0,0,0);
  triangle(calcCoordX(0), calcCoordY(11), calcCoordX(wind), calcCoordY(10.5), calcCoordX(0), calcCoordY(10));
  
}

// Methoden zur Berechnung des Koord.syst
float calcCoordX(float xk) {
  float xi = xk * M + xi0;
  return xi;
}

float calcCoordY(float yk) {
  float yi = -yk * M + yi0;
  return yi;
}

// Methode-> für die Kanone (Drehung), Links & Rechts
void keyLeftRight() { 
  if (keyPressed) {
    if (key == 'a') {     // Linke Kanone drehen
      angleL--;
    } else if (key == 'd') {
      angleL++;
    }
    // max und min für die Rotation
    if (angleL > maxRotL)   
      angleL = maxRotL;
    if (angleL < minRotL)
      angleL = minRotL;

    if (key == CODED) {
      if (keyCode ==  LEFT) {   // Rechte Kanone drehen
        angleR--;
      } else if (keyCode == RIGHT) {
        angleR++;
      }
      // min und max für die Rotation
      if (angleR > maxRotR)
        angleR = maxRotR;
      if (angleR < minRotR)
        angleR = minRotR;
    }

    kanoneL.setAngle(angleL);
    kanoneR.setAngle(angleR);
  }
}

// Mouse Koord. bei x, M für Maßstabberechnung
float getMouseX() {
  float mX = (mouseX - xi0) / M;
  return mX;
}

// Mouse Koord. bei y
float getMouseY() {
  float mY = (yi0 - mouseY) / M;
  return mY;
}
// Mouse Interaction
void mousePressed() {
  if (mousePressed && (mouseButton == LEFT))
  {
  }
}

float diff(float x1, float y1, float x2, float y2) {  // Differenz Black&Blue berechnen
  float diffX = x1 - x2;
  float diffY = y1 - y2;
  return (sqrt(diffX * diffX + diffY * diffY));  // Hatte vorher sqrt vergessen!
}

// Klasse für die 3. Übung, da es einfacher ist (Tipp von Artur Maurer) 
class BlackBea {    // Schwarze Kugel

  // 3. Übung-> Zeitachse
  int timeScale = 1;
  float t = 0;
  float g = 9.81f;    // Gravitation
  float reibung = 0.7; // Reibungskoeffizient

  float xt = 0;
  float yt = 0;
  float vx = 0;
  float vy = 0;
  float pulverladung = 15;

  float blackBeaX = 10;   // x Position von schw. Kugel
  float blackBeaY = 6.5;  // y Position von schw. Kugel
  float x0 = blackBeaX;  
  float y0 = blackBeaY;

  float canX = -15.5;  // x Position von der Kanone
  float canY = 0.5;    // y Position von der Kanone

  float blackBeaRadius = 30 / M;   // Radius von schw. Kanone

  float vx0 = 0;
  float vy0 = 0;

  boolean kollidiert = false;

  float blackBeaGewicht = 5; // Gewicht in kg



  BlackBea(float x, float y, float radius) {    // Konstruktur
    blackBeaX = x;
    blackBeaY = y;
    x0 = blackBeaX;
    y0 = blackBeaY;
    blackBeaRadius = radius;
  }


  void display() {

    t += dt / timeScale;
    moveBlackBea();
    //colli();



    fill(255, 0, 0);   // Jetzt rot (Kanone)
    ellipse(calcCoordX(blackBeaX), calcCoordY(blackBeaY), blackBeaRadius, blackBeaRadius);
  }

  void moveBlackBea() {      // Kanone bewegen, Formeln von der Übung
    colli();
    // Reibung
    if(blackBeaY <= balkenVertikal && (abs(vx)) >= 0.05){
      if(vx > 0){
        vx = vx - g * reibung * dt;
      } else {
        vx = vx + g * reibung * dt;
      }
    }
    
    // 6. Übung, Gleichung verändert
    float blackBeaV = sqrt(vx * vx + vy * vy);

    if (blackBeaY > balkenVertikal) {   // Stopt am schw. Balken
    // 6. Übung, Gleichung verändert
      vy = vy - (vy * blackBeaV * luftKonstante + g) * dt;
      blackBeaY = blackBeaY + vy * dt;
      // 7. Übung, Wind
      vx = vx - (vx - wind) * blackBeaV * luftKonstante * dt;
    } else {
      vx = vx - vx * blackBeaV * luftKonstante * dt;
    }
     
    blackBeaX = blackBeaX + vx * dt;

    float ente = (blackBeaRadius / 2 + blueBeaRadius / 2 ) / M;
    float katze = diff(blackBeaX, blackBeaY, blaueKugel.blueBeaX, blaueKugel.blueBeaY);
    if ((katze  <= ente)) {
      colliBlackbeaBlueBea();
      if (clickedLeft) {
        countLeft++; 
        //println(blackBeaX + " buh " + blackBeaY);
      } else {
        countRight++;
      }
    }
    
    // Wind neu berechnen, wenn blackBea anhält
    if(abs(schwarzeKugel.vx) < 0.05 && windChange && blackBeaY <= balkenVertikal){
      wind = random(2 * windGrenze) - windGrenze;
      windChange = false;
    }

	if(abs(schwarzeKugel.vx) < 0.05 && blackBeaY <= balkenVertikal){
      blackBeaX = weg;
      blackBeaY = weg;
    }
  }



  void fireBlackBeaL() {  // Feuert die rote Kugel aus der linken Kanone


    canX = cos(radians(angleL + 90)) * 100 / M;   
    canY = -sin(radians(angleL + 90)) * 100 / M;

    float newBallPosX = -16.5 + canX;
    float newBallPosY = 0.5 + canY;

    schwarzeKugel = new BlackBea(newBallPosX, newBallPosY, blackBeaRadius);
    float speedX = cos(radians(angleL + 90));
    float speedY = -sin(radians(angleL + 90));
    schwarzeKugel.setSpeed(speedX * pulverladungL, speedY * pulverladungL);

    // Rückstoß
    float r = (blackBeaGewicht /  kanoneGewicht) * pulverladungL * sqrt(kanoneGewicht/(kanoneGewicht + blackBeaGewicht));
    kanoneLvX = cos(radians(angleL)) * r;
    //println(kanoneLvX);
    
    kanoneL.t = 0;
    
    // Wind-Veränderung möglich machen
    windChange = true;
  }

  void fireBlackBeaR() {    // Feuert die rote Kugel aus der rechten Kanone
    canX = cos(radians(angleR + 90)) * 100 / M;
    canY = -sin(radians(angleR + 90)) * 100 / M;

    float newBallPosX = 16.5 + canX;   // neue Position von der Kugel, in Kanone
    float newBallPosY = 0.5 + canY;

    schwarzeKugel = new BlackBea(newBallPosX, newBallPosY, blackBeaRadius);
    float speedX = cos(radians(angleR + 90));  // Rotation, wie in CG damals
    float speedY = -sin(radians(angleR + 90));
    schwarzeKugel.setSpeed(speedX * pulverladungR, speedY * pulverladungR);

    // Rückstoß
    float r = (blackBeaGewicht /  kanoneGewicht) * pulverladungR * sqrt(kanoneGewicht/(kanoneGewicht + blackBeaGewicht));
    kanoneRvX = cos(radians(angleR)) * -r;
    //println(kanoneRvX);
    
    kanoneR.t = 0;
    
    // Wind-Veränderung möglich machen
    windChange = true;
  }


  void setSpeed(float setSpeedX, float setSpeedY) {   // Geschwindigkeit 
    vx = setSpeedX;
    vy = setSpeedY;
  }



  // Übung 4, Wandkollision
  void colli() {
    // Abstand rechts
    float khakiRDistanceX = abs(blackBeaX - (khakiRx + khakiWidth/M/2)); 
    float khakiRDistanceY = abs(blackBeaY - (khakiRy - khakiHeight/M/2));
    // Abstand links
    float khakiLDistanceX = abs(blackBeaX - (khakiLx + khakiWidth/M/2)); 
    float khakiLDistanceY = abs(blackBeaY - (khakiLy - khakiHeight/M/2));
    // Wenn blackBea zu nah an einer Wand ist
    boolean zuNahRechts = khakiRDistanceX <= khakiWidth/M/2 + blackBeaRadius/M/4 && khakiRDistanceY <= khakiHeight/M/2 + blackBeaRadius/M/4;
    boolean zuNahLinks = khakiLDistanceX <= khakiWidth/M/2 + blackBeaRadius/M/4 && khakiLDistanceY <= khakiHeight/M/2 + blackBeaRadius/M/4;
    if ( !kollidiert && (zuNahRechts || zuNahLinks)) {
      x0 = blackBeaX;
      y0 = blackBeaY;
      t = 0;
      vx = -vx;
      if((blackBeaX > khakiLx && blackBeaX < (khakiLx + khakiWidth/M/2)) ||
          (blackBeaX > khakiRx && blackBeaX < (khakiRx + khakiWidth/M/2))){
        vy = -vy;
      }
      //blackBeaX = x0 + vx * t;
      kollidiert = true;
    } else {
      kollidiert = false;
    }
  }
  
  // Übung 5, Elastischer Stoß nach Formeln auf der Website
  void colliBlackbeaBlueBea(){
    float blackBeaV = sqrt(vx * vx + vy * vy);
    float blueBeaV = sqrt(blaueKugel.vx * blaueKugel.vx + blaueKugel.vy * blaueKugel.vy);
    
    float sinAlpha = abs(blaueKugel.blueBeaY - blackBeaY) / (blackBeaRadius/M/2 + blaueKugel.blueBeaRadius/M/2);
    float cosAlpha = sqrt(1 - (sinAlpha * sinAlpha));
    
    // Geschwindigkeiten über Winkel zerlegen
    float blackBeaVz = blackBeaV * cosAlpha;
    float blackBeaVt = blackBeaV * sinAlpha;
    
    float blueBeaVz = blueBeaV * cosAlpha;
    float blueBeaVt = blueBeaV * sinAlpha;
    
    // Geschwindigkeiten nach dem Stoß berechnen
    float newBlackBeaVz = ((blackBeaGewicht - blaueKugel.blueBeaGewicht) * blackBeaVz + 2 * blaueKugel.blueBeaGewicht * blueBeaVz) / (blackBeaGewicht + blaueKugel.blueBeaGewicht);
    float newBlackBeaVt = blackBeaVt;
    
    float newBlueBeaVz = ((blaueKugel.blueBeaGewicht - blackBeaGewicht) * blueBeaVz + 2 * blackBeaGewicht * blackBeaVz) / (blackBeaGewicht + blaueKugel.blueBeaGewicht);
    float newBlueBeaVt = blueBeaVt;
    
    // in x und y aufteilen
    float newBlackBeaVx = newBlackBeaVt * sinAlpha + newBlackBeaVz * cosAlpha;
    float newBlackBeaVy = newBlackBeaVt * cosAlpha - newBlackBeaVz * sinAlpha;
    
    float newBlueBeaVx = newBlueBeaVt * sinAlpha + newBlueBeaVz * cosAlpha;
    float newBlueBeaVy = newBlueBeaVt * cosAlpha - newBlueBeaVz * sinAlpha;
    
    if(blaueKugel.blueBeaX - blackBeaX < 0){
      newBlueBeaVx = -newBlueBeaVx;
    }
    setSpeed(newBlackBeaVx, newBlackBeaVy);
    x0 = blackBeaX;
    y0 = blackBeaY;
    t = 0;
    
    blaueKugel.setSpeed(newBlueBeaVx,newBlueBeaVy);
    blaueKugel.x0 = blaueKugel.blueBeaX;
    blaueKugel.y0 = blaueKugel.blueBeaY;
    blaueKugel.t = 0;
  }
}

class BlueBea {    // Blaue Kugel

  // 3. Übung-> Zeitachse
  int timeScale = 1;
  float t = 0;
  float g = 9.81f;    // Gravitation
  float reibung = 0.7; // Reibungskoeffizient

  float vx = 0;
  float vy = 0;

  float blueBeaX = 10;   // x Position von blauer Kugel
  float blueBeaY = 6.5;  // y Position von blauer Kugel
  float x0 = blueBeaX;  
  float y0 = blueBeaY;

  float blueBeaRadius = 60 / M;   // Radius von blauer Kanone

  float vx0 = 0;
  float vy0 = 0;

  boolean kollidiert = false;

  float blueBeaGewicht = 15; // Gewicht in kg



  BlueBea(float x, float y, float radius) {    // Konstruktur
    blueBeaX = x;
    blueBeaY = y;
    x0 = blueBeaX;
    y0 = blueBeaY;
    blueBeaRadius = radius;
  }


  void display() {

    t += dt / timeScale;
    moveBlueBea();
    //colli();




    fill(51, 153, 255);
    ellipse(calcCoordX(blueBeaX), calcCoordY(blueBeaY), blueBeaRadius, blueBeaRadius);
  }

  void moveBlueBea() {      // Kugel bewegen, Formeln von der Übung
    colli();
    if((abs(vx)) >= 0.05){
      if(vx > 0){
        vx = vx - g * reibung * dt;
      } else {
        vx = vx + g * reibung * dt;
      }
    }
    blueBeaX = blueBeaX + vx * dt;

    
    if(abs(vx) < 0.05){
      vx = 0;
    }

  }


  void setSpeed(float setSpeedX, float setSpeedY) {   // Geschwindigkeit 
    vx = setSpeedX;
    vy = setSpeedY;
  }



  // Übung 5, Wandkollision mit blueBea
  void colli() {
    // Abstand rechts
    float khakiRDistanceX = abs(blueBeaX - (khakiRx + khakiWidth/M/2)); 
    float khakiRDistanceY = abs(blueBeaY - (khakiRy - khakiHeight/M/2));
    // Abstand links
    float khakiLDistanceX = abs(blueBeaX - (khakiLx + khakiWidth/M/2)); 
    float khakiLDistanceY = abs(blueBeaY - (khakiLy - khakiHeight/M/2));
    // Wenn blackBea zu nah an einer Wand ist
    boolean zuNahRechts = khakiRDistanceX <= khakiWidth/M/2 && khakiRDistanceY <= khakiHeight/M/2;
    boolean zuNahLinks = khakiLDistanceX <= khakiWidth/M/2 && khakiLDistanceY <= khakiHeight/M/2;
    if (zuNahRechts) {
      x0 = blueBeaX;
      y0 = blueBeaY;
      t = 0;
      vx = 0;
      
      // rechte Seite wird "zerstört" sobald khakiR getroffen wird
      khakiRx = weg;
      khakiRy = weg;
      kanoneR.kanoneX = weg;
      kanoneR.kanoneY = weg;
      
    } else if (zuNahLinks){
      x0 = blueBeaX;
      y0 = blueBeaY;
      t = 0;
      vx = 0;
      
      // linke Seite wird "zerstört" sobald khakiL getroffen wird
      khakiLx = weg;
      khakiLy = weg;
      kanoneL.kanoneX = weg;
      kanoneL.kanoneY = weg;
    }
  }
  
}

class Kanone {
  float t = 0;
  float kanoneX = 0;
  float kanoneY = 0;
  float angle = 0;

  Kanone(float x, float y, float angle) {
    kanoneX = x;
    kanoneY = y;
    setAngle(angle);
  }

  void display() {
    t += dt;
    pushMatrix();
    fill(0, 0, 0);   // Kanone Links
    translate(calcCoordX(kanoneX), calcCoordY(kanoneY));
    rotate(radians(angle));
    rect(-20, -10, 40, 100);
    fill(255, 255, 255);
    ellipse(0, 0, 20, 20);    // Weisser Kreis Links In Der Kanone
    popMatrix();
    kanonePosition();
  }


  void kanonePosition() {
    float reibungsschwelle = kanoneGewicht * g * t * t;
    if (abs(kanoneLvX) > reibungsschwelle) {
      kanoneLvX = kanoneLvX - (kanoneKoeffizent * g * t)/2;
      kanoneLx = kanoneLvX * t;
    } else {
      kanoneLvX = 0;
      kanoneLx = kanoneRollEnde;
    }
  }

  void setAngle(float newAngle) {
    angle = newAngle;
  }
}