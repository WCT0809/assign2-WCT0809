PImage bg, cabbage, life,soil, soldier;                                        
PImage groundhogDown, groundhogIdle, groundhogLeft, groundhogRight;
PImage startHovered, startNormal, restartHovered, restartNormal, title, gameover;          //all image

final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_OVER = 2;
final int GAME_WIN = 3;                                                                   //all game status
 
int gameState = GAME_START;                                                               //First game status

final int BUTTON_TOP = 360;
final int BUTTON_BOTTOM = 420;
final int BUTTON_LEFT = 248;
final int BUTTON_RIGHT = 392;                                                             //BUTTON status

int sunX;
int sunY;                                                                                 //about sun Location
int soldierX, soldierY, soldierSpeedX;
int soldierLocationX = floor(random(8));
int soldierLocationY = floor(random(1,5));                                                //about soldier Location
boolean soldierCollision=false;                                                           //soldier Collision switch

int cabbageX, cabbageY;
int cabbageLocationX = floor(random(8));
int cabbageLocationY = floor(random(1,5));                                                //about cabbage Location
boolean drawCabbage=true;                                                                 //cabbage Collision switch

int groundhogX, groundhogY;//about groundhog Location
final int groundhog_IDLE = 0;
final int groundhog_LEFT = 1;
final int groundhog_RIGHT = 2;
final int groundhog_DOWN = 3;
int groundhogState = groundhog_IDLE;

int HP=2,i,nowframeCount;                                                                 //frameCount about groundhog*
boolean upPressed, downPressed, rightPressed, leftPressed, isActive=false;                //about groundhog control

void setup() {
	size(640, 480, P2D);
  frameRate(60);                                                                          //frameRate*

	// Enter Your Setup Code Here
  bg=loadImage("img/bg.jpg");
  cabbage=loadImage("img/cabbage.png");
  life=loadImage("img/life.png");
  soil=loadImage("img/soil.png");
  soldier=loadImage("img/soldier.png");

  groundhogDown=loadImage("img/groundhogDown.png");
  groundhogIdle=loadImage("img/groundhogIdle.png");
  groundhogLeft=loadImage("img/groundhogLeft.png");
  groundhogRight=loadImage("img/groundhogRight.png");
  
  startHovered=loadImage("img/startHovered.png");
  startNormal=loadImage("img/startNormal.png");
  restartHovered=loadImage("img/restartHovered.png");
  restartNormal=loadImage("img/restartNormal.png");  
  title=loadImage("img/title.jpg");
  gameover=loadImage("img/gameover.jpg");

  soldierX=soldierLocationX * 80;
  soldierY=80+soldierLocationY * 80;                                                    //soldier real Location
  soldierSpeedX = 3;                                                                    //soldier move
  cabbageX=cabbageLocationX * 80;                                                       //cabbage real Location
  cabbageY=80+cabbageLocationY * 80;                                                    //cabbage move
  groundhogX = 320;
  groundhogY = 80;                                                                      //groundhog First Location
  sunX = 590;
  sunY= 50;                                                                             //about x,y for sun
}

void draw() {
  // Switch Game State
  switch(gameState){
    case GAME_START:
      image(title,0,0,640,480);
      image(startNormal,BUTTON_LEFT,BUTTON_TOP);
      if(mouseX > BUTTON_LEFT && mouseX < BUTTON_RIGHT  && mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM){ 
        image(startHovered,BUTTON_LEFT,BUTTON_TOP);                                                         //BUTTON status
        if(mousePressed) gameState=GAME_RUN;                                                                //BUTTON Click gameState to GAME_RUN
     }
    break;
    case GAME_RUN:
      image(bg,0,0,640,480);
      colorMode(RGB);
      fill(124,204,25);
      noStroke();
      rect(0,145,640,15);
      colorMode(RGB);
      fill(253,184,19);
      stroke(255,255,0);
      strokeWeight(5);
      ellipse(sunX,sunY,120,120);             //draw sun x,y size
      image(soil,0,160,640,320);
      image(soldier, soldierX, soldierY);

      //println(isActive,"-",groundhogX,"-",groundhogY);      //println groundhog Location
      //println(nowframeCount);

      if (isActive==false) groundhogState=groundhog_IDLE;
      
      switch(groundhogState) {
        case groundhog_IDLE:
          image(groundhogIdle, groundhogX, groundhogY); 
        break;
        case groundhog_LEFT:
            if((frameCount-nowframeCount)<=15) {
              if ((frameCount-nowframeCount)%3==0)
                groundhogX-=16;
              image(groundhogLeft, groundhogX, groundhogY);                                                  //groundhogLeft status
            }
            else {
              isActive=false;
            }
        break;
        case groundhog_RIGHT:
            if((frameCount-nowframeCount)<=15) {
              if ((frameCount-nowframeCount)%3==0)
                groundhogX+=16;
              image(groundhogRight, groundhogX, groundhogY);                                                //groundhogRight status
            }
            else {
              isActive=false;
            }
        break;
        case groundhog_DOWN:
            if((frameCount-nowframeCount)<=15) {
              if ((frameCount-nowframeCount)%3==0)
                groundhogY+=16;
              image(groundhogDown, groundhogX, groundhogY);                                                   //groundhogDown status
            }
            else {
              isActive=false;
            }
        break;
      }
      
      if(drawCabbage) image(cabbage, cabbageX, cabbageY);                                                 //cabbage status
      
      for(i=0; i<HP; i++)
        image(life,10+60*i,10,50,51);                                                                     //life status
      
      soldierX+=soldierSpeedX;                                                                            //soldier move
      soldierX %= 640;                                                                                    //soldier move cycle

      //Cabbage collision detect
      if(drawCabbage) {                                                                                                 //Cabbage collision condition
        if(groundhogX<cabbageX+80 && groundhogX+80>cabbageX && groundhogY<cabbageY+80 && groundhogY+80>cabbageY) {
          drawCabbage=false;                                                                                            //Cabbage status
          HP++;                                                                                                         //add life
        }
      }
        
      //soldier collision detect
      if(groundhogX<soldierX+80 && groundhogX+80>soldierX && groundhogY<soldierY+80 && groundhogY+80>soldierY) {        //soldier collision condition
        soldierCollision=true;
        groundhogState = groundhog_IDLE;
        isActive=false;
        groundhogX = 320;
        groundhogY = 80;
        HP--;                                                                                                            //cut life
      }
      if(HP<1) gameState = GAME_OVER;                                                                                      //GAME_OVER condition
    break;
    case GAME_OVER:                                                                                                      //GAME_OVER status
      image(gameover, 0, 0);
      image(restartNormal,BUTTON_LEFT,BUTTON_TOP);
      if(mouseX > BUTTON_LEFT && mouseX < BUTTON_RIGHT  && mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM){
        image(restartHovered,BUTTON_LEFT,BUTTON_TOP);
        if(mousePressed) { HP=2; drawCabbage=true; gameState=GAME_RUN;}                                                  //GAME_RUN reset life
      }
    break;
  }
}

void keyPressed(){  //path control
    if (!isActive) {
      switch(keyCode){
        case DOWN:
        if (groundhogY < height-80) {
          isActive = true;
          groundhogState = groundhog_DOWN;
          nowframeCount=frameCount;
        }
        else groundhogState = groundhog_IDLE;
        break;
        case RIGHT:
        if (groundhogX < width-80) {
          isActive = true;
          groundhogState = groundhog_RIGHT;
          nowframeCount=frameCount;
        }
        else groundhogState = groundhog_IDLE;
        break;
        case LEFT:
        if (groundhogX > 0) {
          isActive = true;
          groundhogState = groundhog_LEFT;
          nowframeCount=frameCount;
        }
        else groundhogState = groundhog_IDLE;
        break;
      }
    }
}

void keyReleased(){
  switch(keyCode){
    case DOWN:
    downPressed = false;
    break;
    case RIGHT:
    rightPressed = false;
    break;
    case LEFT:
    leftPressed = false;
    break;
  }
}
