//
//  ViewController.m
//  demoEstimote
//
//  Created by Khushboo Sharma on 1/21/15.
//  Copyright (c) 2015 myMe. All rights reserved.
//

#import "ViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>
#import "ESTBeaconManager.h"
#import "NextViewController.h"
//#import <GPUImage/GPUImage.h>

@interface ViewController ()<ESTBeaconManagerDelegate>
{
    __weak IBOutlet UIView *comingView;
    __weak IBOutlet UIImageView *bannerImageView;
    __weak IBOutlet UIImageView *baseImageView;
    
    
    
        BOOL shouldPlayAnimationNear;
        BOOL shouldPlayAnimationImmidiate;
        BOOL shouldPlayAnimationFar;
        BOOL shouldPlayAnimationUnKnown;
}
@property (weak, nonatomic) IBOutlet UIImageView *moveImageView;

@property(nonatomic,strong)ESTBeacon *beacon;
@property(nonatomic,strong)ESTBeaconManager *beaconManager;
@property(nonatomic,strong)ESTBeaconRegion *beaconRegion;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//     [self animateAeroplane];
    
    shouldPlayAnimationNear = YES;
    shouldPlayAnimationImmidiate = YES;
    shouldPlayAnimationFar = YES;
    shouldPlayAnimationUnKnown = YES;
    
    
    comingView.hidden = YES;
//    comingView.layer.borderWidth = 2.0f;
//    comingView.layer.borderColor = [UIColor grayColor].CGColor;
//    comingView.layer.shadowColor = [UIColor grayColor].CGColor;
//    comingView.layer.shadowOpacity = 0.8;
//    comingView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
     //comingView.hidden = YES;
  
    
//    label = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 64.0f)];
//    label.textColor = [UIColor redColor];
    
//    [comingView addSubview:label];
//    [self.view addSubview:comingView];
   
    
    
    
    
//    [self moveToImage:_moveImageView duration:3.0 curve:UIViewAnimationCurveEaseInOut x:-500.0 y:-500.0];
   
    // Do any additional setup after loading the view, typically from a nib.
    //create ur UUID;
    NSUUID *uuId = [[NSUUID alloc]initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D"];
    
    //set up the beacon manager
    self.beaconManager = [[ESTBeaconManager alloc]init];
    self.beaconManager.delegate = self;
    
    //set up the beacon region
  //  self.beaconRegion = [[ESTBeaconRegion alloc]initWithProximityUUID:self.beacon.proximityUUID major:[self.beacon.major unsignedIntValue] minor:[self.beacon.minor unsignedIntValue] identifier:@"RegionIdentifier" secured:self.beacon.isSecured];
    
    NSLog(@"self.beacon.major:%u",self.beacon.major.unsignedIntValue);
    
    self.beaconRegion = [[ESTBeaconRegion alloc]initWithProximityUUID:uuId major:31337 minor:17604 identifier:@"RegionIdentifier"];
    
    NSLog(@"self.beacon.proximityUUID:- %@",self.beacon.proximityUUID);
    NSLog(@"self.beacon.major:%u",self.beacon.major.unsignedIntValue);
    
    //let us know when we will are enter or exit region
    self.beaconRegion.notifyOnEntry = YES;
    self.beaconRegion.notifyOnExit = YES;
    
    //start monitoring
    [self.beaconManager startMonitoringForRegion:self.beaconRegion];
  
    //start the ranging
    [self.beaconManager startRangingBeaconsInRegion:self.beaconRegion];
    
    //must have for ios8
    [self.beaconManager requestAlwaysAuthorization];
    
    
   
}


//-(void)moveToImage:(UIImageView *)image duration:(NSTimeInterval)duration curve:(int)curve x:(CGFloat)x y:(CGFloat)y
//{
//    
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:duration];
//    [UIView setAnimationCurve:curve];
//    [UIView setAnimationBeginsFromCurrentState:YES];
//    
//    CGAffineTransform transforms = CGAffineTransformMakeTranslation(x, y);
//    _moveImageView.transform = transforms;
//    
//    
//    [UIView commitAnimations];
//}
-(IBAction)closePopUp:(id)sender
{
    [UIView animateWithDuration:0.8 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        [comingView removeFromSuperview];
        
    }completion:NULL];
    
}



-(void)animateAeroplane
{
 
    [UIView animateWithDuration:0.0f animations:^{
       
//        _moveImageView.frame = CGRectMake(100.0f, 100.0f, _moveImageView.frame.size.width, _moveImageView.frame.size.height);
        
        _moveImageView.alpha = 1.0f;
         _moveImageView.center = CGPointMake(_moveImageView.center.x,_moveImageView.center.y + 500.0f);
    }completion:^(BOOL finished)
     {
      
         [UIView animateWithDuration:0.3f animations:^{
            
             _moveImageView.alpha = 1.0f;
             
             _moveImageView.center = CGPointMake(_moveImageView.center.x, _moveImageView.center.y - 500.0f);
         }
                          completion:^(BOOL finished)
          {
              
          
         }];
     }];
}


-(void)perform
{
    
   // [baseImageView setImage:[UIImage imageNamed:BgImageName]];
    
    
   NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(bottomBanner) userInfo:nil repeats:NO];
    NSLog(@"timer%@",timer);
//    [self.imageviewBeacon stopAnimating];
    
//    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    NextViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:@"NextViewController"];
//    
//    [self presentViewController:vc animated:YES completion:nil];
    
//    CGPoint point = CGPointMake(self.imageviewBeacon.center.x, self.imageviewBeacon.center.y);//self.imageviewBeacon.center;
//    
//    //CGPoint startPos = self.imageviewBeacon.layer.position;
//    CGPoint endPos = CGPointMake(point.x + 250, point.y);
//    
//    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position.x"];
//    anim.fromValue = [NSValue valueWithCGPoint:point];//[NSNumber numberWithFloat:point.x];
//    anim.toValue =  [NSValue valueWithCGPoint:endPos];//[NSNumber numberWithFloat:point.x];
//    anim.duration = 10.0f;
//    anim.repeatCount = 1.0f;
//    anim.removedOnCompletion = YES;
//    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
//    
//    
//    [self.imageviewBeacon.layer addAnimation:anim forKey:@"position.x"];
//    
//    
//    self.imageviewBeacon.layer.position = endPos;//CGPointMake(point.x+10.0 ,point.y);
//    [self.imageviewBeacon stopAnimating];
    
}


-(void)bottomBanner
{
    
    [bannerImageView stopAnimating];
    
    CGPoint point = CGPointMake(bannerImageView.center.x, bannerImageView.center.y);//self.imageviewBeacon.center;
    
    //CGPoint startPos = self.imageviewBeacon.layer.position;
    CGPoint endPos = CGPointMake(point.x + 350, point.y);
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position.x"];
    anim.fromValue = [NSValue valueWithCGPoint:point];//[NSNumber numberWithFloat:point.x];
    anim.toValue =  [NSValue valueWithCGPoint:endPos];//[NSNumber numberWithFloat:point.x];
    anim.duration = 10.0f;
    anim.repeatCount = 1.0f;
    anim.removedOnCompletion = YES;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    
    [bannerImageView.layer addAnimation:anim forKey:@"position.x"];
    
    //[imgViewBanner setImage:[UIImage imageNamed:AnimationImageName] ];
    
    
      [bannerImageView stopAnimating];
}

-(IBAction)URL:(id)sender
{
    NSString *url = @"http://www.dunkindonuts.com";
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:url]];
}



#pragma mark - delegate
//check for region failure
-(void)beaconManager:(ESTBeaconManager *)manager monitoringDidFailForRegion:(ESTBeaconRegion *)region withError:(NSError *)error
{
    NSLog(@"Region did fail : Manager:%@ Region:%@ Error:%@",manager,region,error);
}

-(void)beaconManager:(ESTBeaconManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    NSLog(@"status:%d",status);
}


-(void)beaconManager:(ESTBeaconManager *)manager didEnterRegion:(ESTBeaconRegion *)region
{
    //adding custom local notification to be presented
    UILocalNotification *notification = [[UILocalNotification alloc]init];
    notification.alertBody = @"Welcome to DUNKIN DONUTS. More offers waiting for you :)";
    notification.soundName = UILocalNotificationDefaultSoundName;
    NSLog(@"you entered");
    [[UIApplication sharedApplication]presentLocalNotificationNow:notification];
}

-(void)beaconManager:(ESTBeaconManager *)manager didExitRegion:(ESTBeaconRegion *)region
{
    UILocalNotification *notification = [[UILocalNotification alloc]init];
    notification.alertBody = @"Thank you for coming DUNKIN DONUTS. More offers always waiting for you :)";
    NSLog(@"you exited");
    [[UIApplication sharedApplication]presentLocalNotificationNow:notification];
}


-(void)beaconManager:(ESTBeaconManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(ESTBeaconRegion *)region
{
    //[self blurWithCoreImage:[UIImage imageNamed:@"logo.png"]];
    
//    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    
      if (beacons.count > 0) {
        
        ESTBeacon *firstBeacon = [beacons objectAtIndex:0];
      switch (firstBeacon.proximity) {
            
              
                          
          case CLProximityUnknown:
          {
              NSLog(@"Unknown");
              
              comingView.hidden = NO;
              
//              [UIView animateWithDuration:0.4 delay:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//                  
//                  temp = 0;
//                  comingView.alpha = 1.0;
              
                baseImageView.image = [UIImage imageNamed:@"FarBGImage.png"];
                bannerImageView.image = [UIImage imageNamed:@"FarImg.png"];
                [self perform];

//              
//              shouldPlayAnimationNear  = YES;
//              shouldPlayAnimationImmidiate = YES;
//              shouldPlayAnimationFar = YES;
//              
//              if (shouldPlayAnimationUnKnown) {
//                  
//                  [self perform];
//                  shouldPlayAnimationUnKnown = NO;
//              }
//
              
              
              
              
              
              
//              }completion:^(BOOL finished){
//                  
//              }];
          }
              
           //   [self showPopUp];
            
//            baseView.hidden = NO;
          //  comingView.hidden = NO;
//            btnClose.hidden = NO;
              
              
//              self.labelBeacon.textColor = [UIColor redColor];
//              self.imageviewBeacon.image = [UIImage imageNamed:@"far_img.png"];
//              //return @"Unknown";
              break;

          case CLProximityFar:
          {
              NSLog(@"far");
              
//              [UIView animateWithDuration:0.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//                  
//                  comingView.alpha = 1.0;
//                  
//              }completion:^(BOOL finished){
//                  
//              }];
//              temp = 0;
//              comingView.alpha = 1.0;
              comingView.hidden = NO;
              
              baseImageView.image = [UIImage imageNamed:@"FarBGImage.png"];
              bannerImageView.image = [UIImage imageNamed:@"FarImg.png"];
              [self perform];
//
//              shouldPlayAnimationNear = YES;
//              shouldPlayAnimationImmidiate = YES;
//              shouldPlayAnimationUnKnown = YES;
//              
//              if (shouldPlayAnimationFar) {
              
              
//              [userDefault setValue:@"FarBGImage" forKey:@"BGImage"];
//              [userDefault setValue:@"FarImg" forKey:@"AnimationImage"];
//              
//              [self perform];
//                  shouldPlayAnimationFar = NO;
//              }
//
    }

              
//              [self showPopUp];

//              self.labelBeacon.textColor = [UIColor orangeColor];
//              self.imageviewBeacon.image = [UIImage imageNamed:@"far_img.png"];

//              baseView.hidden = NO;
//              comingView.hidden = NO;
//              btnClose.hidden = NO;
//              

             // return @"Far";
              break;
          case CLProximityImmediate:
          {
              NSLog(@"Immediate");

//              self.imageviewBeacon.image = [UIImage imageNamed:@"AboutUs.png"];
//              
//              shouldPlayAnimationNear = YES;
//              shouldPlayAnimationNear = YES;
//              shouldPlayAnimationUnKnown = YES;
//              
//              if (shouldPlayAnimationImmidiate) {
              
              comingView.hidden = NO;
              baseImageView.image = [UIImage imageNamed:@"ImmediateBGImage.png"];
              bannerImageView.image = [UIImage imageNamed:@"ImmediateImg.png"];
              [self perform];

//                  [userDefault setValue:@"ImmediateBGImage" forKey:@"BGImage"];
//                  [userDefault setValue:@"ImmediateImg" forKey:@"AnimationImage"];
////
//                  [self perform];
//                  shouldPlayAnimationImmidiate = NO;
//              }
          }

             //              [UIView animateWithDuration:0.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//                  
//                  comingView.alpha = 1.0;
//                  
//              }completion:^(BOOL finished){
//                  
//              }];
              
//                  comingView.alpha = 1.0;
//               self.imageviewBeacon.image = [UIImage imageNamed:@"AboutUs.png"];          }
              
    //          [self showPopUp];

//              self.labelBeacon.textColor = [UIColor purpleColor];
//              self.imageviewBeacon.image = [UIImage imageNamed:@"immediate_img.png"];
              
           
              //return @"Immediate";
              break;
          case CLProximityNear:
          {
              NSLog(@"Near");
//                [self.imageviewBeacon stopAnimating];
////              comingView.alpha = 1.0;
//             self.imageviewBeacon.image = [UIImage imageNamed:@"near_imag.png"];
//              
//              shouldPlayAnimationUnKnown = YES;
//              shouldPlayAnimationImmidiate = YES;
//              shouldPlayAnimationFar = YES;
//              
//              if (shouldPlayAnimationNear) {
              
              comingView.hidden = NO;
              baseImageView.image = [UIImage imageNamed:@"nearBGImage.png"];
              bannerImageView.image = [UIImage imageNamed:@"NearImg.png"];
              [self perform];
//
//              [userDefault setValue:@"nearBGImage" forKey:@"BGImage"];
//              [userDefault setValue:@"NearImg" forKey:@"AnimationImage"];
//              
//
//              [self perform];
////                  shouldPlayAnimationNear = NO;
//              }
//              
            
////
//              [self.imageviewBeacon.layer removeAllAnimations];
//              
//              CATransition *transition = [CATransition animation];
////              transition.duration = 10.0;
//              transition.type = kCATransitionReveal;
//              transition.subtype = kCATransitionFromLeft;
//              [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//              [self.imageviewBeacon.layer addAnimation:transition forKey:nil];
              //
//
//              
              
              //////////
              
              
              
        
              
//              self.imageviewBeacon.frame = CGRectMake(0, 173, 562, 407);
//              
//              [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
//                  
////                  comingView.alpha = 1.0;
//                  self.imageviewBeacon.image = [UIImage imageNamed:@"near_imag.png"];
//                  [self.imageviewBeacon setFrame: CGRectMake(150, 173, 562, 407)];
//                  
//                  
//              }completion:nil];
////
//               [self.imageviewBeacon.layer removeAllAnimations];
//              
              
              //////

              
              
//              [comingView addSubview:self.imageviewBeacon];
              
           
//              if (temp == 0) {
              
            
//              [UIView animateWithDuration:8.0f delay:8.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//                  
//                  comingView.alpha = 1.0;
////                  self.imageviewBeacon.center = CGPointMake( self.imageviewBeacon.center.x, self.imageviewBeacon.center.y);
//                  self.imageviewBeacon.image = [UIImage imageNamed:@"near_imag.png"];
////                   comingView.alpha = 0.0;
////                  
////                  temp = 1;
//                  
//              }completion:^(BOOL finished){
//                  
//                  
//                 
//              [UIView animateWithDuration:3.0f delay:8.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
////
//                 // [comingView removeFromSuperview];
//                   comingView.alpha = 0.7f;
////                      self.imageviewBeacon.center = CGPointMake(self.imageviewBeacon.center.x,self.imageviewBeacon.center.y - 100.0f);
////                      self.imageviewBeacon.image = [UIImage imageNamed:@"AboutUs.png"];
////                      
////                      
////                      //                       comingView.center = CGPointMake(comingView.center.x, comingView.center.y - 150.0f);
//              }completion:^(BOOL finished)
//                   {
//                       
//                       
//                   }];
//
//              }];
//
              //}
              
//              [UIView animateWithDuration:0.0f animations:^{
//                  
//                  //        _moveImageView.frame = CGRectMake(100.0f, 100.0f, _moveImageView.frame.size.width, _moveImageView.frame.size.height);
//                  
//                  comingView.alpha = 1.0;
//                self.imageviewBeacon.center = CGPointMake(self.imageviewBeacon.center.x,self.imageviewBeacon.center.y - 150.0f);
//                  self.imageviewBeacon.image = [UIImage imageNamed:@"AboutUs.png"];
//                  
//                  
//                  //                  _moveImageView.alpha = 0.0f;
//                  //                  _moveImageView.center = CGPointMake(_moveImageView.center.x,_moveImageView.center.y + 500.0f);
//              }completion:^(BOOL finished)
//               {
//                   
//                   [UIView animateWithDuration:3.0f animations:^{
//                       
//                       comingView.alpha = 1.0f;
//                        self.imageviewBeacon.center = CGPointMake(self.imageviewBeacon.center.x,self.imageviewBeacon.center.y - 150.0f);
//                       self.imageviewBeacon.image = [UIImage imageNamed:@"AboutUs.png"];
//                       
//                       
////                       comingView.center = CGPointMake(comingView.center.x, comingView.center.y - 150.0f);
//                   }
//                                    completion:^(BOOL finished)
//                    {
//                        
//                        
//                    }]
//               }];
//              
//
//
              
                                    
              
                  
        }
              
//              comingView.hidden = YES;
//              [userDefault synchronize];
              
      //        [self showPopUp];

//              self.labelBeacon.textColor = [UIColor greenColor];
//              self.imageviewBeacon.image = [UIImage imageNamed:@"near_imag.png"];
            
                      //return @"Near";
              break;
                  default:
              break;
      }
//          
//          baseView.hidden = YES;
//          comingView.hidden = YES;
//          btnClose.hidden = YES;
//       label.text = [self textForProximity:firstBeacon.proximity];
       // self.imageviewBeacon.image = [self ImageForProximity:firstBeacon.proximity];
    }
}

-(NSString *)textForProximity:(CLProximity)proximity
{
    switch (proximity) {
        case CLProximityFar:
            NSLog(@"far");
           self.labelBeacon.textColor = [UIColor blackColor];
            self.labelBeacon.text = @"FAR";
            
//            self.imageviewBeacon.image = [UIImage imageNamed:@"far_img.png"];
            return @"Far";
            break;
        case CLProximityImmediate:
            NSLog(@"Immediate");
            
            self.labelBeacon.textColor = [UIColor blackColor];
            self.labelBeacon.text = @"Immediate";

//            self.labelBeacon.textColor = [UIColor purpleColor];
//            self.imageviewBeacon.image = [UIImage imageNamed:@"immediate_img.png"];
            return @"Immediate";
            break;
        case CLProximityNear:
            NSLog(@"Near");
            self.labelBeacon.textColor = [UIColor blackColor];
            self.labelBeacon.text = @"Near";
            
//            self.labelBeacon.textColor = [UIColor greenColor];
//            self.imageviewBeacon.image = [UIImage imageNamed:@"near_imag.png"];
            return @"Near";
            break;
        case CLProximityUnknown:
            NSLog(@"Unknown");
//             self.labelBeacon.textColor = [UIColor redColor];
//            self.imageviewBeacon.image = [UIImage imageNamed:@"far_img.png"];
            return @"Unknown";
            break;
        default:
            break;
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
