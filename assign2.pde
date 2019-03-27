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

int soldierX, soldierY, soldierSpeedX;
int soldierLocationX = floor(random(7)+1);
int soldierLocationY = floor(random(4)+1);                                                //about soldier Location
boolean soldierCollision=false;                                                           //soldier Collision switch

int cabbageX, cabbageY;
int cabbageLocationX = floor(random(7)+1);
int cabbageLocationY = floor(random(4)+1);                                                //about cabbage Location
boolean drawCabbage=true;                                                                 //cabbage Collision switch

int groundhogX, groundhogY;                                                               //about groundhog Location
boolean drawgroundhogIdle=true, drawgroundhogDown, drawgroundhogLeft, drawgroundhogRight; //drawgroundhog status switch
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
      image(soil,0,160,640,320);
      image(soldier, soldierX, soldierY);
      println(isActive,"-",groundhogX,"-",groundhogY);                                                      //println groundhog Location
      if(drawgroundhogIdle) image(groundhogIdle, groundhogX, groundhogY);                                   //roundhogIdle status
      if(drawgroundhogDown) {
        if(soldierCollision==true) {
           drawgroundhogDown=false;
           drawgroundhogIdle=true;
           soldierCollision=false;
           groundhogX = 320;
           groundhogY = 80;
           isActive=false;
        }
        else {
          if((frameCount-nowframeCount)<=15) {
            if ((frameCount-nowframeCount)%3==0)
              groundhogY+=16;
            image(groundhogDown, groundhogX, groundhogY);                                                   //groundhogDown status
          }
          else {
            isActive=false;
            drawgroundhogDown=false;
            drawgroundhogIdle=true;
          }
        }
      }
      if(drawgroundhogLeft) {
        if(soldierCollision==true) {
           drawgroundhogLeft=false;
           drawgroundhogIdle=true;
           soldierCollision=false;
           isActive=false;
           groundhogX = 320;
           groundhogY = 80;
        }
        else {
          if((frameCount-nowframeCount)<=15) {
            if ((frameCount-nowframeCount)%3==0)
              groundhogX-=16;
            image(groundhogLeft, groundhogX, groundhogY);                                                  //groundhogLeft status
          }
          else {
            isActive=false;
            drawgroundhogLeft=false;
            drawgroundhogIdle=true;
          }
        }
      }
      if(drawgroundhogRight) {
        if(soldierCollision==true) {
           drawgroundhogRight=false;
           drawgroundhogIdle=true;
           soldierCollision=false;
           groundhogX = 320;
           groundhogY = 80;
           isActive=false;
        }
        else {
          if((frameCount-nowframeCount)<=15) {
            if ((frameCount-nowframeCount)%3==0)
              groundhogX+=16;
            image(groundhogRight, groundhogX, groundhogY);                                                //groundhogRight status
          }
          else {
            isActive=false;
            drawgroundhogRight=false;
            drawgroundhogIdle=true;
          }
        }
      }
      if(drawCabbage) image(cabbage, cabbageX, cabbageY);                                                 //cabbage status
      for(i=0; i<HP; i++)
        image(life,10+60*i,10,50,51);                                                                     //life status
      
      soldierX+=soldierSpeedX;                                                                            //soldier move
      soldierX %= 640;                                                                                    //soldier move cycle

      if(downPressed && !isActive){                                                                       //groundhog moving frameCount image condition
        isActive=true;
        drawgroundhogIdle=false;
        drawgroundhogDown=true;
        if(groundhogY >= height-80) {
          groundhogY=height-80;
          isActive=false;
        }
        else {
          drawgroundhogIdle=false;
          drawgroundhogDown=true;
          nowframeCount=frameCount;
        }
      }
      if(leftPressed && !isActive){
        isActive=true;
        drawgroundhogIdle=false;
        drawgroundhogLeft=true;
        if(groundhogX <= 0) {
          groundhogX=0;
          isActive=false;
        }
        else {
          drawgroundhogIdle=false;
          drawgroundhogLeft=true;
          nowframeCount=frameCount;
        }
      }
      if(rightPressed && !isActive){
        isActive=true;
        drawgroundhogIdle=false;
        drawgroundhogRight=true;
        if(groundhogX >= width-80) {
          groundhogX = width - 80;
          isActive=false;
        }
        else {
          drawgroundhogIdle=false;
          drawgroundhogRight=true;
          nowframeCount=frameCount;
        }           
      }
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
        drawgroundhogIdle=true;
        drawgroundhogLeft=false;
        drawgroundhogRight=false;
        drawgroundhogDown=false;
        isActive=false;
        groundhogX = 320;
        groundhogY = 80;
        HP--;                                                                                                            //cut life
      }
      if(HP<1) gameState=GAME_OVER;                                                                                      //GAME_OVER condition
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

void keyPressed(){                                                                                                       //path control
  switch(keyCode){
    case DOWN:
    downPressed = true;
    break;
    case RIGHT:
    rightPressed = true;
    break;
    case LEFT:
    leftPressed = true;
    break;
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
