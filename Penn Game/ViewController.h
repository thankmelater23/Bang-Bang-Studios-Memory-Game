//
//  ViewController.h
//  Penn Game
//
//  Created by Andre on 1/27/13.
//  Copyright (c) 2013 HnG Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface ViewController : UIViewController
{
    //GamePlay Vars
    int levels;             //Var for how many blocks to show
    BOOL win;               //Bool to determine if the player completed the game
    BOOL gameOver;          //Bool to determine if game is over and a new one should be started
    BOOL playActionEnabled; //If user interaction is enabled
    BOOL roundOver;         //Bool to enable nextLevel function
    int boxStage;           //Current box in the current level
    
    //Images
    UIImage *imageHolder;
    
    UIImage *savedImage;//Set property
    
    //AvPlayer
    AVAudioPlayer *avPlayer;
    //Sound ID's
    SystemSoundID *sIDClick;
    SystemSoundID *sIDGameOver;
    SystemSoundID *sIDNewLevel;
    SystemSoundID *sIDCamera;
    SystemSoundID *sIDWin;
    
    //Spaces Button Outlets
    IBOutlet UIButton *space0;
    IBOutlet UIButton *space1;
    IBOutlet UIButton *space2;
    IBOutlet UIButton *space3;
    IBOutlet UIButton *space4;
    IBOutlet UIButton *space5;
    IBOutlet UIButton *space6;
    IBOutlet UIButton *space7;
    IBOutlet UIButton *space8;
    IBOutlet UIButton *space9;
    IBOutlet UIButton *space10;
    IBOutlet UIButton *space11;
    IBOutlet UIButton *space12;
    IBOutlet UIButton *space13;
    IBOutlet UIButton *space14;
    IBOutlet UIButton *space15;
    IBOutlet UIButton *space16;
    IBOutlet UIButton *space17;
    //Pictures
    IBOutlet UIButton *picturePlace0;
    IBOutlet UIButton *picturePlace1;
    IBOutlet UIButton *picturePlace2;
    IBOutlet UIButton *picturePlace3;
    IBOutlet UIButton *picturePlace4;
    //Go/Wait Button
    IBOutlet UIButton *goWait;
    
    //Array Holder For Spaces
    NSMutableArray *boxesButtonsArray;
    NSMutableArray *boxesImagesArray;
    
    
}

//Property
@property(nonatomic, retain) IBOutlet UIButton *space0, *space1, *space2, *space3, *space4, *space5, *space6, *space7, *space8, *space9, *space10, *space11, *space12, *space13, *space14, *space15, *space16, *space17;

@property(nonatomic, retain) IBOutlet UIButton *picturePlace0, *picturePlace1, *picturePlace2, *picturePlace3, *picturePlace4;




-(void) initilizeVars;
-(void) insertSpacesIntoArray;

//Gameplay
-(void) createRandomAssortment;
-(IBAction) faceChooser:(id)sender;
-(void) nextLevel;
-(void) hideBoxes;
-(void) showBoxes;
-(void) showBoxesCurrent;
-(void) showBoxesSelected;
-(void) blinkAll;
-(void) enableGamePlay;
-(void) win;
-(void) gameOver;
@end
