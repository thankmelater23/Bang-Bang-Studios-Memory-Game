//
//  ViewController.m
//  Penn Game
//
//  Created by Andre on 1/27/13.
//  Copyright (c) 2013 HnG Studios. All rights reserved.
//

#import "ViewController.h"
#include <stdlib.h>

@interface ViewController ()

@end

@implementation ViewController
//Syntesize
@synthesize space0, space1, space2, space3, space4, space5, space6, space7, space8, space9,
space10, space11, space12, space13, space14, space15, space16, space17;

@synthesize picturePlace0, picturePlace1, picturePlace2, picturePlace3, picturePlace4;
/*********************************************/
//Methods
- (void)viewDidLoad{
    [super viewDidLoad];
    [self initilizeVars];
    [self loadResources];
    [self insertSpacesIntoArray];
    [self createRandomAssortment];
    [self hideBoxes];
    [self nextLevel];
    [self playBackGroundMusic];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) initilizeVars{
    //Set Vars
    levels = 0;
    boxStage = 0;
    
    //Set Objects
    boxesButtonsArray       = [[NSMutableArray alloc]init];
    boxesImagesArray        = [[NSMutableArray alloc]init];
    imageHolder             = [[UIImage alloc]init];
    gameOver                = NO;
    win                     = NO;
    playActionEnabled        = NO;
    roundOver               = YES;
    
}//Initializes Variables Created In ViewController

-(void) insertSpacesIntoArray{
    [boxesButtonsArray addObject:space0];
    [boxesButtonsArray addObject:space1];
    [boxesButtonsArray addObject:space2];
    [boxesButtonsArray addObject:space3];
    [boxesButtonsArray addObject:space4];
    [boxesButtonsArray addObject:space5];
    [boxesButtonsArray addObject:space6];
    [boxesButtonsArray addObject:space7];
    [boxesButtonsArray addObject:space8];
    [boxesButtonsArray addObject:space9];
    [boxesButtonsArray addObject:space10];
    [boxesButtonsArray addObject:space11];
    [boxesButtonsArray addObject:space12];
    [boxesButtonsArray addObject:space13];
    [boxesButtonsArray addObject:space14];
    [boxesButtonsArray addObject:space15];
    [boxesButtonsArray addObject:space16];
    [boxesButtonsArray addObject:space17];
}//Put all the spaces(buttons) in an array of "spacesHolder"

-(void) loadResources{
    //Load Audio Sounds
    
    //Loads Click Sound
    NSString *clickPath = [[NSBundle mainBundle]pathForResource:@"correct" ofType:@"wav"];
    NSURL *clickPathurl = [NSURL fileURLWithPath:clickPath];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)clickPathurl, &sIDClick);
    
    //Load Game Over Sound
    NSString *gameOverPath = [[NSBundle mainBundle]pathForResource:@"buzzer" ofType:@"wav"];
    NSURL *gameOverPathurl = [NSURL fileURLWithPath:gameOverPath];
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)gameOverPathurl, &sIDGameOver);
    
    //Load New Level
    NSString *newLevelPath = [[NSBundle mainBundle]pathForResource:@"success" ofType:@"wav"];
    NSURL *newLevelPathurl = [NSURL fileURLWithPath:newLevelPath];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)newLevelPathurl, sIDNewLevel);
    
    //Load Camera
    NSString *cameraPath = [[NSBundle mainBundle]pathForResource:@"camera" ofType:@"wav"];
    NSURL *cameraPathurl = [NSURL fileURLWithPath:cameraPath];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)cameraPathurl, &sIDCamera);
    
    //Load Camera
    NSString *winPath = [[NSBundle mainBundle]pathForResource:@"win" ofType:@"wav"];
    NSURL *winPathurl = [NSURL fileURLWithPath:winPath];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)winPathurl, &sIDWin);
}
/*******************************************************************************/
//GamePlay

-(void) createRandomAssortment{
    int pictureRandomGeneratedNumber = 0;;
    int i = 0;
    NSUInteger maxCount = [boxesButtonsArray count];
    
    while (i != maxCount)
    {
        pictureRandomGeneratedNumber = arc4random() % 5;
        
        switch (pictureRandomGeneratedNumber)
        {
            case 0:
            {
                imageHolder = picturePlace0.currentBackgroundImage;
                break;
            }
            case 1:
            {
                imageHolder = picturePlace1.currentBackgroundImage;
                break;
            }
            case 2:
            {
                imageHolder = picturePlace2.currentBackgroundImage;
                break;
            }
            case 3:
            {
                imageHolder = picturePlace3.currentBackgroundImage;
                break;
            }
            case 4:
            {
                imageHolder = picturePlace4.currentBackgroundImage;
                break;
            }
        }
        //For debug mode when need to win
//        imageHolder = picturePlace0.currentBackgroundImage;
        [[boxesButtonsArray objectAtIndex:i] setBackgroundImage:imageHolder forState: UIControlStateNormal];//setImage:imageHolder forState:UIControlStateNormal];
        i++;
    }
    
    
    savedImage = [[boxesButtonsArray objectAtIndex:0] backgroundImageForState:UIControlStateNormal];//[[boxesButtonsArray objectAtIndex:0]backgroundImage];// \\[[boxesButtonsArray objectAtIndex:0]currentImage];
    
    if (savedImage == NULL)
    {
        
    }
    
}//Assigns an image to each space at the beggining of new game play

-(IBAction) faceChooser:(id)sender{
    [self playBackGroundMusic];
    
    if (playActionEnabled == YES)
    {
        [self playClick];
        
        UIImage *tempSenderImage = [sender currentBackgroundImage];
        
        if ([savedImage isEqual:tempSenderImage] == YES){
            [self showBoxesSelected];
            ++boxStage;
            
            if (levels < 17){
                savedImage =[[boxesButtonsArray objectAtIndex:boxStage]backgroundImageForState:UIControlStateNormal];
            }else if ((boxStage == boxesButtonsArray.count)){
                win = YES;
            }
        }else{
            gameOver = YES;
        }
    }
    
    
    if(win != YES || gameOver != YES){
        if(boxStage - 1 == levels){
        ++levels;
        roundOver = YES;
        }
        
        [self nextLevel];
    }
    
//    if ((boxStage == 1)){
//        win = true;
//    }
    
    [self win];
    [self gameOver];
}//Box selector for current box

-(void) nextLevel{
    if (roundOver == YES)
    {
        if (levels != 0)
        {
            [self playNewLevel];
        }
        
        playActionEnabled = NO;
        [goWait setTitle:@"WAIT" forState:UIControlStateNormal];
        
        [self blinkAll];
        roundOver = NO;
        boxStage = 0;
        savedImage =[[boxesButtonsArray objectAtIndex:boxStage]backgroundImageForState:UIControlStateNormal];
    }
}//Sets up next level as the previous one was cleared

-(void) hideBoxes{
    int i = 0;
    int maxCount = [boxesButtonsArray count];
    
    while (i != maxCount)
    {
        [[boxesButtonsArray objectAtIndex:i] setHidden:YES];
        i++;
    }
    
}//Hides all buttons at the beggining of new gameplay

-(void) hideLastBox{
    
    [[boxesButtonsArray objectAtIndex:levels] setHidden:YES];
    
}//Hides last box

-(void) showLastBox{
    
    [[boxesButtonsArray objectAtIndex:levels] setHidden:NO];
    
}//Hides last box

-(void) showBoxes{
    NSUInteger i = 0;
    NSUInteger *maxCount = [boxesButtonsArray count];
    
    while (i != maxCount)
    {
        [[boxesButtonsArray objectAtIndex:i] setHidden:NO];
        i++;
    }
    
}//Shows all boxes that was initialzed in the createRandomAssortment function

-(void) showBoxesCurrent{
    
//    while (i <= maxCount)
//    {
//        
//        [[boxesButtonsArray objectAtIndex:i] setHidden:NO];
//        [[boxesButtonsArray objectAtIndex:i] setHighlighted:NO];
//        i++;
//    }

    [[boxesButtonsArray objectAtIndex:levels] setHidden:NO];
    [[boxesButtonsArray objectAtIndex:levels] setHighlighted:NO];
    
}//Show all boxes to click for this level

-(void) showBoxesSelected{
    int i = 0;
    int maxCount = boxStage;
    
    while (i <= maxCount){
        
        [[boxesButtonsArray objectAtIndex:i] setHidden:NO];

        i++;
        
    }
    
}//Show boxes already Selected

-(void) blinkAll{
    [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(showBoxesCurrent) userInfo:nil repeats:NO];
    [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(playCamera) userInfo:nil repeats:NO];
    
    [NSTimer scheduledTimerWithTimeInterval:.5 target:self selector:@selector(hideLastBox) userInfo:nil repeats:NO];
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(showBoxesCurrent) userInfo:nil repeats:NO];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(playCamera) userInfo:nil repeats:NO];
    
    [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(hideLastBox) userInfo:nil repeats:NO];
    
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(showBoxesCurrent) userInfo:nil repeats:NO];
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(playCamera) userInfo:nil repeats:NO];
    
    //[NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(hideLastBox) userInfo:nil repeats:NO];
    
    //[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(showBoxesCurrent) userInfo:nil repeats:NO];
    
    //[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(showLastBox) userInfo:nil repeats:NO];
    
    [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(hideBoxes) userInfo:nil repeats:NO];
    
    [NSTimer scheduledTimerWithTimeInterval:2.8 target:self selector:@selector(enableGamePlay) userInfo:nil repeats:NO];
}//Blinks all boxes of this level 3 times then hides them to be chosen

-(void) enableGamePlay{
    playActionEnabled = YES;
    [goWait setTitle:@"GO" forState:UIControlStateNormal];
}//Sets playActionEnabled to YES

-(void) win{
    if (win == YES)
    {
        [self playWin];
        [self hideBoxes];
        [self initilizeVars];
        [self insertSpacesIntoArray];
        [self createRandomAssortment];
        [self nextLevel];
    }
}//Player wins game restart game

-(void) gameOver{
    if (gameOver == YES)
    {
        [self playGameOver];
        [self hideBoxes];
        [self initilizeVars];
        [self insertSpacesIntoArray];
        [self createRandomAssortment];
        [self nextLevel];
    }
}//Game over restart gane
/***********************************************/
//Resources

//Play Audio
- (void)playClick{
    //    avPlayer.volume =  1.0;
    AudioServicesPlaySystemSound(sIDClick);
}

- (void)playGameOver{
    //    avPlayer.volume =  0.1;
    AudioServicesPlaySystemSound(sIDGameOver);
    
}

- (void)playNewLevel{
    //    avPlayer.volume =  0.1;
    AudioServicesPlaySystemSound(&sIDNewLevel);
    
}

- (void)playCamera{
    //    avPlayer.volume =  0.1;
    AudioServicesPlaySystemSound(sIDCamera);
    
}

- (void)playWin{
    //    avPlayer.volume =  0.1;
    AudioServicesPlaySystemSound(sIDWin);
    
}

- (void) playBackGroundMusic{
    if([avPlayer isPlaying] == NO)
    {
    
        
        [avPlayer stop];
        NSString *stringPath = [[NSBundle mainBundle]pathForResource:@"Classy-8-Bit" ofType:@"mp3"];
        NSURL *url = [NSURL fileURLWithPath:stringPath];
        
        NSError *error;
        
        avPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error: &error];
        [avPlayer play];
        
        avPlayer.volume =  0.1;
    }
    
}
@end
