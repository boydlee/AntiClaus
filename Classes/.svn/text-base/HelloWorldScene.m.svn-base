//
// cocos2d Hello World example
// http://www.cocos2d-iphone.org
//

// Import the interfaces
#import "HelloWorldScene.h"
#import "SimpleAudioEngine.h"
#import "GameOverScene.h"
#import "GameMenuScene.h"
#import "Database.h"
#import "Fav.h"
#import "Globals.h"
#import "Utils.h"

@implementation HelloWorldScene
@synthesize layer = _layer;

- (id)init {
    if ((self = [super init])) {
		self.layer = [HelloWorld node];
        [self addChild:_layer];
    }
	
	return self;
}

- (void)dealloc {
    self.layer = nil;
    [super dealloc];
}

@end


// HelloWorld implementation
@implementation HelloWorld

-(void)spriteMoveFinished:(id)sender {

	CCSprite *sprite = (CCSprite *)sender;
	[self removeChild:sprite cleanup:YES];
	
	if (sprite.tag == 1 || sprite.tag == 4 || sprite.tag == 3) { // target
		[_targets removeObject:sprite];
		
	} else if (sprite.tag == 2) { // projectile
		[_projectiles removeObject:sprite];
	}
	
}

-(void)santaDirectionLeftFinished:(id)sender {
	
	CCSprite *santaDirectionLeftSprite = (CCSprite *)sender;
	[santaDirectionLeftSprite stopAllActions];
	
	// position the sprite at the same x and y as the touched  target sprite
	santaDirectionLeftSprite.position = ccp(600, 260);
	
	CCAnimation *santaDirectionLeftAnimation = [CCAnimation animationWithName:@"santa1" delay:0.35f];
	
	int frameCount = 0;
	for (int y = 0; y < 2; y++) {
		CCSpriteFrame *frame = [CCSpriteFrame  frameWithTexture:spriteSheet.texture rect:CGRectMake(0, (y*41) + 330,200, 44)];
		[santaDirectionLeftAnimation addFrame:frame];
		
		frameCount++;
		
		if (frameCount == 2)
			break;	
	}
	
	CCAnimate *santaDirectionLeftAction = [CCAnimate actionWithAnimation:santaDirectionLeftAnimation];
	CCRepeatForever *repeat = [CCRepeatForever actionWithAction:santaDirectionLeftAction];
	[santaDirectionLeftSprite runAction:repeat];
	
	id actionMove = [CCMoveTo actionWithDuration:10.0 position:ccp(-1200, 260)];
	id actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(santaDirectionLeftFinished:)];
	[santaDirectionLeftSprite runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
}

-(void)santaDirectionRightFinished:(id)sender {
	
	CCSprite *santaDirectionRightSprite = (CCSprite *)sender;
	[santaDirectionRightSprite stopAllActions];
	
	// position the sprite at the same x and y as the touched  target sprite
	santaDirectionRightSprite.position = ccp(-1200, 260);
	
	CCAnimation *santaDirectionRightAnimation = [CCAnimation animationWithName:@"santa2" delay:0.35f];
	
	int frameCount = 0;
	for (int y = 0; y < 2; y++) {
		CCSpriteFrame *frame = [CCSpriteFrame  frameWithTexture:spriteSheet.texture rect:CGRectMake(0, (y*41) + 430,200, 41)];
		[santaDirectionRightAnimation addFrame:frame];
		
		frameCount++;
		
		if (frameCount == 2)
			break;	
	}
	
	CCAnimate *santaDirectionLeftAction = [CCAnimate actionWithAnimation:santaDirectionRightAnimation];
	CCRepeatForever *repeat = [CCRepeatForever actionWithAction:santaDirectionLeftAction];
	[santaDirectionRightSprite runAction:repeat];
	
	id actionMove2 = [CCMoveTo actionWithDuration:10.0 position:ccp(600, 260)];
	id actionMoveDone2 = [CCCallFuncN actionWithTarget:self selector:@selector(santaDirectionRightFinished:)];
	[santaDirectionRightSprite runAction:[CCSequence actions:actionMove2, actionMoveDone2, nil]];
}

-(CCSprite*)randomSprite:(int)randomInt {
	switch (randomInt)
	{
		case 0:
		{
			CCSprite *target = [CCSprite spriteWithFile:@"present0.png" rect:CGRectMake(0, 0, 25, 30)];
			return target;
		}
			break;
			
		case 1:
		{
			CCSprite *target = [CCSprite spriteWithFile:@"present1.png" rect:CGRectMake(0, 0, 25, 30)];
			return target;
		}
			break;
			
		case 2:
		{
			CCSprite *target = [CCSprite spriteWithFile:@"present2.png" rect:CGRectMake(0, 0, 25, 30)];
			return target;
		}
			break;
			
		case 3:
		{
			CCSprite *target = [CCSprite spriteWithFile:@"present3.png" rect:CGRectMake(0, 0, 25, 30)];
			return target;
		}
			break;
			
		case 4:
		{
			CCSprite *target = [CCSprite spriteWithFile:@"present4.png" rect:CGRectMake(0, 0, 30, 20)];
			return target;
		}
			break;
			
		case 5:
		{
			CCSprite *target = [CCSprite spriteWithFile:@"present5.png" rect:CGRectMake(0, 0, 30, 20)];
			return target;
		}
			break;
		default:
		{	
			CCSprite *target = [CCSprite spriteWithFile:@"present1.png" rect:CGRectMake(0, 0, 25, 30)];
			return target;
		}
			break;
	}
}

- (void)selectSpriteForTouch:(CGPoint)touchLocation {
    for (CCSprite *sprite in _targets) {
        if (CGRectContainsPoint(sprite.boundingBox, touchLocation)) {            
            [sprite stopAllActions];
			//[_selectedTargets addObject:sprite];
			
			CGSize winSize = [[CCDirector sharedDirector] winSize];
			
			if(sprite.tag == 4)
			{
				//coin sprite
				_projectilesDestroyed++;
				_points = _points + 101;
				
				NSString *value = [[Globals sharedInstance] effects];
				if([value isEqualToString:@"YES"]) {
					[[SimpleAudioEngine sharedEngine] playEffect:@"storebell-short.mp3"];
				}
				
				[sprite stopAllActions];
				[sprite setPositionInPixels:CGPointMake(-400,-400)];
				[_targets removeObject:sprite];
				[self removeChild:sprite cleanup:YES];	
			}	
			if(sprite.tag == 5)
			{
				//slow down sprite				
				NSString *value = [[Globals sharedInstance] effects];
				if([value isEqualToString:@"YES"]) {
					[[SimpleAudioEngine sharedEngine] playEffect:@"alarmtick.mp3"];
				}
				
				prevminDuration = minDuration;
				prevmaxDuration = maxDuration;
				minDuration = 7.0;
				maxDuration = 8.0;				
				[self schedule:@selector(slowDownLogic:) interval:18];
				
				[sprite stopAllActions];
				[sprite setPositionInPixels:CGPointMake(-400,-400)];
				[_targets removeObject:sprite];
				[self removeChild:sprite cleanup:YES];	
			}
			
			
			int r = rand() % 15;
			if(r == 0 && sprite.tag == 1) 
			{
				//1st possibilty, that is a coin for extra points!
				CCSprite *coinSprite = [CCSprite spriteWithTexture:spriteSheet.texture rect:CGRectMake(0, 0, 32, 32)];
				[spriteSheet addChild:coinSprite];
				
				// position the sprite at the same x and y as the touched  target sprite
				coinSprite.position = sprite.position;
				
				CCAnimation *coinAnimation = [CCAnimation animationWithName:@"coin" delay:0.1f];
				
				int frameCount = 0;
				for (int y = 0; y < 9; y++) {
						CCSpriteFrame *frame = [CCSpriteFrame  frameWithTexture:spriteSheet.texture rect:CGRectMake(0,y*32,32,32)];
						[coinAnimation addFrame:frame];
						
						frameCount++;
						
						if (frameCount == 9)
							break;	
				}
				
				CCAnimate *coinAction = [CCAnimate actionWithAnimation:coinAnimation];
				CCRepeatForever *repeat = [CCRepeatForever actionWithAction:coinAction];
				[coinSprite runAction:repeat];
				coinSprite.tag = 4;
				
				[_targets addObject:coinSprite];
				
				//finally remove the touched sprite so its replaced fully by the coin
				[_targets removeObject:sprite];
				[self removeChild:sprite cleanup:YES];	

				
				//end coin 
			}
			else if(r == 1 && sprite.tag == 1) 
			{
				//1st possibilty, that is a coin for extra points!
				CCSprite *caneSprite = [CCSprite spriteWithTexture:spriteSheet.texture rect:CGRectMake(0, 0, 16, 32)];
				[spriteSheet addChild:caneSprite];
				
				// position the sprite at the same x and y as the touched  target sprite
				caneSprite.position = sprite.position;
				
				CCAnimation *caneAnimation = [CCAnimation animationWithName:@"candycane" delay:0.3f];
				
				int frameCount = 0;
				for (int y = 0; y < 6; y++) {
					CCSpriteFrame *frame = [CCSpriteFrame  frameWithTexture:spriteSheet.texture rect:CGRectMake(48,y*32,16,32)];
					[caneAnimation addFrame:frame];
					
					frameCount++;
					
					if (frameCount == 6)
						break;	
				}
				
				CCAnimate *caneAction = [CCAnimate actionWithAnimation:caneAnimation];
				CCRepeatForever *repeat = [CCRepeatForever actionWithAction:caneAction];
				[caneSprite runAction:repeat];
				caneSprite.tag = 4;
				
				[_targets addObject:caneSprite];
				
				//finally remove the touched sprite so its replaced fully by the coin
				[_targets removeObject:sprite];
				[self removeChild:sprite cleanup:YES];	
				
				
				//end candy cane 
			}
			else if(r == 2 && sprite.tag == 1) 
			{
				//1st possibilty, that is a purple star for extra points!
				CCSprite *purpleStarSprite = [CCSprite spriteWithTexture:spriteSheet.texture rect:CGRectMake(0, 0,24,32)];
				[spriteSheet addChild:purpleStarSprite];
				
				// position the sprite at the same x and y as the touched  target sprite
				purpleStarSprite.position = sprite.position;
				
				CCAnimation *purpleStarAnimation = [CCAnimation animationWithName:@"purplestar" delay:0.1f];
				
				int frameCount = 0;
				for (int y = 0; y < 6; y++) {
					CCSpriteFrame *frame = [CCSpriteFrame  frameWithTexture:spriteSheet.texture rect:CGRectMake(86,y*32,24,32)];
					[purpleStarAnimation addFrame:frame];
					
					frameCount++;
					
					if (frameCount == 6)
						break;	
				}
				
				CCAnimate *purpleStarAction = [CCAnimate actionWithAnimation:purpleStarAnimation];
				CCRepeatForever *repeat = [CCRepeatForever actionWithAction:purpleStarAction];
				[purpleStarSprite runAction:repeat];
				purpleStarSprite.tag = 4;
				
				[_targets addObject:purpleStarSprite];
				
				//finally remove the touched sprite so its replaced fully by the coin
				[_targets removeObject:sprite];
				[self removeChild:sprite cleanup:YES];	
				
				
				//end purple star
			}
			else if(r == 3 && sprite.tag == 1 && maxDuration < 8.0) 
			{
				//another possibility, slow down time. only available if time is not already slow
				CCSprite *slowSprite = [[CCSprite alloc] initWithFile:@"clockicon.png"];
				[self addChild:slowSprite];
				
				// position the sprite at the same x and y as the touched  target sprite
				slowSprite.position = sprite.position;				
				slowSprite.tag = 5;
				
				[_targets addObject:slowSprite];
				
				//finally remove the touched sprite so its replaced fully by the coin
				[_targets removeObject:sprite];
				[self removeChild:sprite cleanup:YES];	
				
				
				//end slowSprite
			}
			else if(sprite.tag == 1)
			{
				//final possibility is that the present earns points and disapeers off screen
				//points are added in the method where the sprite is removed from action
				int minX = sprite.contentSize.width/2;
				int maxX = winSize.width - sprite.contentSize.width/2;
				int rangeX = maxX - minX;
				int actualX = (arc4random() % rangeX) + minX;
			
				float actualDuration = 0.3;
				id actionMove = [CCMoveTo actionWithDuration:actualDuration position:ccp(actualX, 321)];
				id actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveFinished:)];
				[sprite runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
				sprite.tag = 3;
				
				_projectilesDestroyed++;
				_points = _points + 24;
				
				// Start up the background music
				
				NSString *value = [[Globals sharedInstance] effects];
				if([value isEqualToString:@"YES"]) {
					[[SimpleAudioEngine sharedEngine] playEffect:@"cartoon015.mp3"];
				}
			}
			
			
            break;
        }
    }    
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {    
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    [self selectSpriteForTouch:touchLocation];      
    return TRUE;    
}

-(void)addTarget {
	int r = rand() % 5;
	CCSprite *target = [self randomSprite:r];
	
	// Determine where to spawn the target along the Y axis
	CGSize winSize = [[CCDirector sharedDirector] winSize];
	int minY = target.contentSize.width/2;
	int maxY = winSize.width - target.contentSize.width/2;
	int rangeY = maxY - minY;
	int actualY = (arc4random() % rangeY) + minY;
	
	// Create the target slightly off-screen along the right edge,
	// and along a random position along the Y axis as calculated above
	target.position = ccp(actualY,winSize.width + (target.contentSize.width/2));
	[self addChild:target];
	
	// Determine speed of the target
	int rangeDuration = maxDuration - minDuration;
	int actualDuration = (arc4random() % rangeDuration) + minDuration;
	
	// Create the actions
	id actionMove = [CCMoveTo actionWithDuration:actualDuration position:ccp(actualY, -target.contentSize.height/2)];
	id actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveFinished:)];
	[target runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
	CCRotateTo * rotLeft = [CCRotateBy actionWithDuration:0.1 angle:-4.0];
	CCRotateTo * rotCenter = [CCRotateBy actionWithDuration:0.1 angle:0.0];
	CCRotateTo * rotRight = [CCRotateBy actionWithDuration:0.1 angle:4.0];
	CCSequence * rotSeq = [CCSequence actions:rotLeft, rotCenter, rotRight, rotCenter, nil];
	[target runAction:[CCRepeatForever actionWithAction:rotSeq]];      
	
	// Add to targets array
	target.tag = 1;
	[_targets addObject:target];
}

-(void)slowDownLogic:(ccTime)dt {	
	minDuration = prevminDuration;
	maxDuration = prevmaxDuration;
	[self unschedule:@selector(slowDownLogic:)];
}


-(void)gameLogic:(ccTime)dt {
 if(_paused == 0)
 {
	if(_health == 10)
	{				
		// Get the dimensions of the window for calculation purposes
		CGSize winSize = [[CCDirector sharedDirector] winSize];
		CCSprite *levelup = [CCSprite spriteWithFile:@"warning.png" rect:CGRectMake(0, 0, 91, 34)];
		levelup.position = ccp(winSize.width/2, winSize.height/2);
		[levelup _setZOrder:0];
		[self addChild: levelup];				
		id actionMove2 = [CCMoveTo actionWithDuration:5.0 position:levelup.position];
		id actionMoveDone2 = [CCCallFuncN actionWithTarget:self selector:@selector(levelupFinished:)];
		[levelup runAction:[CCSequence actions:actionMove2, actionMoveDone2, nil]];
		
	}	 
	else if(_health > 10)
	{		
		[self unscheduleAllSelectors];
		Fav *fav = [Fav alloc];
		fav.score_name =[[Globals sharedInstance] playerName];
		fav.score_points = [NSString stringWithFormat:@"%00000000010d", _points];
		[Database insertFavourite:fav InDatabase:[Utils appDelegate].database];
		[fav release];  		
		
		[[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
		GameOverScene *gameOverScene = [GameOverScene node];
		[[CCDirector sharedDirector] replaceScene:gameOverScene];
	}
	[self addTarget];
 }
}

-(void) addCheerBar {	
 if(_health < 11)
 {
	CCSprite *pointsBar = [[CCSprite alloc] initWithFile:@"bar.png"];
	pointsBar.position = ccp(107 + (10 * _health), 296);
	[pointsBar _setZOrder:0];
	[self addChild:pointsBar];	
	 
	 NSString *value = [[Globals sharedInstance] effects];
	 if([value isEqualToString:@"YES"]) {
		 [[SimpleAudioEngine sharedEngine] playEffect:@"laughter.mp3"];
	 }
 }
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super initWithColor:ccc4(255,255,255,255)] )) {
		
		//initialise the health and points to default levels
		_health = 1;
		_points = 0;
		_paused = 0;
		_level = 1;
		_interval = 1.2;
		
		minDuration = 4.0;
		maxDuration = 6.0;
		
		// Enable touch events
		self.isTouchEnabled = YES;
		[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
		
		[[SimpleAudioEngine sharedEngine] preloadEffect:@"alarmtick.mp3"];		
		[[SimpleAudioEngine sharedEngine] preloadEffect:@"cartoon015.mp3"];	
		[[SimpleAudioEngine sharedEngine] preloadEffect:@"storebell-short.mp3"];
		
		// Initialize arrays
		_targets = [[NSMutableArray alloc] init];
		_projectiles = [[NSMutableArray alloc] init];
		_selectedTargets = [[NSMutableArray alloc] init];
		_pauseObjects = [[NSMutableArray alloc] init];
		
		// Get the dimensions of the window for calculation purposes
		CGSize winSize = [[CCDirector sharedDirector] winSize];
		
		CCSprite *backgroundMenuSprite = [[CCSprite alloc] initWithFile:@"game_bg.png"];
		backgroundMenuSprite.position = ccp(winSize.width/2, winSize.height/2);
		[backgroundMenuSprite _setZOrder:0];
		[self addChild:backgroundMenuSprite];
		
		CCSprite *pointsBar = [[CCSprite alloc] initWithFile:@"pointsbar.png"];
		pointsBar.position = ccp(55, 300);
		[pointsBar _setZOrder:0];
		[self addChild:pointsBar];
		
		scoreLabel = [CCLabelTTF labelWithString:@"0000000000" fontName:@"Helvetica" fontSize:15];
		scoreLabel.position = ccp(55, 296);
		[scoreLabel _setZOrder:0];
		[self addChild:scoreLabel];
		
		CCSprite *cheerBar = [[CCSprite alloc] initWithFile:@"cheerbar.png"];
		cheerBar.position = ccp(170, 300);
		[cheerBar _setZOrder:0];
		[self addChild:cheerBar];
		
		// Standard method to create a button
		CCMenuItem *pauseMenuItem = [CCMenuItemImage 
											itemFromNormalImage:@"button_pause.png" selectedImage:@"button_pause.png" 
											target:self selector:@selector(pauseGame)];
		pauseMenuItem.position = ccp(465, 296);
		
		CCMenu *starMenu = [CCMenu menuWithItems:pauseMenuItem, nil];
		starMenu.position = CGPointZero;
		[starMenu _setZOrder:0];
		[self addChild:starMenu];
		
		[self addHouses];
		
		//this is the sheet of animated sprite
		spriteSheet = [CCSpriteSheet spriteSheetWithFile:@"coin.png"];
		[self addChild:spriteSheet];
		
		
		//add santa
		CCSprite *santaDirectionLeftSprite = [CCSprite spriteWithTexture:spriteSheet.texture rect:CGRectMake(0, 0,200,44)];
		[spriteSheet addChild:santaDirectionLeftSprite];
		
		// position the sprite at the same x and y as the touched  target sprite
		santaDirectionLeftSprite.position = ccp(600, 260);
		
		CCAnimation *santaDirectionLeftAnimation = [CCAnimation animationWithName:@"santa1" delay:0.35f];
		
		int frameCount = 0;
		for (int y = 0; y < 2; y++) {
			CCSpriteFrame *frame = [CCSpriteFrame  frameWithTexture:spriteSheet.texture rect:CGRectMake(0, (y*41) + 330,200, 44)];
			[santaDirectionLeftAnimation addFrame:frame];
			
			frameCount++;
			
			if (frameCount == 2)
				break;	
		}
		
		CCAnimate *santaDirectionLeftAction = [CCAnimate actionWithAnimation:santaDirectionLeftAnimation];
		CCRepeatForever *repeat = [CCRepeatForever actionWithAction:santaDirectionLeftAction];
		[santaDirectionLeftSprite runAction:repeat];
		
		id actionMove = [CCMoveTo actionWithDuration:10.0 position:ccp(-1200, 260)];
		id actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(santaDirectionLeftFinished:)];
		[santaDirectionLeftSprite runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
		
		
		//add second santa
		CCSprite *santaDirectionRightSprite = [CCSprite spriteWithTexture:spriteSheet.texture rect:CGRectMake(0, 0,200,41)];
		[spriteSheet addChild:santaDirectionRightSprite];
		
		// position the sprite at the same x and y as the touched  target sprite
		santaDirectionRightSprite.position = ccp(-1200, 240);
		
		CCAnimation *santaDirectionRightAnimation = [CCAnimation animationWithName:@"santa2" delay:0.35f];
		
		frameCount = 0;
		for (int y = 0; y < 2; y++) {
			CCSpriteFrame *frame2 = [CCSpriteFrame  frameWithTexture:spriteSheet.texture rect:CGRectMake(0, (y*41) + 430,200, 41)];
			[santaDirectionRightAnimation addFrame:frame2];
			
			frameCount++;
			
			if (frameCount == 2)
				break;	
		}
		
		CCAnimate *santaDirectionRightAction = [CCAnimate actionWithAnimation:santaDirectionRightAnimation];
		CCRepeatForever *repeat2 = [CCRepeatForever actionWithAction:santaDirectionRightAction];
		[santaDirectionRightSprite runAction:repeat2];
		
		id actionMove2 = [CCMoveTo actionWithDuration:10.0 position:ccp(600, 240)];
		id actionMoveDone2 = [CCCallFuncN actionWithTarget:self selector:@selector(santaDirectionRightFinished:)];
		[santaDirectionRightSprite runAction:[CCSequence actions:actionMove2, actionMoveDone2, nil]];
		
		
				
		// Add the player to the middle of the screen along the y-axis, 
		// and as close to the left side edge as we can get
		// Remember that position is based on the anchor point, and by default the anchor
		// point is the middle of the object.
		/*
		CCSprite *player = [CCSprite spriteWithFile:@"Player.png" rect:CGRectMake(0, 0, 27, 40)];
		player.position = ccp(player.contentSize.width/2, winSize.height/2);
		[self addChild:player];
		*/
		
		// Call game logic about every second
		[self schedule:@selector(gameLogic:) interval:_interval];
		[self schedule:@selector(update:)];
		
		// Start up the background music
		
		NSString *value = [[Globals sharedInstance] music];
		if([value isEqualToString:@"YES"]) {
			[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"winterland.mp3"];
		}
		
	}
	return self;
}

- (void)update:(ccTime)dt {
 if(_paused == 0)
 {	 
	//find any targets (presents) that intersect with projectiles (houses)
	for (CCSprite *projectile in _projectiles) {
		CGRect projectileRect = CGRectMake(projectile.position.x - (projectile.contentSize.width/2), 
										   projectile.position.y - (projectile.contentSize.height/2), 
										   projectile.contentSize.width, 
										   projectile.contentSize.height);

		NSMutableArray *targetsToDelete = [[NSMutableArray alloc] init];
		for (CCSprite *target in _targets) {
			CGRect targetRect = CGRectMake(target.position.x - (target.contentSize.width/2), 
										   target.position.y - (target.contentSize.height/2), 
										   target.contentSize.width, 
										   target.contentSize.height);
	
			if (CGRectIntersectsRect(projectileRect, targetRect)) {
				[targetsToDelete addObject:target];	
				_health = _health + 1;
				[self addCheerBar];
			}		
			else if((target.position.y > 319 && target.tag == 3) || (target.position.x > 479 && target.tag == 3) || (target.position.y < 0 && target.tag == 3) || (target.position.x < 0 && target.tag == 3)) {
				[targetsToDelete addObject:target];	
			}
		}
		
		for (CCSprite *target in targetsToDelete) {
			[_targets removeObject:target];
			[self removeChild:target cleanup:YES];	
			
			if (_projectilesDestroyed > (_level * 25)) {
				
				NSLog(@"Next Level!!");
				
				
				// Get the dimensions of the window for calculation purposes
				CGSize winSize = [[CCDirector sharedDirector] winSize];
				CCSprite *levelup = [CCSprite spriteWithFile:@"levelup.png" rect:CGRectMake(0, 0, 91, 34)];
				levelup.position = ccp(winSize.width/2, winSize.height/2);
				[levelup _setZOrder:0];
				[self addChild: levelup];				
				id actionMove2 = [CCMoveTo actionWithDuration:3.0 position:levelup.position];
				id actionMoveDone2 = [CCCallFuncN actionWithTarget:self selector:@selector(levelupFinished:)];
				[levelup runAction:[CCSequence actions:actionMove2, actionMoveDone2, nil]];
				
				
				_interval = _interval - 0.1;
				maxDuration = maxDuration - 0.1;
				minDuration = minDuration - 0.1;
				
				if(maxDuration < 3.0) { maxDuration = 3.0; }
				if(minDuration < 2.0) { minDuration = 2.0; }
				
				[self schedule:@selector(gameLogic:) interval:_interval];
				_level++;				
				
				//GameOverScene *gameOverScene = [GameOverScene node];
				//[gameOverScene.layer.label setString:@"You Win!"];
				//[[CCDirector sharedDirector] replaceScene:gameOverScene];
			}
		}
		
		[targetsToDelete release];
	}
 }
	
//finally updated the score label
[scoreLabel setString:[NSString stringWithFormat:@"%00000000010d", _points]];
scoreLabel.userData = [NSString stringWithFormat:@"%00000000010d", _points];
}

- (void)pauseGame {   
	NSLog(@"Paused!");
	CGSize winSize = [[CCDirector sharedDirector] winSize];
	
	CCSprite *backgroundMenuSprite = [[CCSprite alloc] initWithFile:@"paused.png"];
	backgroundMenuSprite.position = ccp(winSize.width/2, winSize.height/2);
	[self addChild:backgroundMenuSprite];
	[_pauseObjects addObject:backgroundMenuSprite];
	
	// Standard method to create a button
	CCMenuItem *menuItem = [CCMenuItemImage 
									  itemFromNormalImage:@"quitgame.png" selectedImage:@"quitgame_over.png" 
							target:self selector:@selector(quitGame)];
	menuItem.position = ccp(winSize.width/2, winSize.height/2 - 50);
	
	
	// Standard method to create a button
	CCMenuItem *gameStartMenuItem = [CCMenuItemImage 
									 itemFromNormalImage:@"resumebutton.png" selectedImage:@"resumebutton_over.png" 
									 target:self selector:@selector(unpauseGame)];
	gameStartMenuItem.position = ccp(winSize.width/2, winSize.height/2);
	
	CCMenu *pauseMenu = [CCMenu menuWithItems: gameStartMenuItem, menuItem, nil];
	pauseMenu.position = CGPointZero;
	[self addChild:pauseMenu];
	[_pauseObjects addObject:pauseMenu];
	
	_paused = 1;	
	[self pauseSchedulerAndActions];
	for (CCSprite *sprite in _targets) {
		[sprite pauseSchedulerAndActions];
	}
}

- (void)quitGame { 
	[[SimpleAudioEngine sharedEngine] stopEffect:@"alarmtick.mp3"];
	[[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
	GameMenuScene *gameMenuScene = [GameMenuScene node];
	[[CCDirector sharedDirector] replaceScene:gameMenuScene];
}

- (void)unpauseGame {   
	NSLog(@"un Paused!");
	
	for(CCSprite *sprite in _pauseObjects) {		
		[self removeChild:sprite cleanup:YES];	
	}
	for(CCMenu *menu in _pauseObjects) {		
		[self removeChild:menu cleanup:YES];	
	}
	[_pauseObjects removeAllObjects];
	
	_paused = 0;	
	[self resumeSchedulerAndActions];
	for (CCSprite *sprite in _targets) {
		[sprite resumeSchedulerAndActions];
	}
}


-(void)levelupFinished:(id)sender {
	[self removeChild:sender cleanup:YES];
}

-(CCSprite*) randomHouse:(int)randomInt {
	switch (randomInt)
	{
		case 0:
		{
			CCSprite *projectile = [CCSprite spriteWithFile:@"house1.png" rect:CGRectMake(0, 0, 58, 90)];
			return projectile;
		}
			break;
			
		case 1:
		{
			
			CCSprite *projectile = [CCSprite spriteWithFile:@"house2.png" rect:CGRectMake(0, 0, 66, 97)];
			return projectile;
		}
			break;
			
		case 2:
		{
			
			CCSprite *projectile = [CCSprite spriteWithFile:@"house3.png" rect:CGRectMake(0, 0, 92, 90)];
			return projectile;
		}
			break;
			
		case 3:
		{
			
			CCSprite *projectile = [CCSprite spriteWithFile:@"house4.png" rect:CGRectMake(0, 0, 48, 75)];
			return projectile;
		}
			break;
			
		case 4:
		{
			
			CCSprite *projectile = [CCSprite spriteWithFile:@"houses5.png" rect:CGRectMake(0, 0, 63, 99)];
			return projectile;
		}
			break;
			
		default:
		{
			
			CCSprite *projectile = [CCSprite spriteWithFile:@"houses5.png" rect:CGRectMake(0, 0, 63, 99)];
			return projectile;
		}
			break;
	}
}

-(void)addHouses {
	//start from point x=0 and then move to the right depending on position of the prior house sprite + sprite width
	int leftMargin = 0;

	while(leftMargin < 481)
	{		
		int r = rand() % 4;		
		
		CCSprite *projectile = [self randomHouse:r];
		NSLog( [NSString stringWithFormat:@"%d", r] );
		NSLog( [NSString stringWithFormat:@"%d", leftMargin] );
		projectile.position = ccp(leftMargin + projectile.contentSize.width/2, projectile.contentSize.height/2);
		leftMargin = leftMargin + projectile.contentSize.width;
	
		//add the house to the screen
		[self addChild:projectile];
	
		// Add to projectiles array
		projectile.tag = 2;
		[_projectiles addObject:projectile];
	}
}

/*
- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

	// Choose one of the touches to work with
	UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView:[touch view]];
	location = [[CCDirector sharedDirector] convertToGL:location];
	
	// Set up initial location of projectile
	CGSize winSize = [[CCDirector sharedDirector] winSize];
	CCSprite *projectile = [CCSprite spriteWithFile:@"Projectile.png" rect:CGRectMake(0, 0, 20, 20)];
	projectile.position = ccp(20, winSize.height/2);
	
	// Determine offset of location to projectile
	int offX = location.x - projectile.position.x;
	int offY = location.y - projectile.position.y;
	
	// Bail out if we are shooting down or backwards
	if (offX <= 0) return;
    
    // Ok to add now - we've double checked position
    [self addChild:projectile];

	// Play a sound!
	[[SimpleAudioEngine sharedEngine] playEffect:@"pew-pew-lei.caf"];
	
	// Determine where we wish to shoot the projectile to
	int realX = winSize.width + (projectile.contentSize.width/2);
	float ratio = (float) offY / (float) offX;
	int realY = (realX * ratio) + projectile.position.y;
	CGPoint realDest = ccp(realX, realY);
	
	// Determine the length of how far we're shooting
	int offRealX = realX - projectile.position.x;
	int offRealY = realY - projectile.position.y;
	float length = sqrtf((offRealX*offRealX)+(offRealY*offRealY));
	float velocity = 480/1; // 480pixels/1sec
	float realMoveDuration = length/velocity;
	
	// Move projectile to actual endpoint
	[projectile runAction:[CCSequence actions:
						   [CCMoveTo actionWithDuration:realMoveDuration position:realDest],
						   [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveFinished:)],
						   nil]];
	
	// Add to projectiles array
	projectile.tag = 2;
	[_projectiles addObject:projectile];
	
}
*/

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	[_targets release];
	_targets = nil;
	
	[_projectiles release];
	_projectiles = nil;
	
	[[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
	
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
