//
//  Level.m
//  BalanceShip
//
//  Created by Gokhan Sargin on 7.11.2015.
//  Copyright 2015 Apportable. All rights reserved.
//

#import "Level3.h"
#import "MainScene.h"



@implementation Level3



-(void)sagagit:(id)sender
{
    NSLog(@"saga git butona basildi");
    
    CCAction* hareketEtme=[CCActionMoveTo actionWithDuration:0.1 position:ccp(_gemi.position.x+30.0,_gemi.position.y)];
    
    [_gemi runAction:hareketEtme];
}

-(void)solagit:(id)sender
{
    NSLog(@"sola gitbutona basildi");
    
    CCAction* hareketEtme=[CCActionMoveTo actionWithDuration:0.1 position:ccp(_gemi.position.x-30.0,_gemi.position.y)];
    
    [_gemi runAction:hareketEtme];
    
}

+ (Level3 *)scene
{
    NSLog(@"level2scene girdi");
    
    return [[self alloc] init];
}

- (id)init
{
    
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    
    NSLog(@"initoldu level3");
    
    
    return self;
}

-(void)onEnter{
    
    [super onEnter];
    // access audio object
    audio = [OALSimpleAudio sharedInstance];
    // play background sound
    [audio preloadEffect:@"dingdong.mp3"];
    [audio preloadEffect:@"ding.WAV"];
    
    //ustDuvarAyarlama;
    CGSize s = [CCDirector sharedDirector].viewSize;
    //[_ustDuvar setPositionInPoints:ccp(s.height, s.width/2.0)];
    [_ustDuvar setPosition:ccp(s.width/2.0, s.height-5.0)];
    [_solDuvar setPosition:ccp(0,0)];
    [_sagDuvar setPosition:CGPointMake(s.width, 0.0)];
    
    [_gemi setPosition:ccp(s.width/2.0, s.height/6.0)];
    
    _physicsNode.collisionDelegate = self;
    [_gemi.physicsBody setCollisionType:@"gemi"];
    [_gemi.physicsBody setCollisionCategories:@[@"gemi"]];
    [_gemi.physicsBody setCollisionMask:@[@"Top"]];
    
    [_top.physicsBody setCollisionType:@"Top"];
    [_top.physicsBody setCollisionCategories:@[@"Top"]];
    [_top.physicsBody setCollisionMask:@[@"zemin",@"gemi"]];
    
    /*
     [yildiz.physicsBody setCollisionType:@"Yildiz"];
     [yildiz.physicsBody setCollisionCategories:@[@"Yildiz"]];
     
     
     
     [yildiz2.physicsBody setCollisionType:@"Yildiz"];
     [yildiz2.physicsBody setCollisionCategories:@[@"Yildiz"]];
     [yildiz2.physicsBody setCollisionMask:@[@"Top"]];
     */
    //--Zemine top çarpması için gerekenler;
    
    [_zemin.physicsBody setCollisionType:@"zemin"];
    [_zemin.physicsBody setCollisionCategories:@[@"zemin"]];
    [_zemin.physicsBody setCollisionMask:@[@"Top"]];
    
    
    
    NSLog(@"calistii acilirken");
    
    puan=0;
    vurulanYildizSayisi=0;
    
    timer =[NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(zaman) userInfo:nil repeats:YES];
    
    //meteorTimer =[NSTimer scheduledTimerWithTimeInterval:8.0 target:self selector:@selector(meteorFirlat) userInfo:nil repeats:YES];
    
    _manager =[[CMMotionManager alloc]init];
    
    if (_manager.accelerometerAvailable) {
        _manager.accelerometerUpdateInterval = 0.04f;
        [_manager startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue]
                                       withHandler:^(CMAccelerometerData *motion, NSError *error)
         {
             yon = motion.acceleration.x*35.0;
             CCAction *dondur = [CCActionRotateTo actionWithDuration:0.10 angle:yon];
             [_gemi runAction:dondur];
             
             
              yon=motion.acceleration.z+0.5;
              CCAction *gemiY = [CCActionMoveTo actionWithDuration:0.1 position:ccp(_gemi.position.x,_gemi.position.y-yon*5.0)];
              
              [_gemi runAction:gemiY];
              
             
             
             
         }
         ];
        
    }
    
    
}
-(void)onExit{
    [super onExit];
    
    [self removeAllChildren];
    [timer invalidate];
    [meteorTimer invalidate];
    
    meteorTimer=nil;
    timer=nil;
    
    [_manager stopDeviceMotionUpdates];
    _manager=nil;
    
    
}

- (void)geriGit:(id)sender
{
    // back to intro scene with transition
    
    NSLog(@"gerigitbasıldı");
    [[CCDirector sharedDirector] replaceScene:[CCBReader loadAsScene:@"MainScene"] withTransition:[CCTransition transitionFadeWithDuration:0.3]];
}

-(void)zaman{
    puan+=2;
    [_puan setString:[NSString stringWithFormat:@"%d",puan]];
    float j=rand()%500;
    
    CCActionMoveTo *hareket=[CCActionMoveTo actionWithDuration:2 position:ccp(renk1.position.x, j)];
    [renk1 runAction:hareket];
    
    j=rand()%500;
    hareket=[CCActionMoveTo actionWithDuration:2 position:ccp(renk1.position.x, j)];
    [renk2 runAction:hareket];
    
    j=rand()%500;
    hareket=[CCActionMoveTo actionWithDuration:2 position:ccp(renk1.position.x, j)];
    [renk3 runAction:hareket];
    
    
    
    
}

-(void)meteorFirlat{
    /*
     [self removeChildByName:@"meteor" cleanup:YES];
     
     meteor =[CCBReader load:@"Top"];
     int i= rand()%100;
     
     [meteor.physicsBody setCollisionType:@"meteor"];
     [meteor.physicsBody setCollisionCategories:@[@"meteor"]];
     [meteor.physicsBody setCollisionMask:@[@"gemi"]];
     
     meteor.scale=0.5;
     meteor.position =CGPointMake(_gemi.position.x-50.0+i,_gemi.position.y+500.0);
     [self addChild:meteor];
     
     CCActionMoveTo *moveaction =[CCActionMoveTo actionWithDuration:3.0 position:ccp(_gemi.position.x-50.0+i, -50)];
     
     [meteor runAction:moveaction];
     //CCActionRotateBy* actionSpin = [CCActionRotateBy actionWithDuration:1.0f angle:360];
     //[meteor runAction:[CCActionRepeatForever actionWithAction:actionSpin]];
     
     */
}


-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair meteor:(CCNode *)meteor gemi:(CCNode *)_gemi
{
    NSLog(@"Meteor carpti ula");
    return YES;
}

-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair Top:(CCNode *)_top Yildiz:(CCNode *)yildiza
{
    NSLog(@"top yıldıza çarptı");
    
    int i =rand()%150;
    int j = rand()%200;
    CGSize screenSizeInPixels = [CCDirector sharedDirector].viewSize;
    
    vurulanYildizSayisi+=1;
    [yildizPuani setString:[NSString stringWithFormat:@"%d",vurulanYildizSayisi]];
    //[yildiza setPosition:CGPointMake(_gemi.position.x-50.0+i, _gemi.position.y+10.0+j)];
    
    CCActionMoveTo *YerDegistir = [CCActionMoveTo actionWithDuration:2.0 position:CGPointMake(screenSizeInPixels.width/2.0-75.0+i, screenSizeInPixels.height/3.0+j)];
    [yildiza runAction:YerDegistir];
    
    
    
    
    return YES;
}

-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair Top:(CCNode *)_top zemin:(CCNode *)zeminPar
{
    
    NSLog(@"zemine top çarptı");
    [audio playEffect:@"ding.WAV"];
    
    [[CCDirector sharedDirector] replaceScene:[CCBReader loadAsScene:@"Level3"] withTransition:[CCTransition transitionFadeWithDuration:2.0]];
    
    
    return YES;
}

-(void)update:(CCTime)delta{
    
    //Yıldız ile top çarpışma detection---------------------------
    if (CGRectIntersectsRect(_top.boundingBox,
                             yildiz.boundingBox)) {
        NSLog(@"çarpiyo ulaaaaaaa");
        int i =rand()%150;
        int j = rand()%200;
        CGSize screenSizeInPixels = [CCDirector sharedDirector].viewSize;
        [audio playEffect:@"dingdong.mp3"];
        
        vurulanYildizSayisi+=1;
        [yildizPuani setString:[NSString stringWithFormat:@"%d",vurulanYildizSayisi]];
        //[yildiza setPosition:CGPointMake(_gemi.position.x-50.0+i, _gemi.position.y+10.0+j)];
        CCActionFadeOut *fade = [CCActionFadeOut actionWithDuration:0.2];
        [yildiz runAction:fade];
        
        [yildiz setPosition:CGPointMake(screenSizeInPixels.width/2.0-75.0+i, screenSizeInPixels.height/3.0+j)];
        
        CCActionFadeIn *fadein = [CCActionFadeIn actionWithDuration:0.2];
        [yildiz runAction:fadein];
        
        /*
         CCActionMoveTo *YerDegistir = [CCActionMoveTo actionWithDuration:2.0 position:CGPointMake(screenSizeInPixels.width/2.0-75.0+i, screenSizeInPixels.height/3.0+j)];
         [yildiz runAction:YerDegistir];
         
         */
    }
    
    
    if (CGRectIntersectsRect(_top.boundingBox,
                             yildiz2.boundingBox)) {
        NSLog(@"çarpiyo ulaaaaaaa");
        [audio playEffect:@"dingdong.mp3"];
        int i =rand()%150;
        int j = rand()%200;
        CGSize screenSizeInPixels = [CCDirector sharedDirector].viewSize;
        
        vurulanYildizSayisi+=1;
        [yildizPuani setString:[NSString stringWithFormat:@"%d",vurulanYildizSayisi]];
        //[yildiza setPosition:CGPointMake(_gemi.position.x-50.0+i, _gemi.position.y+10.0+j)];
        CCActionFadeOut *fade = [CCActionFadeOut actionWithDuration:0.2];
        [yildiz2 runAction:fade];
        
        [yildiz2 setPosition:CGPointMake(screenSizeInPixels.width/2.0-75.0+i, screenSizeInPixels.height/3.0+j)];
        
        CCActionFadeIn *fadein = [CCActionFadeIn actionWithDuration:0.2];
        [yildiz2 runAction:fadein];
        
        /*
         CCActionMoveTo *YerDegistir = [CCActionMoveTo actionWithDuration:2.0 position:CGPointMake(screenSizeInPixels.width/2.0-75.0+i, screenSizeInPixels.height/3.0+j)];
         [yildiz runAction:YerDegistir];
         
         */
    }
    
    
}


@end
