// global variables
float frogX, frogY, frogW, frogH, frogInitX, frogInitY;
float leftCar1X, leftCar1Y, leftCar1W, leftCar1H;
float leftCar2X, leftCar2Y, leftCar2W, leftCar2H;
float rightCar1X, rightCar1Y, rightCar1W, rightCar1H;
float rightCar2X, rightCar2Y, rightCar2W, rightCar2H;
float pondY;

float speed;

boolean alive=true;
int life;
final int GAME_START = 1;
final int GAME_WIN = 2;
final int GAME_LOSE = 3;
final int GAME_RUN = 4;
final int FROG_DIE = 5;
int gameState;
int interval=0;

// Sprites
PImage imgFrog, imgDeadFrog;
PImage imgLeftCar1, imgLeftCar2;
PImage imgRightCar1, imgRightCar2;
PImage imgWinFrog, imgLoseFrog;

void setup(){
  size(640,480);
  textFont(createFont("font/Square_One.ttf", 20));
  gameState = GAME_START;
  
  speed = 5;
  
  // the Y position of Pond
  pondY = 32;
  
  // initial position of frog
  frogInitX = 304;
  frogInitY = 448;
  
  frogW = 32;
  frogH = 32;
  
  leftCar1W=leftCar2W=rightCar1W=rightCar2W = 32;
  leftCar1H=leftCar2H=rightCar1H=rightCar2H = 32;
  leftCar1X = leftCar2X = 0;
  rightCar1X = rightCar2X =640;
  
  leftCar1Y = 128;//leftCar1H;
  rightCar1Y =192;
  leftCar2Y  =256;
  rightCar2Y =320;
  
  imgFrog = loadImage("data/frog.png");
  imgDeadFrog = loadImage("data/deadFrog.png");
  imgLeftCar1 = loadImage("data/LCar1.png");
  imgLeftCar2 = loadImage("data/LCar2.png");
  imgRightCar1 = loadImage("data/RCar1.png");
  imgRightCar2 = loadImage("data/RCar2.png");
  imgWinFrog = loadImage("data/win.png");
  imgLoseFrog = loadImage("data/lose.png");
}

void draw(){
  switch (gameState){
    case GAME_START:
        background(10,110,16);
        text("Press Enter", width/3, height/2);    
        break;
    case FROG_DIE:
        if(millis()-interval>=500){
        life--;
        frogX=frogInitX;
        frogY=frogInitY;
        gameState=GAME_RUN;
        }
        break;
    case GAME_RUN:
        background(10,110,16);
        gameState=(life<=0?GAME_LOSE:gameState);
        gameState=(frogY<=32.0?GAME_WIN:gameState);
        fill(4,13,78);
        rect(0,32,640,32);
        
        for(int i=0;i<life;i++){
            image(imgFrog,64+i*48 ,32);
         }
  
        image(imgFrog, frogX, frogY);

         // car1 move
         leftCar1X += speed;
         if (leftCar1X > width){
             leftCar1X = 0;
         }
         image(imgLeftCar1, leftCar1X, leftCar1Y);
  
         leftCar2X +=speed;
         if (leftCar2X > width){
             leftCar2X = 0;
         }
         image(imgLeftCar2, leftCar2X, leftCar2Y);
  
         rightCar1X -=speed;
         if (rightCar1X < 0){
             rightCar1X = 640;
         }
         image(imgRightCar1, rightCar1X, rightCar1Y);

         rightCar2X -=speed;
         if (rightCar2X < 0){
             rightCar2X = 640;
         }
         image(imgRightCar2, rightCar2X, rightCar2Y);
  
         // car1 hitTest
         float frogCX = frogX+frogW/2;
         float frogCY = frogY+frogH/2;
         if (frogCX > leftCar1X && frogCX < leftCar1X+leftCar1W && 
             frogCY > leftCar1Y && frogCY < leftCar1Y+leftCar1H){
             image(imgDeadFrog, frogX, frogY);
             interval=millis();
             gameState = FROG_DIE;
         } 
         if (frogCX > leftCar2X && frogCX < leftCar2X+leftCar2W && 
             frogCY > leftCar2Y && frogCY < leftCar2Y+leftCar2H){
             image(imgDeadFrog, frogX, frogY);
             interval=millis();
             gameState = FROG_DIE;
         }
         if (frogCX > rightCar1X && frogCX < rightCar1X+rightCar1W && 
             frogCY > rightCar1Y && frogCY < rightCar1Y+rightCar1H){
             image(imgDeadFrog, frogX, frogY);
             interval=millis();
             gameState = FROG_DIE;
         }
         if (frogCX > rightCar2X && frogCX < rightCar2X+rightCar2W && 
             frogCY > rightCar2Y && frogCY < rightCar2Y+rightCar2H){
             image(imgDeadFrog, frogX, frogY);
             interval=millis();
             gameState = FROG_DIE;
         }        
        break;
    case GAME_WIN:
        background(0);
        image(imgWinFrog,207,164);
        fill(255);
        text("You Win !!",240,height/4);
        break;
    case GAME_LOSE:
        background(0);
        image(imgLoseFrog,189,160);
        fill(255);
        text("You Lose",240,height/4);    
        break;
  }
}
void keyPressed() {
    if (key == CODED && gameState == GAME_RUN) {
      switch(keyCode) {
      case UP:
        frogY -= 32;
        break;
      case DOWN:
        frogY += 32;
        break;
      case LEFT:
        frogX -= 32;
        break;
      case RIGHT:
        frogX += 32;
        break;  
      }
    }
    if(key==ENTER && gameState != GAME_RUN){
      gameState = GAME_RUN;
      life=3;
      frogX = 304;
      frogY = 448;
    }
}
