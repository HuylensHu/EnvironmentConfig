//
//  EnvironmentManager.m
//  EnvironmentConfiguration
//
//  Created by Hufei on 15/9/1.
//  Copyright (c) 2015年 Hufei. All rights reserved.
//
#define Config_File_Path   [NSHomeDirectory() stringByAppendingPathComponent:@"EnvironmentConfig.plist"]

#import "EnvironmentManager.h"
@interface EnvironmentManager()

@property (nonatomic, strong) NSString *serverIP;
@property (nonatomic, strong) NSString *downloadURL;
@property (nonatomic, strong) NSString *salesHost;
@property (nonatomic, strong) NSString *talkDataConfigKey;

@end

NSString *const PARSSwitchEnvironmentNotification = @"PARSSwitchEnvironmentNotification";
NSString *const PARSEnvironmentUserInfoKey = @"PARSEnvironmentUserInfoKey";
static NSString *const configFilePath = @"config.plist";
static NSString *const serverIPKey = @"serverIPKey";
static NSString *const downloadURLKey = @"downloadURLKey";
static NSString *const salseHostKey = @"salseHostKey";
static NSString *const talkDataKey = @"talkDataKey";

static EnvironmentManager *__manager;
@implementation EnvironmentManager
+(void)load{
    [super load];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __manager = [[EnvironmentManager alloc] init];
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:Config_File_Path];
        if (!dic){
            NSMutableDictionary *defaultConfig = [NSMutableDictionary dictionary];
            [defaultConfig setObject:@"defaultServerIP" forKey:serverIPKey];
            [defaultConfig setObject:@"defaultValue" forKey:downloadURLKey];
            [defaultConfig setObject:@"defaultValue" forKey:salseHostKey];
            [defaultConfig setObject:@"defaultValue" forKey:talkDataKey];
            [defaultConfig writeToFile:Config_File_Path atomically:YES];
        }
    });
}
- (instancetype)init{
    self = [super init];
    if (self) {
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:Config_File_Path];
        self.serverIP = dic[serverIPKey];
        self.downloadURL = dic[downloadURLKey];
        self.salesHost = dic[salseHostKey];
        self.talkDataConfigKey = dic[talkDataKey];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(switchEnvironment:) name:PARSSwitchEnvironmentNotification object:nil];
    }
    return self;
}
+ (NSString *)SERVER_IP{
   return __manager.serverIP;
}
+ (NSString *)SALES_HOST{
    return __manager.salesHost;
}
+ (NSString *)DOWN_APP_URL{
    return __manager.downloadURL;
}
+ (NSString *)TalkingDataKey{
    return __manager.talkDataConfigKey;
}
- (void)switchEnvironment:(NSNotification *)sender {
    NSDictionary *dic = sender.userInfo;
    NSInteger environment = [dic[PARSEnvironmentUserInfoKey] integerValue];
    switch (environment) {
        case 1:
        {
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:Config_File_Path];
            dic[serverIPKey] = @"http://wwww.baidu.com";
            [dic writeToFile:Config_File_Path atomically:YES];
        }

            break;
        case 2:
        {
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:Config_File_Path];
            dic[serverIPKey] = @"http://wwww.google.com";
            [dic writeToFile:Config_File_Path atomically:YES];

        }
            break;
        default:
            //TODO: DefaultValue
            break;
    }
    //TODO: crash
    exit(EXIT_SUCCESS);
}


@end
