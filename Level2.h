//
//  Level2.h
//  BalanceShip
//
//  Created by Gokhan Sargin on 9.11.2015.
//  Copyright 2015 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CoreMotion/CoreMotion.h"

@interface Level2 : CCScene<CCPhysicsCollisionDelegate> {
    CCPhysicsNode* _physicsNode;
    CCNode* _gemi;
    CCLabelTTF* _puan;
    CCLabelTTF* yildizPuani;
    int puan ;
    int vurulanYildizSayisi;
    NSTimer* timer;
    NSTimer* meteorTimer;
    CCButton* btnGeri;
    double yon;
    
    OALSimpleAudio *audio;
    CCNode * yildiz2;
    CCNode* yildiz;
    CCNode * _top;
    
    CCNode* _zemin;
    CCNode* _ustDuvar;
    CCNode* _solDuvar;
    CCNode* _sagDuvar;
    
    CCNodeColor* renk1;
    CCNodeColor* renk2;
    CCNodeColor* renk3;
    
    CCNode*meteor;
    
    CMMotionManager *_manager;
    
}

+(Level2*)scene;
-(id)init;

@end
