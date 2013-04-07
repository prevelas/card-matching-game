//
//  SetCardDeck.m
//  CardGame
//
//  Created by Peter Revelas on 4/3/13.
//  Copyright (c) 2013 Peter Revelas. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck
- (id)init
{
    self=[super init];
    if (self) {
        for (NSUInteger count=1; count <= 3; count++)
        {
            for (NSString *shape in [SetCard shapes])
            {
                for (NSString *shade in [SetCard shading])
                {
                    for (NSString *color in [SetCard colors])
                    {
                        
                        SetCard *card = [[SetCard alloc]init];
                        NSLog(@"card contents are %d, %@, %@, %@",count,shape,shade,color);
                        card.count=count;
                        card.shape=shape;
                        card.shade=shade;
                        card.color=color;
                        [self addCard:card atTop:YES];
                    }
                }
            }
        }
    }
    return self;
}

@end
