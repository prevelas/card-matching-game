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
    NSDictionary *cardView = @{@"red": [UIColor redColor],@"green": [UIColor greenColor],@"blue":[UIColor blueColor],@"triangle":@"▲", @"circle":@"●",@"square":@"■"};
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
        NSAttributedString *title=[self cardTitle:card];
        [cardButton setAttributedTitle:title forState:UIControlStateNormal];
        [cardButton setAttributedTitle:title forState:UIControlStateSelected];
        [cardButton setAttributedTitle:title forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected=card.isFaceUp;
        cardButton.enabled=!card.isUnplayable;
        cardButton.alpha=(card.isUnplayable ? 0.3 : 1.0);
    }
    self.scoreLabel.text=[NSString stringWithFormat:@"Score:%d",self.game.score];
}

 

-(NSAttributedString *)cardTitle:(Card *)card
{
    //break up the card model contents
    NSArray *modelContents=[card.contents componentsSeparatedByString:@","];
    NSString *color=[modelContents objectAtIndex:0];
    NSString *shape=[modelContents objectAtIndex:1];
    NSString *shade=[modelContents objectAtIndex:2];
    int number=[[modelContents objectAtIndex:3] intValue];
    
    //set the text for the card view contents without attributes
    NSString *text=[self.cardView objectForKey:shape];
    text=[text stringByPaddingToLength:number withString:[self.cardView objectForKey:shape] startingAtIndex:0];
    //NSDictionary *attributes=@{NSStrokeColorAttributeName:[self.cardView objectForKey:color],NSStrokeWidthAttributeName:@"-5",NSForegroundColorAttributeName:[UIColor whiteColor]};
    //build the attribute dictionary for the card view attributed string
    
    if ([shade isEqual:@"nofill"])
    {
        NSDictionary *attributes=@{NSStrokeColorAttributeName:[self.cardView objectForKey:color],NSStrokeWidthAttributeName:@"-5",NSForegroundColorAttributeName:[UIColor whiteColor]};
    }
    else if ([shade isEqualToString:@"shade"])
    {
        NSDictionary *attributes=@{NSStrokeColorAttributeName:[self.cardView objectForKey:color],NSStrokeWidthAttributeName:@"-5",NSForegroundColorAttributeName:[[self.cardView objectForKey:color] colorWithAlphaComponent:0.4]};
    }else
    {
         NSDictionary *attributes=@{NSForegroundColorAttributeName:[self.cardView objectForKey:color]};
    }
    NSAttributedString *cardTitle=[[NSAttributedString alloc]initWithString:text attributes:attributes];
    NSLog(@"%@", cardTitle);
    return cardTitle;
}


@end
