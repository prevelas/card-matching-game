//
//  CardMatchingGame.m
//  CardGame
//
//  Created by Peter Revelas on 3/14/13.
//  Copyright (c) 2013 Peter Revelas. All rights reserved.
//

#import "CardMatchingGame.h"
#import "SetCard.h"
#import "PlayingCard.h"


@interface CardMatchingGame()
@property (readwrite, nonatomic) int score;
@property (strong, nonatomic) NSMutableArray *cards;//of Cards
@property (strong, nonatomic) NSMutableArray *matchCards;//of Cards
@property (weak, nonatomic) NSString *matchMessage;
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards=[[NSMutableArray alloc]init];
    return _cards;
}
- (NSMutableArray *)matchCards
{
    if (!_matchCards) _matchCards=[[NSMutableArray alloc]init];
    return _matchCards;
}

#define MATCHBONUS 4
#define MISMATCHPENALTY 2
#define FLIPCOST 1


-(NSString *)flipCardAtIndex:(NSUInteger)index;
{
    Card *card = [self cardAtIndex:index];//this is the last card selected to be flipped
    if (!card.isUnplayable) //makes sure the selected card is playable
    {
        if (!card.isFaceUp) //makes sure the card was face down when selected
        {
            self.matchCards=nil;
            for(Card *othercard in self.cards){
                if(othercard.isFaceUp && !othercard.isUnplayable){
                    [self.matchCards addObject:othercard];
                }
            }
            if (([card isKindOfClass:[SetCard class]] && self.matchCards.count==2) || ([card isKindOfClass:[PlayingCard class]] && self.matchCards.count==1)) {
                int matchScore = [card match:self.matchCards];
                if (matchScore)
                {
                    self.score += matchScore * MATCHBONUS;
                    card.unplayable=YES;
                    self.matchMessage=[NSString stringWithFormat:@"%@ matches ",card.contents];
                    for(Card *othercard in self.matchCards)
                    {
                        othercard.Unplayable=YES;
                        self.matchMessage=[self.matchMessage stringByAppendingString:othercard.contents];
                    }
                    
                }else{
                    self.score -= MISMATCHPENALTY;
                    self.matchMessage=[NSString stringWithFormat:@"%@ doesn't match ",card.contents];
                    for(Card *othercard in self.matchCards)
                    {
                        othercard.faceUp=NO;
                        self.matchMessage=[self.matchMessage stringByAppendingString:othercard.contents];
                    }
                }
            }else self.matchMessage=[NSString stringWithFormat:@" You flipped %@ ",card.contents];

        } card.faceUp = !card.faceUp; // takes a face up card and flips it face down
    }
    return self.matchMessage;
}

-(Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index]:nil;
}

-(id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self=[super init];
    
    if (self) {
        for (int i=0; i<count; i++) {
            Card *card=[deck drawRandomCard];
            if (card) {
                            self.cards[i]=card;
            } else {
                self=nil;
                break;
            }
        }
    }
    return self;
}



@end
