//
//  Card.h
//  matchgame
//
//  Created by Peter Revelas on 2/11/13.
//  Copyright (c) 2013 Peter Revelas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property (strong,nonatomic) NSString *contents;
@property (nonatomic, getter = isFaceUp) BOOL faceUp;
@property (nonatomic, getter = isUnplayable) BOOL unplayable;
- (int)match:(NSArray *)otherCards;
@end
