//
//  GameMenuScene.h
//  Cocos2DSimpleGame
//
//  Created by Ray Wenderlich on 2/10/10.
//  Copyright 2010 Ray Wenderlich. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Globals.h"

@interface GameMenuLayer : CCColorLayer {
	CCLabelTTF *_label;
	CCMenu *starMenu;
	NSMutableArray *_targets;
}

@property (nonatomic, retain) CCLabelTTF *label;
-(CCSprite*)randomSprite:(int)randomInt;

@end

@interface GameMenuScene : CCScene {
	GameMenuLayer *_layer;
}

@property (nonatomic, retain) GameMenuLayer *layer;

@end
