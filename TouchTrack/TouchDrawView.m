//
//  TouchDrawView.m
//  TouchTrack
//
//  Created by Ivan on 14-5-12.
//  Copyright (c) 2014年 Ivan. All rights reserved.
//

#import "TouchDrawView.h"
#import "Line.h"

@implementation TouchDrawView

//初始化
-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        _completeLines=[[NSMutableArray alloc] init];
        _LinesInProscess=[[NSMutableDictionary alloc]init];
        self.backgroundColor=[UIColor whiteColor];
        [self setMultipleTouchEnabled:YES];
    }

    return self;
}

-(void)drawRect:(CGRect)rect
{
//获取上下文
    CGContextRef cgt=UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(cgt, 6.0);
    CGContextSetLineCap(cgt, kCGLineCapRound);
    
//黑色画笔（完成）
    [[UIColor blueColor] set];
    for (Line *line in _completeLines) {
        CGContextMoveToPoint(cgt, [line begin].x, [line begin].y);
        CGContextAddLineToPoint(cgt, [line end].x, [line end].y );
        CGContextStrokePath(cgt);
    }
    
//红色画笔（未完成）
    [[UIColor redColor] set];
    for (NSArray *v in _LinesInProscess) {
        Line *line =[_LinesInProscess objectForKey:v];
        CGContextMoveToPoint(cgt, [line begin].x, [line begin].y);
        CGContextAddLineToPoint(cgt, [line end].x, [line end].y );
        CGContextStrokePath(cgt);
    }
}


//清空画板
-(void)clearAll
{
    [_completeLines removeAllObjects];
    [_LinesInProscess removeAllObjects];
    [self setNeedsDisplay];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//判断是否连按
    for (UITouch *t in touches) {
        if ([t tapCount]>1) {
            [self clearAll];
            return;
        }
        
//NSValue 作为键使用
        NSValue *key=[NSValue valueWithNonretainedObject:t];
        
// 根据触摸位置创建Line对象
        CGPoint loc=[t locationInView:self];
        Line *newLine=[[Line alloc]init ];
        newLine.begin=loc;
        newLine.end=loc;
        [_LinesInProscess setObject:newLine forKey:key];
        
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch * t in touches) {
        NSValue *key=[NSValue valueWithNonretainedObject:t];
// 找对象当前UITouch对象的Line对象
        Line *line =[_LinesInProscess objectForKey:key];
        
        CGPoint loc=[t locationInView:self];
        line.end=loc;
    }
    [self setNeedsDisplay];
}

-(void)endTouches:(NSSet *) touches
{
    for (UITouch *t in touches) {
        NSValue *key=[NSValue valueWithNonretainedObject:t];
        Line *line =[_LinesInProscess objectForKey:key];
        if (line) {
            [_completeLines addObject:line];
            [_LinesInProscess removeObjectForKey:key];
        }
    }
    [self setNeedsDisplay];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self endTouches:touches];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self endTouches:touches];
}
@end
