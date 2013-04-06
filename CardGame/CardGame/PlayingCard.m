//
//  PlayingCard.m
//  matchgame
//
//  Created by Peter Revelas on 2/11/13.
//  Copyright (c) 2013 Peter Revelas. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (int)match:(NSArray *)otherCards
{
    int matchscore = 0;
    if ([otherCards count] == 1)
    {
        PlayingCard *othercard = [otherCards lastObject];
        if (self.rank == othercard.rank) {
            matchscore = 4;
        } else if([othercard.suit isEqualToString:(self.suit)]){
            matchscore = 1;
        }
    }else if ([otherCards count] == 2)
        {
            PlayingCard *firstcard = [otherCards objectAtIndex:0];
            PlayingCard *secondcard = [otherCards objectAtIndex:1];
            if (self.rank == firstcard.rank && self.rank == secondcard.rank)
            {   
                matchscore = 4;
            } else if([firstcard.suit isEqualToString:(self.suit)] && [secondcard.suit isEqualToString:(self.suit)] )
            {
                matchscore = 1;
            }
        }
    return matchscore;
}


- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit=_suit;

+ (NSArray *)validSuits
{
        return @[@"♠",@"♣",@"♥",@"♦"];
}

-(void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}


- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank
{
    return [self rankStrings].count-1;
}
- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}


@end
