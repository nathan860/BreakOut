//
//  BallSprite.m
//  NPKBreakOut
//
//  Created by Nathan Knable on 1/21/15.
//  Copyright (c) 2015 Nathan Knable. All rights reserved.
//

#import "BallSprite.h"

static NSString * const positionKey     = @"position";
static NSString * const currentSizeKey  = @"currentSize";
static NSString * const nameKey         = @"name";
static NSString * const statusKey       = @"status";
static NSString * const velocityDxKey     = @"velocityDx";
static NSString * const velocityDyKey     = @"velocityDy";


@interface BallSprite ()

@end

@implementation BallSprite


-(BallSprite *)initWithLocation:(CGPoint)location currentSize:(NSString *)currentSize status:(NSString *)status name:(NSString *)name
{
    if (self == [super initWithImageNamed:@"ball.png"]) {
        
        self.name        = name;
        self.position    = location;
        self.currentSize = currentSize;
        
        self.physicsBody                               = [SKPhysicsBody bodyWithCircleOfRadius:self.frame.size.width/2];
        self.physicsBody.friction                      = 0.0;
        self.physicsBody.restitution                   = 1.0;
        self.physicsBody.linearDamping                 = 0.0;
        self.physicsBody.allowsRotation                = NO;
        self.physicsBody.usesPreciseCollisionDetection = YES;
        
        [self updateSelf];
        
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        BallSprite *ball = [[BallSprite alloc] initWithLocation:[[aDecoder decodeObjectForKey:positionKey] CGPointValue]
                                                    currentSize:[aDecoder decodeObjectForKey:currentSizeKey]
                                                         status:[aDecoder decodeObjectForKey:statusKey]
                                                           name:[aDecoder decodeObjectForKey:nameKey]];
        CGVector vector = CGVectorMake([aDecoder decodeFloatForKey:velocityDxKey], [aDecoder decodeFloatForKey:velocityDyKey]);
        ball.physicsBody.velocity = vector;
        self = ball;
        NSLog(@"init with coder ball decoding %@", self.name);
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    NSLog(@"encoding ball %@", self.name);
    [aCoder encodeObject:self.name forKey:nameKey];
    [aCoder encodeObject:self.currentSize forKey:currentSizeKey];
    [aCoder encodeObject:self.status forKey:statusKey];
    [aCoder encodeObject:[NSValue valueWithCGPoint:self.position] forKey:positionKey];
    [aCoder encodeFloat:self.physicsBody.velocity.dx forKey:velocityDxKey];
    [aCoder encodeFloat:self.physicsBody.velocity.dy forKey:velocityDyKey];
    

}

-(void)updateSelf
{
    [super updateSizeWithImageNamed:@"ball.png" currentSize:self.currentSize];
    
}


@end
