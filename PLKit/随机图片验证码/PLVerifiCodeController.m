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
    PLVerifiCodeView *verView = [[PLVerifiCodeView alloc] initWithFrame:CGRectMake(100, 100, 80, 30)];
//    verView.verifiCodes = @[
//                            @"1354",
//                            @"abcd",
//                            @"xxdg",
//                            @"gsds",
//                            @"1589",
//                            @"xxxxxxds",
//                            @"燃s"
//                            ];
//    UIColor *color = [UIColor redColor];
////    verView.textColorRandom = YES;
//    verView.bgColors = @[color];
////    verView.bgImages = @[[UIImage imageNamed:@"屏幕快照 2017-09-11 21.31.13"]];
//    verView.verifiCodeFont = [UIFont boldSystemFontOfSize:20];
//    verView.verifiCodeText = @"acdb";
    [self.view addSubview:verView];

    NSDictionary *dict = @{
                           @"k2" : @"ssds",
                           @"K2" : @"sdfsf",
                           @"K1":@"ss",
                           @"a": @"aa",
                           @"b": @"aa",
                           @"c": @"aa",
                           @"胜多负少":@"哈哈"
    };
    
    NSString *arr =  [self formatUrlStringWithDictionary:dict urlEncode:YES keyToLower:YES];
    NSLog(@"%@",arr);
    
    NSString *test           = @"test";
    NSString *testUp         = [test uppercaseString];    //大写
    NSString *testUpFirst    = [test capitalizedString];  //开头大写，其余小写
    
    NSString *TEACHER           =@"TEACHER";
    NSString *TEACHERLower      = [TEACHER lowercaseString];    //小写
    NSString *TEACHERUpFirst    = [TEACHER capitalizedString];  //开头大写，其余小写

    // Do any additional setup after loading the view.
}

- (NSString *)formatUrlStringWithDictionary:(NSDictionary <NSString *, NSString*> *)dictionary urlEncode:(BOOL)encode
                                keyToLower:(BOOL)toLower
{
    NSMutableString *formatUrl = [NSMutableString string];
    NSArray *allKeys = [dictionary allKeys];
//    NSArray *allSorts = [dictionary allValues];
    // 对所有传入参数按照字段名的 ASCII 码从小到大排序（字典序）
    allKeys = [allKeys sortedArrayUsingComparator:^NSComparisonResult(NSString *  _Nonnull obj1, NSString *  _Nonnull obj2) {
        return - [obj2 compare:obj1];
    }];
    
    //拼接成字符串
    for (NSString *key in allKeys) {
        NSString *value = [dictionary objectForKey:key];
        NSString *tempKey;
        if (toLower) {
            tempKey = [key lowercaseString];
        } else {
            tempKey = key;
        }
        [formatUrl appendString:tempKey];
        [formatUrl appendString:@"="];
        if (encode) {
           value = [value stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
        [formatUrl appendString:value];
        if ([allKeys indexOfObject:key] != allKeys.count - 1) {
            [formatUrl appendString:@"&"];
        }
    }
    // 构造URL 键值对的格式
    return formatUrl;
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
