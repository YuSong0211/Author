//
//  NSDate+Extension.m
//  Douyin
//
//  Created by Qiao Shi on 2018/7/30.
//  Copyright © 2018年 Qiao Shi. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)


- (NSDateComponents *)deltaWithNow
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:self toDate:[NSDate date] options:0];

}

- (NSString *)formatTime:(NSTimeInterval)timeInterval {
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitHour fromDate:date];
    CGFloat hour = components.hour;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    if ([date isToday]) {
        if([date isJustNow]) {
            NSDateComponents *cmp = [date deltaWithNow];
            if (cmp.hour >= 1) {
                return [NSString stringWithFormat:@"%ld小时之前",(long)cmp.hour];
            }else if (cmp.minute > 1) {
                return [NSString stringWithFormat:@"%ld分钟之前",(long)cmp.minute];
            }
            return @"刚刚";
        }else {
            if ([self isHasAMPM]) { //12小时
                if (hour > 12) {
                    formatter.dateFormat = @"下午 hh:mm";
                }else {
                    formatter.dateFormat = @"上午 hh:mm";
                }
            }else {
                formatter.dateFormat = @"HH:mm";
            }
            return [formatter stringFromDate:date];
        }
    }else{
        if ([date isYesterday]) {
            if ([self isHasAMPM]) { //12小时
                if (hour > 12) {
                    formatter.dateFormat = @"昨天 下午hh:mm";
                }else {
                    formatter.dateFormat = @"昨天 上午hh:mm";
                }
            }else {
                formatter.dateFormat = @"昨天HH:mm";
            }
            return [formatter stringFromDate:date];
        }
//        else if ([date isCurrentWeek]){
//            formatter.dateFormat = [NSString stringWithFormat:@"%@%@",[date dateToWeekday],@"HH:mm"];
//            return [formatter stringFromDate:date];
//        }
        else{
            if([date isCurrentYear]) {
                if ([self isHasAMPM]) { //12小时
                    if (hour > 12) {
                        formatter.dateFormat = @"MM-dd  下午hh:mm";
                    }else {
                        formatter.dateFormat = @"MM-dd  上午hh:mm";
                    }
                }else {
                    formatter.dateFormat = @"MM-dd  HH:mm";
                }
            }else {
                if ([self isHasAMPM]) { //12小时
                    if (hour > 12) {
                        formatter.dateFormat = @"yyyy-MM-dd  下午hh:mm";
                    }else {
                        formatter.dateFormat = @"yyyy-MM-dd  上午hh:mm";
                    }
                }else {
                    formatter.dateFormat = @"yyyy-MM-dd  HH:mm";
                }
                
            }
            return [formatter stringFromDate:date];
        }
    }
    return nil;
}

- (BOOL)isJustNow {
    NSTimeInterval now = [[NSDate new] timeIntervalSince1970];
    return fabs(now - self.timeIntervalSince1970) < 60 * 1 ? YES : NO;
}

- (BOOL)isCurrentWeek {
    NSDate *nowDate = [[NSDate date] dateFormatYMD];
    NSDate *selfDate = [self dateFormatYMD];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    return cmps.day <= 7;
}

- (BOOL)isCurrentYear {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitWeekday | NSCalendarUnitMonth | NSCalendarUnitYear;
    NSDateComponents *nowComponents = [calendar components:unit fromDate:[NSDate date]];
    NSDateComponents *selfComponents = [calendar components:unit fromDate:self];
    return selfComponents.year == nowComponents.year;
}

- (NSString *)dateToWeekday {
    NSArray *weekdays = [NSArray arrayWithObjects: @"", @"星期天", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:self];
    return [weekdays objectAtIndex:theComponents.weekday];
    
}

- (BOOL)isToday {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear ;
    NSDateComponents *nowComponents = [calendar components:unit fromDate:[NSDate date]];
    NSDateComponents *selfComponents = [calendar components:unit fromDate:self];
    return (selfComponents.year == nowComponents.year) && (selfComponents.month == nowComponents.month) && (selfComponents.day == nowComponents.day);
}

- (BOOL)isYesterday {
    NSDate *nowDate = [[NSDate date] dateFormatYMD];
    NSDate *selfDate = [self dateFormatYMD];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    return cmps.day == 1;
}

- (NSDate *)dateFormatYMD {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *selfStr = [fmt stringFromDate:self];
    return [fmt dateFromString:selfStr];
}

//yes 12小时  no  24小时
- (BOOL)isHasAMPM {
    NSString *formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
    NSRange containsA = [formatStringForHours rangeOfString:@"a"];
    BOOL hasAMPM = containsA.location != NSNotFound;
    return hasAMPM;
}

@end
