import pygame as pg
import sys,time,random

pg.init()
SCREEN_WIDTH=800
SCREEN_HEIGHT=800
win= pg.display.set_mode((SCREEN_WIDTH ,SCREEN_HEIGHT))
bg_img = pg.image.load('bg_image.png')
bg_img = pg.transform.scale(bg_img,(SCREEN_WIDTH ,SCREEN_HEIGHT))
paddle= pg.Rect(340,770,120,15)
clock = pg.time.Clock()

font= pg.font.Font('Simple tfb.ttf', 30)
scoreText=font.render('SCORE:',True,(0,0,0),(137,207,240))
scoreTextRect=scoreText.get_rect()
scoreTextRect.x=12
scoreTextRect.y=12

font2= pg.font.Font('Simple tfb.ttf', 50)
pygameText=font2.render('GAME STARTED',True,(253,218,13),(0,0,0))
pygameTextRect=scoreText.get_rect()
pygameTextRect.center=(SCREEN_WIDTH//3,SCREEN_HEIGHT//2)

font3= pg.font.Font('Simple tfb.ttf', 60)
gameoverText=font3.render('GAME OVER',True,(255,0,0),(204,255,255))
gameoverTextRect=scoreText.get_rect()
gameoverTextRect.center=(SCREEN_WIDTH//2.5,SCREEN_HEIGHT//2)

GAME_RUNNING= True
i=0
BOX_SPEED=10
TARGET_FPS=60
MAX_BALL_SPEED=10
MIN_BALL_SPEED=5
BALL_X_SPEED=0
BALL_Y_SPEED=0
GAME_STARTED=False
BALL_X= paddle.x+60
BALL_Y= paddle.y-13
GAMESTARTED = False
SCORE=0


old= time.time()
def updatescore():
     global SCORE,scoreText
     SCORE+=1
     scoreText=font.render(f'Score: {SCORE}',True,(0,0,0),(0,204,255))
def checkcollision():
    global SCREEN_WIDTH,paddle,BALL_X,BALL_Y,BALL_X_SPEED,BALL_Y_SPEED,GAME_STARTED
    if paddle.x<0:
        paddle.x=0
    if paddle.x+120>SCREEN_WIDTH:
        paddle.x=SCREEN_WIDTH-120

    if BALL_X-13<=0 or BALL_X+13>=SCREEN_WIDTH:
     BALL_X_SPEED=-BALL_X_SPEED
    if BALL_Y-18<0:
        BALL_Y_SPEED=-BALL_Y_SPEED

# BALL HITTS THE PADDLE
    if BALL_Y+13>=paddle.y-5 and GAME_STARTED==True and BALL_X>paddle.x and BALL_X<paddle.x+120:
        BALL_Y-=15
        BALL_Y_SPEED=-BALL_Y_SPEED
        updatescore()
    elif BALL_Y>paddle.y:
        gameOver()
def gameOver():
   global GAME_RUNNING
   GAME_RUNNING=False
   global i
   i=0

while True:
    new = time.time()
    dt= new-old
    old=new
    for event in pg.event.get():
        if event.type==pg.QUIT:
            pg.quit()
            sys.exit()
        if event.type== pg.KEYDOWN:
            if event.key==pg.K_SPACE:
                GAME_STARTED=True
                BALL_Y-=10
                sign=random.randint(0,1)
                BALL_Y_SPEED=-random.randint(MIN_BALL_SPEED,MAX_BALL_SPEED)
                BALL_X_SPEED=random.randint(MIN_BALL_SPEED,MAX_BALL_SPEED)
                if sign==0:
                    BALL_X_SPEED= -BALL_X_SPEED

    if GAME_RUNNING==True:
        checkcollision() 
        key=pg.key.get_pressed()
        if key[pg.K_LEFT]:
            paddle.x-= BOX_SPEED*dt*TARGET_FPS
            if GAME_STARTED==False:
                BALL_X= paddle.x+60
        elif key[pg.K_RIGHT]:
            paddle.x+= BOX_SPEED*dt*TARGET_FPS
            if GAME_STARTED==False:
                  BALL_X=paddle.x+60

        win.fill("black")
        win.blit(bg_img,(0,0))
        win.fill((0,0,0))
        win.blit(bg_img,(i,0))
        win.blit(bg_img,(SCREEN_WIDTH+i,0))
        if (i==-SCREEN_WIDTH):
          win.blit(bg_img,(SCREEN_WIDTH+i,0))
          i=0
        i-=5
        pg.draw.rect(win,"white",paddle)
        if GAME_STARTED== False:
            win.blit(pygameText,pygameTextRect)
            pg.display.update()
            pg.draw.circle(win,"blue",(BALL_X, BALL_Y),13)
        else: 
            BALL_X+=BALL_X_SPEED*dt*TARGET_FPS
            BALL_Y+=BALL_Y_SPEED*dt*TARGET_FPS
            pg.draw.circle(win,"red",(BALL_X,BALL_Y),13)
    else:
        win.blit(gameoverText,gameoverTextRect)

    win.blit(scoreText,scoreTextRect)
    pg.display.update()
     
    clock.tick(60)
