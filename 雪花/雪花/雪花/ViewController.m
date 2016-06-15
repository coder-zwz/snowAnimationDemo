//
//  ViewController.m
//  雪花
//
//  Created by 彭东阳 on 16/6/9.
//  Copyright © 2016年 彭东阳. All rights reserved.
//

#import "ViewController.h"
//刷新次数
static long steps;

@interface ViewController ()

@property (nonatomic, strong) CADisplayLink *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIImageView *bg = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    bg.image = [UIImage imageNamed:@"snowbg"];
    
    //设置图片显示的内容模式
    bg.contentMode = UIViewContentModeScaleAspectFill;
    
    [self.view addSubview:bg];
    
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
    
    //加入运行循环
    [self.timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
}

//点击的时候动画停止
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    [self stopTimer];
    self.timer.paused = YES;

}
//
//- (void)stopTimer
//{
//
//    [self.timer invalidate];
//
//}

- (void)update
{
    steps++;
    
    [self snow];

}

//方法一 用transform属性设置

- (void)snow
{

    UIImage *image = [UIImage imageNamed:@"雪花"];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    //随机在0.1~0.4缩放
    CGFloat scale = arc4random_uniform(40)/100.0;
    //设置雪花缩放
    imageView.transform = CGAffineTransformMakeScale(scale, scale);
    
    CGSize winSize = self.view.bounds.size;
    
    //添加到视图
    
    CGFloat x = arc4random_uniform(winSize.width);
    CGFloat y = -imageView.bounds.size.height * 0.5;
    
    imageView.center = CGPointMake(x, y);
    
    [self.view addSubview:imageView];
    
#define degree2angle(angle)  ((angle) * M_PI / 180)
    
    //动画下落
    [UIView animateWithDuration:10 animations:^{
        //移动到终点位置
        CGFloat toX = arc4random_uniform(winSize.width);
        CGFloat toY = winSize.height + imageView.bounds.size.height * 0.5;
        
        imageView.center = CGPointMake(toX, toY);
        
        //下落过程中，设置雪花360度旋转
        imageView.transform = CGAffineTransformRotate(imageView.transform, degree2angle(arc4random_uniform(360)));
        
        imageView.alpha = 0.3;
        
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
    
     
    }];
    
    


}


@end
