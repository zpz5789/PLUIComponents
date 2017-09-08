//
//  SnapViewController.m
//  PLKit
//
//  Created by zpz on 2017/8/30.
//  Copyright © 2017年 BigRoc. All rights reserved.
//

#import "SnapViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
@interface SnapViewController ()
- (IBAction)btnClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *showImageView;

@end

@implementation SnapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    UIView *view1 = [[UIView alloc] init];
//    self.showImageView.contentMode = UIViewContentModeScaleToFill;
    // Do any additional setup after loading the view.
}



-(void)captureImageFromView1:(UIView *)view{

    UIView *view1 = [view resizableSnapshotViewFromRect:CGRectMake(0, 200, 300, 300) afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
    view1.backgroundColor = [UIColor greenColor];
    [self.navigationController.view addSubview:view1];
    NSLog(@"%@",self.view.subviews);
    [self.navigationController.view bringSubviewToFront:view1];
}


/**
    Method1：
*/
-(UIImage *)captureImageFromView0:(UIView *)view{
    
    UIGraphicsBeginImageContextWithOptions(self.view.frame.size,NO,  [UIScreen mainScreen].scale);
    
//    [[UIColor clearColor] setFill];
//    
//    [[UIBezierPath bezierPathWithRect:self.view.bounds] fill];
//
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [self.navigationController.view.layer renderInContext:ctx];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
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

- (IBAction)btnClick:(UIButton *)sender {
    
    [self  captureImageFromView1:self.view];
    
//    UIImage *image =  [self captureImageFromView:self.view];
//    NSLog(@"%@",image);
//    self.showImageView.image = image;
//    ALAssetsLibrary * library = [ALAssetsLibrary new];
//    
//    NSData * data = UIImageJPEGRepresentation(image, 1.0);
//    
//    [library writeImageDataToSavedPhotosAlbum:data metadata:nil completionBlock:nil];
    
}
@end
