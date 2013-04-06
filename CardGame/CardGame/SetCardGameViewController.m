//
//  SetCardGameViewController.m
//  CardGame
//
//  Created by Peter Revelas on 3/26/13.
//  Copyright (c) 2013 Peter Revelas. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"
#import "CardMatchingGame.h"

@interface SetCardGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *matchingGameMessage;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong,nonatomic) Deck *newDeck;

@end

@implementation SetCardGameViewController

-(Deck *)newDeck
{
    _newDeck=[[SetCardDeck alloc]init];
    return _newDeck;
}

-(void)setcardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void)updateUI
{
    
    for (UIButton *cardButton in self.cardButtons)
    {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        NSLog(@"update UI card contents are %@",card.contents);
        [cardButton setTitle:card.contents forState:UIControlStateNormal];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];/*
        cardButton.selected=card.isFaceUp;
        cardButton.enabled=!card.isUnplayable;
        cardButton.alpha=(card.isUnplayable ? 0.4 : 1.0);*/
    }
    self.scoreLabel.text=[NSString stringWithFormat:@"Score:%d",self.game.score];
}


@end
