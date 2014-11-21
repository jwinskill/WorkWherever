//
//  InfoWindow.h
//  WorkWherever
//
//  Created by Joshua Winskill on 11/19/14.
//  Copyright (c) 2014 Joshua Winskill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASStarRatingView.h"

@interface InfoWindow : UIView
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet ASStarRatingView *ratingView;

@end
