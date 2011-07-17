
#import <Foundation/Foundation.h>
// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Globals.h"

// HelloWorld Layer
@interface HelloWorld : CCColorLayer
{
	NSMutableArray *_targets;
	NSMutableArray *_projectiles;
	NSMutableArray *_pauseObjects;
	CCSprite * selSprite;
	CCLabelTTF *scoreLabel;
	CCSpriteSheet *spriteSheet;
	NSMutableArray *_selectedTargets;
	int _projectilesDestroyed;
	int _points;
	int _health;
	int _paused;
	int _level;
	int maxDuration;
	int minDuration;
	int prevmaxDuration;
	int prevminDuration;
	float _interval;
}

- (void)pauseGame;
-(CCSprite*)randomSprite:(int)randomInt;
-(CCSprite*) randomHouse:(int)randomInt;
-(void)addHouses;

@end

@interface HelloWorldScene : CCScene
{
    HelloWorld *_layer;
}
@property (nonatomic, retain) HelloWorld *layer;
@end

