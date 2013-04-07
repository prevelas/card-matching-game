//
//  CardGameViewController.m
//  CardGame
//
//  Created by Peter Revelas on 3/14/13.
//  Copyright (c) 2013 Peter Revelas. All rights reserved.
//

#import "CardGameViewController.h"


@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipsCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *changeMatchGame;
@property (weak, nonatomic) IBOutlet UILabel *matchingGameMessage;
@property (nonatomic) int scoreChange;
@property (nonatomic) int numOfCards;
@property (strong, nonatomic) CardMatchingGame *game;

@end

@implementation CardGameViewController



- (CardMatchingGame *)game
{
    if (!_game) _game=[[CardMatchingGame alloc]initWithCardCount:[self.cardButtons count]
                                               usingDeck:self.newDeck];
    NSLog(@"card count is @%d",[self.cardButtons count]);
        return _game;
}

-(Deck *)newDeck
{
    _newDeck=[[PlayingCardDeck alloc]init];
    return _newDeck;
}

- (IBAction)dealCards
{
    [self setFlipsCount:0];//resets flipCount
    self.game=nil;//resets game to nil
    [CardMatchingGame self];//init to new set of cards
    self.changeMatchGame.enabled=YES;//re-enables game change switch
    self.matchingGameMessage.text = [NSString stringWithFormat:@"New Deal!"];
    [self updateUI];
    
}

-(void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void)updateUI
{
    UIImage *cardBackImage = [UIImage imageNamed:@"100px-Card_back.png"];
    for (UIButton *cardButton in self.cardButtons)
    {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        if (!card.faceUp) {
            [cardButton setImage:cardBackImage forState:UIControlStateNormal];
        }else [cardButton setImage:[[UIImage alloc] init] forState:UIControlStateNormal];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected=card.isFaceUp;
        cardButton.enabled=!card.isUnplayable;
        cardButton.alpha=(card.isUnplayable ? 0.4 : 1.0);
    }
    self.scoreLabel.text=[NSString stringWithFormat:@"Score:%d",self.game.score];
}

- (IBAction)changeMatchGame:(UISegmentedControl *)sender
{

}

- (IBAction)flipCard:(UIButton *)sender
{
    if (self.changeMatchGame.enabled)
    {
        self.changeMatchGame.enabled=NO;// disables game change switch
    }
    self.numOfCards=2;
    self.numOfCards+=self.changeMatchGame.selectedSegmentIndex;
    self.matchingGameMessage.text = [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender] forNumberofCards:self.numOfCards];
    if (!sender.selected)//only increments the flipcount if I am flipping face up
    {
        self.flipsCount++;
        NSLog(@"you flipped %@",[self.game cardAtIndex:[self.cardButtons indexOfObject:sender]].contents );
    }
    [self updateUI];
}

- (void)setFlipsCount:(int)flipsCount
{
    _flipsCount=flipsCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"flips:%d", self.flipsCount];
}

@end
