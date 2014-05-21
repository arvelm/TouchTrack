//
//  TouchViewController.m
//  TouchTrack
//
//  Created by Ivan on 14-5-12.
//  Copyright (c) 2014年 Ivan. All rights reserved.
//

#import "TouchViewController.h"
#import "TouchDrawView.h"

@implementation TouchViewController

-(void)loadView
{
//    TouchDrawView *tDrawView=[[TouchDrawView alloc] initWithFrame:[[UIScreen mainScreen]applicationFrame]];
//    [self.view addSubview:tDrawView];
    [self setView:[[TouchDrawView alloc] initWithFrame:CGRectZero]];
    
}
@end
