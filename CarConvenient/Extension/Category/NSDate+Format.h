//
//  NSDate+Format.h
//  ClothesMall
//
//  Created by 姚鸿飞 on 2017/5/17.
//  Copyright © 2017年 encifang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Format)


/**
 根据时间戳获得格式化的时间

 @param beTimeStr 时间戳
 @return return value description
 */
+ (NSString *)dateDistanceTimeWithBeforeTime:(NSString *)beTimeStr;

/**
 根据时间戳和格式获得格式化的时间
 
 @param beTimeStr 时间戳
 @return return value description
 */
+ (NSString *)dateDistanceTimeWithBeforeTime:(NSString *)beTimeStr format:(NSString *)format;

@end
