//
//  matchgameViewController.m
//  matchgame
//
//  Created by Peter Revelas on 2/11/13.
//  Copyright (c) 2013 Peter Revelas. All rights reserved.
//

#import "matchgameViewController.h"

@interface matchgameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@end

@implementation matchgameViewController

- (void)setFlipCount:(int)flipCount
{
    _flipCount=flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    self.flipCount++;
}

@end
