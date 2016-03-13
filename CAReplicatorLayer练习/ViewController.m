//
//  ViewController.m
//  CAReplicatorLayer练习
//
//  Created by 张璐 on 15/12/30.
//  Copyright © 2015年 张璐. All rights reserved.
//

#import "ViewController.h"
#define centerX  self.view.frame.size.width * 0.5
@interface ViewController ()

@property(nonatomic,strong)CAReplicatorLayer * loveLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton * showLoveBtn = [[UIButton alloc]initWithFrame:CGRectMake(100, 80, 60, 30)];
    [showLoveBtn setTitle:@"爱心" forState:UIControlStateNormal];
    showLoveBtn.backgroundColor = [UIColor orangeColor];
    [showLoveBtn addTarget:self action:@selector(loveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showLoveBtn];
    
    
}


-(void)loveBtnClick
{
    [self.loveLayer removeFromSuperlayer];
    [self showLove];
}

-(void)showLove
{
    //1.制定bezier路径
    UIBezierPath * bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(centerX, 200)];
    [bezierPath addQuadCurveToPoint:CGPointMake(centerX, 400) controlPoint:CGPointMake(centerX + 200, 20)];
    [bezierPath addQuadCurveToPoint:CGPointMake(centerX, 200) controlPoint:CGPointMake(centerX - 200, 20)];
    [bezierPath closePath];
    
    //2.源layer
    UIView * circleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    circleView.center = CGPointMake(centerX, 200);
    circleView.layer.cornerRadius = 5;
    circleView.backgroundColor = [UIColor redColor];
    
    //3.制作动画
    CAKeyframeAnimation * loveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    loveAnimation.path = bezierPath.CGPath;
    loveAnimation.duration = 8;
    loveAnimation.repeatCount = MAXFLOAT;
    [circleView.layer addAnimation:loveAnimation forKey:nil];
    
    //4.复制layer
    self.loveLayer = [CAReplicatorLayer layer];
    self.loveLayer.instanceCount = 40;
    self.loveLayer.instanceDelay = 0.2;
    self.loveLayer.instanceColor = [UIColor redColor].CGColor;
    self.loveLayer.instanceRedOffset = -0.02;
    self.loveLayer.instanceBlueOffset = -0.03;
    self.loveLayer.instanceGreenOffset = -0.01;
    [self.loveLayer addSublayer:circleView.layer];
    [self.view.layer addSublayer:self.loveLayer];

}


@end
