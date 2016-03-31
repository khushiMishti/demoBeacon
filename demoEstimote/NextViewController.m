//
//  NextViewController.m
//  demoEstimote
//
//  Created by Khushboo Sharma on 4/21/15.
//  Copyright (c) 2015 myMe. All rights reserved.
//

#import "NextViewController.h"

@interface NextViewController ()
{
    __weak IBOutlet UIImageView *imgViewBanner;
    NSString *BgImageName;
    NSString *AnimationImageName;
    __weak IBOutlet UIImageView *imgViewBase;
}

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
//    [imgViewBanner setImage:[UIImage imageNamed:AnimationImageName]];
//    [self moveImage:imgViewBanner delay:3.0  duration:3.0 curve:UIViewAnimationOptionCurveLinear x:50.0 y:50.0];
    
   // [self bottomBanner];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    BgImageName = [userDefault valueForKey:@"BGImage"];
    AnimationImageName = [userDefault valueForKey:@"AnimationImage"];
    
    NSLog(@"BgImageName:---%@",BgImageName);
    NSLog(@"AnimationImageName:---%@",AnimationImageName);
    
    [imgViewBase setImage:[UIImage imageNamed:BgImageName]];
    
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(bottomBanner) userInfo:nil repeats:NO];
}

-(void)bottomBanner
{
   
    
    CGPoint point = CGPointMake(imgViewBanner.center.x, imgViewBanner.center.y);//self.imageviewBeacon.center;
    
    //CGPoint startPos = self.imageviewBeacon.layer.position;
    CGPoint endPos = CGPointMake(point.x + 250, point.y);
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position.x"];
    anim.fromValue = [NSValue valueWithCGPoint:point];//[NSNumber numberWithFloat:point.x];
    anim.toValue =  [NSValue valueWithCGPoint:endPos];//[NSNumber numberWithFloat:point.x];
    anim.duration = 10.0f;
    anim.repeatCount = 1.0f;
    anim.removedOnCompletion = YES;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    
    [imgViewBanner.layer addAnimation:anim forKey:@"position.x"];

    [imgViewBanner setImage:[UIImage imageNamed:AnimationImageName] ];
    
    

}

-(IBAction)URL:(id)sender
{
    NSString *url = @"http://www.dunkindonuts.com";
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:url]];
}


-(IBAction)close:(id)sender
{
    [UIView animateWithDuration:0.8 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self dismissViewControllerAnimated:YES completion:nil];
    }completion:NULL];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
