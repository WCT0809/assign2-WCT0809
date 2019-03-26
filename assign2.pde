PImage bg, cabbage, gameover, groundhog, groundhogDown,groundhogIdle,groundhogLeft,groundhogRight,life1,life2,life3,robot,soil,soldier,restartHovered,restartNormal,startHovered,startNormal,title;
final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_OVER = 2;

int gameState = GAME_START;

final int BUTTON_TOP = 360;
final int BUTTON_BOTTOM = 420;
final int BUTTON_LEFT = 248;
final int BUTTON_RIGHT = 392;

boolean upPressed, downPressed, rightPressed, leftPressed;

int bgW;
int bgH;

int sunX;
int sunY;
int robotX;
int robotY;
int soldierX;
int soldierY;
int cabbageX;
int cabbageY;
//about item X,y

float soldierSpeedX;        //about speed
int soldierLocationY = floor(random(4)+1);     //about location y by 1~4

int cabbageLocationX = floor(random(8)+1);
int cabbageLocationY = floor(random(4)+1);     //about location x,y by 4x8


float groundhogX, groundhogY;
float groundhogSpeed = 80;
float groundhogWidth = 80;
void setup() {
	size(640, 480, P2D);
  bg = loadImage("img/bg.jpg");
  groundhog = loadImage("img/groundhog.png");
  life1 = loadImage("img/life.png");
  life2 = loadImage("img/life.png");
  life3 = loadImage("img/life.png");
  soil = loadImage("img/soil.png");
  soldier = loadImage("img/soldier.png");
  cabbage = loadImage("img/cabbage.png");
  gameover = loadImage("img/gameover.jpg");
  groundhog = loadImage("img/groundhog.png");
  groundhogDown = loadImage("img/groundhogDown.png");
  groundhogIdle = loadImage("img/groundhogIdle.png");
  groundhogLeft = loadImage("img/groundhogLeft.png");
  groundhogRight = loadImage("img/groundhogRight.png");
  restartHovered = loadImage("img/restartHovered.png");
  restartNormal = loadImage("img/restartNormal.png");
  startHovered = loadImage("img/startHovered.png");
  startNormal = loadImage("img/startNormal.png");
  title = loadImage("img/title.jpg");   //load all img
  
  groundhogX = width / 2 - groundhogWidth / 2;
  groundhogY = 80;
  
  bgW = 640;
  bgH = 480;          //about size for bg
  sunX = 590;
  sunY= 50;           //about x,y for sun
  
  soldierX = -80;
  soldierY= 80 + soldierLocationY * 80; //about real soldier x,y   4x8 to real loction  
  soldierSpeedX =2;
  cabbageX = cabbageLocationX * 80;
  cabbageY= 80 + cabbageLocationY * 80; //about real soldier x,y   4x8 to real loction
	
// Enter Your Setup Code Here
}

void draw() {
	  switch(gameState){    // Switch Game State
    case GAME_START:      // Game Start
     image(title, 0, 0);
      if(mouseX > BUTTON_LEFT && mouseX < BUTTON_RIGHT
      && mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM){
        image(startHovered, BUTTON_LEFT, BUTTON_TOP);
        if(mousePressed){
          gameState = GAME_RUN;
        }
      }else{
        image(startNormal, BUTTON_LEFT, BUTTON_TOP);
      }
    break;
    
    case GAME_RUN:  // Game Run
    
      image(bg, 0, 0);
      image(groundhog, groundhogX, groundhogY);
      image(soil,0,160,640,320);
      image(life1,10,10,50,51);
      image(life2,80,10,50,51);
      colorMode(RGB);
      fill(124,204,25);
      noStroke();
      rect(0,145,640,15);
      colorMode(RGB);
      fill(253,184,19);
      stroke(255,255,0);
      strokeWeight(5);
      ellipse(sunX,sunY,120,120);             //draw sun x,y size
      image(soldier,soldierX,soldierY); 
      image(cabbage,cabbageX,cabbageY);      //img all x,y
      soldierX += soldierSpeedX;           
      soldierX %= 720;                        //soldier move loction
      
      
      image(groundhog,groundhogX,groundhogY); //draw gh
      
      if(upPressed){
        groundhogY -= groundhogSpeed;
        if(groundhogY < 0) groundhogY = 0;
      }
      if(downPressed){
        groundhogY += groundhogSpeed;
        if(groundhogY + groundhogWidth > height) groundhogY = height - groundhogWidth;
      }
      if(leftPressed){
        groundhogX -= groundhogSpeed;
        if(groundhogX < 0) groundhogX = 0;
      }
      if(rightPressed){
        groundhogX += groundhogSpeed;
        if(groundhogX + groundhogWidth > width) groundhogX=width - groundhogWidth;
      }		
		// Game Lose
}
}
