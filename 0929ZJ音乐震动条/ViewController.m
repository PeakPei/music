//
//  ViewController.m
//  0929ZJ音乐震动条
//
//  Created by base on 15/09/19.
//  Copyright © 2015年 base. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *contentV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //添加复制层
    CAReplicatorLayer *Replayer = [CAReplicatorLayer layer];
    Replayer.frame = self.contentV.bounds;
    
    //复制出来5份
    Replayer.instanceCount = 6;
    
    //每个形变都是相对于它的上一个复制层的子层复制出来的
    Replayer.instanceTransform = CATransform3DMakeTranslation(40, 0, 0);
    
    //设置动画延迟0.5s
    Replayer.instanceDelay = 0.5;
    
    //设置动画颜色
    //注意点: 如果设置背景颜色，需要将父控件的背景颜色设置为白色
    Replayer.instanceColor = [self randomColors].CGColor;
    [self.contentV.layer addSublayer:Replayer];

    
//    添加音量震动条
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, self.contentV.bounds.size.height - 150, 30, 150);
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    
    layer.position = CGPointMake(0, self.contentV.bounds.size.height);
    layer.anchorPoint = CGPointMake(0, 1);
    
    [Replayer addSublayer:layer];
    
    //添加动画，只缩放Y值
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath = @"transform.scale.y";
    anim.toValue = @0;
    anim.repeatCount = MAXFLOAT;
    anim.duration = 0.5;
    anim.autoreverses = YES;
    [layer addAnimation:anim forKey:nil];
    
    
}

- (UIColor *)randomColors{
    
     CGFloat r = arc4random_uniform(256) / 255.0;
     CGFloat g = arc4random_uniform(256) / 255.0;
    CGFloat b =arc4random_uniform(256)/255.0;
     return [UIColor colorWithRed:r green:g blue:b alpha:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
