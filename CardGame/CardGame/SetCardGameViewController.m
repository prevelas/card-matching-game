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
@property (strong, nonatomic) NSAttributedString *changeAttributedString;


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
        if (card.isUnplayable)
        {
            [cardButton setAttributedTitle:[self changeAttributedString:title :@{NSBackgroundColorAttributeName:[[UIColor blackColor] colorWithAlphaComponent:0.8]}] forState:UIControlStateSelected|UIControlStateDisabled];
        }
        if (card.isFaceUp) {
            [cardButton setAttributedTitle:[self changeAttributedString:title :@{NSBackgroundColorAttributeName:[[UIColor grayColor] colorWithAlphaComponent:0.4]}] forState:UIControlStateSelected];
        }
        //cardButton.alpha=(card.isUnplayable ? 0.3 : 1.0);
    }
    self.scoreLabel.text=[NSString stringWithFormat:@"Score:%d",self.game.score];
}

 

-(NSAttributedString *)cardTitle:(Card *)card
{
    //break up the card model contents
    NSArray *modelContents=[card.contents componentsSeparatedByString:@","];
    NSString *color=[modelContents objectAtIndex:0];
    NSString *shape=[modelContents objectAtIndex:1];
    NSString *fill=[modelContents objectAtIndex:2];
    int number=[[modelContents objectAtIndex:3] intValue];
    
    //set the text for the card view contents without attributes
    NSString *text=[self.cardView objectForKey:shape];
    text=[text stringByPaddingToLength:number withString:[self.cardView objectForKey:shape] startingAtIndex:0];
    NSDictionary *tempAttributes=@{NSForegroundColorAttributeName:[self.cardView objectForKey:color]};
    NSMutableDictionary *mutAttributes=[NSMutableDictionary dictionaryWithDictionary:tempAttributes];
    //build the attribute dictionary for the card view attributed string
    if ([fill isEqual:@"nofill"])
    {
        NSDictionary *nofill= @{NSStrokeColorAttributeName:[self.cardView objectForKey:color],NSStrokeWidthAttributeName:@"-5",NSForegroundColorAttributeName:[UIColor whiteColor]};
        [mutAttributes addEntriesFromDictionary:nofill];
        
    }
    else if ([fill isEqual:@"shade"])
    {
        NSDictionary *shade=@{NSStrokeColorAttributeName:[self.cardView objectForKey:color],NSStrokeWidthAttributeName:@"-5",NSForegroundColorAttributeName:[[self.cardView objectForKey:color] colorWithAlphaComponent:0.4]};
        [mutAttributes addEntriesFromDictionary:shade];
    }
    NSDictionary *attributes=[NSDictionary dictionaryWithDictionary:mutAttributes];
    NSAttributedString *cardTitle=[[NSAttributedString alloc]initWithString:text attributes:attributes];
    NSLog(@"%@", cardTitle);
    return cardTitle;
}

-(NSAttributedString *)changeAttributedString:(NSAttributedString *)attributedString :(NSDictionary *)attributes;
{
    NSMutableAttributedString *changedAttributedString=[[NSMutableAttributedString alloc] init];
	[changedAttributedString setAttributedString:attributedString];
    NSRange range = {0, [attributedString length]};
    [changedAttributedString addAttributes:attributes range:range];
    return changedAttributedString;
}


@end
