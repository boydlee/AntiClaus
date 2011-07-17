//
//  GameOverScene.m
//  Cocos2DSimpleGame
//
//  Created by Ray Wenderlich on 2/10/10.
//  Copyright 2010 Ray Wenderlich. All rights reserved.
//

#import "HighScoresScene.h"
#import "GameMenuScene.h"
#import "Database.h"
#import "Utils.h"

@implementation HighScoresScene
@synthesize layer = _layer;

- (id)init {
	
	if ((self = [super init])) {
		self.layer = [HighScoresLayer node];
		[self addChild:_layer];
	}
	return self;
}

- (void)dealloc {
	[_layer release];
	_layer = nil;
	[super dealloc];
}

@end

@implementation HighScoresLayer


-(id) init
{
	if( (self=[super initWithColor:ccc4(255,255,255,255)] )) {
		
		
		CGSize winSize = [[CCDirector sharedDirector] winSize];
		
		CCSprite *backgroundMenuSprite = [[CCSprite alloc] initWithFile:@"highscores_bg.png"];
		backgroundMenuSprite.position = ccp(winSize.width/2, winSize.height/2);
		[backgroundMenuSprite _setZOrder:1];
		[self addChild:backgroundMenuSprite];
		
		
		// Standard method to create a button
		CCMenuItem *homeButton = [CCMenuItemImage 
											itemFromNormalImage:@"homebtn.png" selectedImage:@"homebtn.png" 
											target:self selector:@selector(highScoresDone)];
		
		CCMenu *starMenu = [CCMenu menuWithItems:homeButton, nil];
		starMenu.position = ccp(450,295);
		[starMenu _setZOrder:3];
		[self addChild:starMenu];
		
		[self loadScores];
		
	}	
	return self;
}

-(void) loadScores {	
	NSMutableArray* items = [Database getFavourites:[Utils appDelegate].database];
	NSNumber *itemCount = [items count];
	if(!items)
		return;
	
	int _top = 35;
	int _left = 165;
	for(int i = ([items count]-1); i >= 0; i--)
	{
		Fav *fav = [items objectAtIndex:i];
		CCLabelTTF *_label = [CCLabelTTF labelWithString:fav.score_name dimensions:CGSizeMake(200, 20) alignment:UITextAlignmentLeft fontName:@"Helvetica" fontSize:15];
		[_label _setZOrder:5];
		_label.position = ccp(_left,_top);
		[self addChild:_label];
		
		CCLabelTTF *_label2 = [CCLabelTTF labelWithString:fav.score_points fontName:@"Helvetica" fontSize:14];
		[_label2 _setZOrder:5];
		_label2.position = ccp(_left + 200,_top);
		[self addChild:_label2];
		
		_top = _top + 22;
	}	
}


- (void)highScoresDone {
	[[CCDirector sharedDirector] replaceScene:[[[GameMenuScene alloc] init] autorelease]];
}

- (void)dealloc {
	[super dealloc];
}

@end
