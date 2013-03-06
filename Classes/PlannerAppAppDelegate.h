//
//  PlannerAppAppDelegate.h
//  PlannerApp
//
//  Created by openxcell tech.. on 2/8/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//hello.....

#import <UIKit/UIKit.h>
#import "DAL.h"
@class PlannerAppViewController;

@interface PlannerAppAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    PlannerAppViewController *viewController;
    UINavigationController *navigationControllerIPhone;
    UINavigationController *navigationController;
    UINavigationController *navigationKeepMeSigned;
    
     BOOL isColor;
	NSMutableDictionary *dict;
    NSMutableArray *array;
    NSString *str;
	NSMutableArray *arrLocation;
    NSString *strLoginID;
	
    NSString *url;
    NSString *reminderText;
    NSString *str_mcid;
    DAL *dal;
    NSMutableDictionary *dictAdd;
    NSString *strAtid;
    int subTask;
    int tagFlag;
    
}
@property(nonatomic,assign)int tagFlag;
@property(nonatomic,retain)NSString *str_mcid;
@property (nonatomic,retain) NSString *reminderText;
@property(nonatomic,retain)NSString *url;
//@property(nonatomic,assign)int k;
@property(nonatomic,retain)NSMutableArray *arrLocation;
@property(nonatomic,retain) NSString *str;
@property(nonatomic,retain) NSString *strLoginID;
@property(nonatomic,retain) NSMutableArray *array;
@property(nonatomic,retain)NSMutableDictionary *dict;
@property(nonatomic,assign)BOOL isColor;
@property(nonatomic, retain) IBOutlet UIWindow *window;
@property(nonatomic, retain) IBOutlet PlannerAppViewController *viewController;
@property(nonatomic, retain) IBOutlet UINavigationController *navigationControllerIPhone;
@property(nonatomic,retain)IBOutlet UINavigationController *navigationKeepMeSigned;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

-(void)JSONAccept:(NSString *)response;
-(void) checkAndCreateDatabase;
extern NSString *kRemindMeNotificationDataKey;
@end

