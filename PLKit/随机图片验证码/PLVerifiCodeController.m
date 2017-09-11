//
//  PLVerifiCodeController.m
//  PLKit
//
//  Created by zpz on 2017/9/11.
//  Copyright © 2017年 BigRoc. All rights reserved.
//

#import "PLVerifiCodeController.h"
#import "PLVerifiCodeView.h"
@interface PLVerifiCodeController ()

@end

@implementation PLVerifiCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    PLVerifiCodeView *verView = [[PLVerifiCodeView alloc] initWithFrame:CGRectMake(100, 100, 100, 30)];
//    verView.verifiCodes = @[
//                            @"1354",
//                            @"abcd",
//                            @"xxdg",
//                            @"gsds",
//                            @"1589",
//                            @"xxx",
//                            @"燃"
//                            ];
//    UIColor *color = [UIColor redColor];
////    verView.textColorRandom = YES;
//    verView.bgColors = @[color];
////    verView.bgImages = @[[UIImage imageNamed:@"屏幕快照 2017-09-11 21.31.13"]];
//    verView.verifiCodeFont = [UIFont boldSystemFontOfSize:20];
//    verView.verifiCodeText = @"acdb";
    [self.view addSubview:verView];

    
    // Do any additional setup after loading the view.
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
