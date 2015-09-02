//
//  EnvironmentManager.h
//  EnvironmentConfiguration
//
//  Created by Hufei on 15/9/1.
//  Copyright (c) 2015年 Hufei. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Post a Noticatification with this name to switch the Environment
 */
extern NSString *const PARSSwitchEnvironmentNotification;
extern NSString *const PARSEnvironmentUserInfoKey;
@interface EnvironmentManager : NSObject

+ (NSString *)SERVER_IP;
+ (NSString *)SALES_HOST;
+ (NSString *)DOWN_APP_URL;
+ (NSString *)TalkingDataKey;

@end
