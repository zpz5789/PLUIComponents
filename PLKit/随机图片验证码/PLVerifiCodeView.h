//
//  PLVerifiCodeView.h
//  PLKit
//
//  Created by zpz on 2017/9/11.
//  Copyright © 2017年 BigRoc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PLVerifiCodeViewDelegate <NSObject>
- (void)plVerifiCodeViewDelegate;
@end

@interface PLVerifiCodeView : UIView
/// 指定一组验证码
@property (nonatomic, strong) NSArray<NSString *> *verifiCodes;
/// 指定一组背景颜色
@property (nonatomic, strong) NSArray<UIColor *> *bgColors;
/// 指定一组背景
@property (nonatomic, strong) NSArray<UIImage *> *bgImages;

/// 验证码文字旋转
@property (nonatomic, assign) BOOL rotation;
/// 验证码文字水平方向对齐
@property (nonatomic, assign) BOOL horizontalAlignment;
/// 验证码文字垂直方向对齐
@property (nonatomic, assign) BOOL verticalAlignment;
/// 文字颜色随机
@property (nonatomic, assign) BOOL verifiCodeColorRandom;



/// 验证码文本
@property (nonatomic, copy) NSString *verifiCodeText;
//  提示验证码文本
@property (nonatomic, copy) NSString *placeHolderCodeText;
/// 验证码字体
@property (nonatomic, strong) UIFont *verifiCodeFont;
/// 验证码颜色
@property (nonatomic, strong) UIColor *verifiCodeColor;
/// 验证码底纹宽度
@property (nonatomic, assign) CGFloat bottomShadingWidth;
/// 固定大小
@property (nonatomic, assign) CGSize fixedSize;
@property (nonatomic, weak) id <PLVerifiCodeViewDelegate> delegate;
@end

