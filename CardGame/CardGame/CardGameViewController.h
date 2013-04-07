//
//  CardGameViewController.h
//  CardGame
//
//  Created by Peter Revelas on 3/14/13.
//  Copyright (c) 2013 Peter Revelas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController : UIViewController
@property (strong,nonatomic) Deck *newDeck;
@end
