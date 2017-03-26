int rectX, rectY;      // Position of square button
int circleX, circleY;  // Position of circle button
int rectSize = 50;     // Diameter of rect
int circleSize = 50;   // Diameter of circle
int dotSize = rectSize-20;
int dotX, dotY;
int mode = 0;
int lastx = -1; //store last mouseX for drawing a line
int lasty = -1; //store last mouseY for drawing a line

//setup size of screen, position of circle, rectangle, and dot rectangle
void setup() {
  size(1000,1000);
  
  circleX = circleSize;
  circleY = circleSize;
  
  rectX = circleSize/2;
  rectY = circleSize*2;
  
  dotY = rectY*2-15;
  dotX = rectX +2;

  background(255, 255, 153);
}
//draw circle
void drawCircle() {
  if(!overAnyObjects()){
    ellipse(mouseX, mouseY, 50, 50);
    lastx = -1;
    lasty = -1;
  }
}

//draw square
void drawSquare() {
  if(!overAnyObjects()){
    rect(mouseX, mouseY, 50, 50);
    lastx = -1;
    lasty = -1;
  }
}
//draw a line 
void drawLine() {
  if (lastx > 0 && lasty > 0 && (!overAnyObjects())) {
    line(lastx, lasty, mouseX, mouseY);
  }
  lastx = mouseX;
  lasty = mouseY;
}

//Draw Menu Bar which shows rectangle, circle, dot line
void draw() {
  textSize(16);
  fill(50);
  text("Circle", 25, 20); 
  stroke(0);
  fill(255,255,255);
  ellipse(circleX, circleY, circleSize, circleSize);
  
  textSize(16);
  fill(50);
  text("Rectangle", 10, 95); 
  stroke(0);
  fill(255,255,255);
  rect(rectX, rectY, rectSize, rectSize);
  
  textSize(16);
  fill(50);
  text("Dot Line", rectX, rectY*2-25); 
  stroke(0);
  fill(255,255,255);
  rect(dotX, dotY, dotSize, dotSize);
  
}

//update the mode. 
//mode 0: Draw Line
//mode 1: Draw Rectangle
//mode 2: Draw Circle

Boolean update() {
  if ( overCircle(circleX, circleY, circleSize) ) {
    mode = 1;
    return true;
  } else if ( overRect(rectX, rectY, rectSize, rectSize) ) {
    mode = 2;
    return true;
  } else if (overRect(dotX, dotY, dotSize, dotSize)) {
    mode = 0;
    return true;
  }else{
    return false;
  }
}

//If mouse is over Circle, mode = 1. If mouse is over Rectangle, mode = 2. If mouse is over Dot Rectangle, mode = 0.
void mouseClicked() {
  if(!update()){ //If the mode changed, return true
    fill( random(255), random(255), random(255), random(255)); 
    
    //See the mode if it is 1, 2, or 0
    if (mode == 1) {
      drawCircle(); // Circle
    } else if (mode == 2) {
      drawSquare(); // Square
    } else if (mode == 0) {
      drawLine(); // Line
    }
  }
  
}

//If user click space, change background color to default
void keyPressed(KeyEvent e) {
  if (e.getKeyCode() == ' ') {
    background(255, 255, 153);
  }
}

//Check if the mouseX and mouse Y are on the rectangle. If Yes, return True, otherwise return False
boolean overRect(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}
//Check if the mouseX and mouse Y are on the Circle. If Yes, return True, otherwise return False
boolean overCircle(int x, int y, int diameter) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
    return true;
  } else {
    return false;
  }
}
//Check if the mouseX and mouse Y are on objects (circle, dot, and rectangle).
boolean overAnyObjects(){
 return (overRect(rectX, rectY, rectSize,rectSize) && (overCircle(circleX, circleY, circleSize)) && (overRect(dotX, dotY, dotSize, dotSize)));
}