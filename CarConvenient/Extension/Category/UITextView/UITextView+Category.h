//
//  UITextView+Category.h
//  SmileHelper
//
//  Created by 微笑吧阳光 on 2017/3/1.
//  Copyright © 2017年 www.imee.vc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface UITextView (Category)<UITextViewDelegate>

@property (nonatomic, strong) UITextView *placeHolderTextView;
/**
 *  @brief  占位符
 */
- (void)add_PlaceHolder:(NSString *)placeHolder;

/**
 *  @brief  当前选中的字符串范围
 *
 *  @return NSRange
 */
- (NSRange)selectedRange;
/**
 *  @brief  选中所有文字
 */
- (void)selectAllText;
/**
 *  @brief  选中指定范围的文字
 *
 *  @param range NSRange范围
 */
- (void)setSelectedRange:(NSRange)range;

// 用于计算textview输入情况下的字符数，解决实现限制字符数时，计算不准的问题
- (NSInteger)getInputLengthWithText:(NSString *)text;


@end
