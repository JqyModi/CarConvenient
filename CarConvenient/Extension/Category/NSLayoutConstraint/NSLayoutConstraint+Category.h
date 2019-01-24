//
//  NSLayoutConstraint+Category.h
//  CarConvenient
//
//  Created by Modi on 2019/1/22.
//  Copyright © 2019年 modi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

IB_DESIGNABLE
@interface NSLayoutConstraint (Category)
    @property (nonatomic, assign) IBInspectable BOOL adaptive;
@end

NS_ASSUME_NONNULL_END
