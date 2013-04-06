//
//  SetCard.h
//  CardGame
//
//  Created by Peter Revelas on 3/31/13.
//  Copyright (c) 2013 Peter Revelas. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card
@property (strong,nonatomic) NSString *color;
@property (strong,nonatomic) NSString *shape;
@property (strong,nonatomic) NSString *shade;
@property (nonatomic) NSUInteger count;

+ (NSArray *)colors;
+ (NSArray *)shapes;
+ (NSArray *)shading;
@end
