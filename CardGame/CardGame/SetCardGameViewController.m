//
//  SetCardGameViewController.m
//  CardGame
//
//  Created by Peter Revelas on 3/26/13.
//  Copyright (c) 2013 Peter Revelas. All rights reserved.
//

#import "SetCardGameViewController.h"



@interface SetCardGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *matchingGameMessage;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) NSString *cardContents;
@property (strong, nonatomic) NSDictionary *cardView;
@end

@implementation SetCardGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateUI];
}


-(NSDictionary *)cardView
{
    NSDictionary *cardView = @{@"red": [UIColor redColor],@"green": [UIColor greenColor],@"blue":[UIColor blueColor],@"triangle":@"△", @"circle":@"❍",@"square":@"❒"};
    return cardView;
}

@synthesize newDeck;

-(Deck *)newDeck
{
    newDeck=[[SetCardDeck alloc]init];
    return newDeck;
}

- (void)updateUI
{
    
    for (UIButton *cardButton in self.cardButtons)
    {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        NSString *title=[self cardContents:card];
        [cardButton setTitle:title forState:UIControlStateNormal];
        [cardButton setTitle:title forState:UIControlStateSelected];
        [cardButton setTitle:title forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected=card.isFaceUp;
        cardButton.enabled=!card.isUnplayable;
        cardButton.alpha=(card.isUnplayable ? 0.3 : 1.0);
    }
    self.scoreLabel.text=[NSString stringWithFormat:@"Score:%d",self.game.score];
}

 

-(NSString *)cardContents:(Card *)card
{
    _cardContents=@"";
    NSArray *attributes=[card.contents componentsSeparatedByString:@","];
    NSString *color=[attributes objectAtIndex:0];
    NSString *shape=[attributes objectAtIndex:1];
    //NSString *shade=[attributes objectAtIndex:2];
    int number=[[attributes objectAtIndex:3] intValue];
    for (int i=1; i<=number; i++) {
        self.cardContents=[self.cardContents stringByAppendingString:[self.cardView objectForKey:(shape)]];
    }
    NSMutableAttributedString *mutCardContents=[[NSMutableAttributedString alloc]initWithString:self.cardContents];
    NSRange range = NSMakeRange(0,[mutCardContents length]);
    [mutCardContents addAttribute:(NSForegroundColorAttributeName) value:([self.cardView objectForKey:(color)]) range:(range)];
    self.cardContents=[mutCardContents copy];
    return self.cardContents;
}


@end
