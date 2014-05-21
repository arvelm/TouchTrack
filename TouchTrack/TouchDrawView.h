//
//  TouchDrawView.h
//  TouchTrack
//
//  Created by Ivan on 14-5-12.
//  Copyright (c) 2014年 Ivan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TouchDrawView : UIView

@property(nonatomic,strong) NSMutableArray * completeLines;
@property(nonatomic,strong) NSMutableDictionary* LinesInProscess;

-(void)clearAll;

-(void)endTouches:(NSSet *) touches;

@end
