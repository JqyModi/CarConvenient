//
//  UINavigationController+Animation.h
//  SmileHelper
//
//  Created by 微笑吧阳光 on 2016/3/1.
//  Copyright © 2016年 www.imee.vc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (Animation)

- (void)pushViewController:(UIViewController *)controller withTransition:(UIViewAnimationTransition)transition;

- (UIViewController *)popViewControllerWithTransition:(UIViewAnimationTransition)transition;

@end
