#import "MainScene.h"
#import "Level2.h"

@implementation MainScene


+ (MainScene *)scene
{
    return [[self alloc] init];
}

- (id)init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    
    return self;
}

-(void)yeniOyun:(id)sender{
    NSLog(@"yeniOyun Girdi");
    //CCScene *gameplayScene = [CCBReader loadAsScene:@"Level2"];
    [[CCDirector sharedDirector] replaceScene:[CCBReader loadAsScene:@"Level2"] withTransition:[CCTransition transitionFadeWithDuration:0.3]];

}

-(void)yeniOyunHard:(id)sender{
    NSLog(@"yeniOyunHard Girdi");
    //CCScene *gameplayScene = [CCBReader loadAsScene:@"Level2"];
    [[CCDirector sharedDirector] replaceScene:[CCBReader loadAsScene:@"Level3"] withTransition:[CCTransition transitionFadeWithDuration:0.3]];
    
}

@end
