//
//  SetCard.m
//  CardGame
//
//  Created by Peter Revelas on 3/31/13.
//  Copyright (c) 2013 Peter Revelas. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard
- (int)match:(NSArray *)otherCards
{
    int score=0;
    if ([otherCards count] == 2)
    {
        SetCard *firstcard = [otherCards objectAtIndex:0];
        SetCard *secondcard = [otherCards objectAtIndex:1];
        if (self.count == firstcard.count && self.count == secondcard.count)
        {
            score++;    //add one to score if they match
        }
        else if(self.count != firstcard.count && self.count != secondcard.count && firstcard.count != secondcard.count)
        {
            score++;    //add one to score if they all mismatch
        }
        if ([self.color isEqualToString:firstcard.color] && [self.color isEqualToString:secondcard.color])
        {
            score++;    //add one to score if they all match
        }
        else if(![self.color isEqualToString:firstcard.color] && ![self.color isEqualToString:secondcard.color] && ![firstcard.color isEqualToString:secondcard.color])
        {
            score++;    //add one to score if they all mismatch
        }
        if ([self.shape isEqualToString:firstcard.shape] && [self.shape isEqualToString:secondcard.shape])
        {
            score++;    //add one to score if they all match
        }
        else if(![self.shape isEqualToString:firstcard.shape] && ![self.shape isEqualToString:secondcard.shape] && ![firstcard.shape isEqualToString:secondcard.shape])
        {
            score++;    //add one to score if they all mismatch
        }
        if ([self.shade isEqualToString:firstcard.shade] && [self.shade isEqualToString:secondcard.shade])
        {
            score++;    //add one to score if they all match
        }
        else if(![self.shade isEqualToString:firstcard.shade] && ![self.shade isEqualToString:secondcard.shade] && ![firstcard.shade isEqualToString:secondcard.shade])
        {
            score++;    //add one to score if they all mismatch
        }
    }
    return ( score==4 ? 1:0); //return a match score of 1 if score is 4 or 0 if it is not.
}

-(NSString *)contents
{
    return [NSString stringWithFormat:@"%@,%@,%@,%d",self.color,self.shape,self.shade,self.count];
}

+ (NSArray *)colors
{
    return @[@"red",@"green",@"blue"];
}
+ (NSArray *)shapes
{
    return @[@"triangle",@"circle",@"square"];
}
+ (NSArray *)shading
{
    return @[@"fill",@"shade",@"nofill"];
}

@end
