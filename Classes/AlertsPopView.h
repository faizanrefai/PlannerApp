//
//  AlertsPopView.h
//  PlannerApp
//
//  Created by openxcell tech.. on 2/13/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "DAL.h"
@interface AlertsPopView : UIViewController<UITextFieldDelegate>
{
	IBOutlet UIButton *btn_rnone;
	IBOutlet UIButton *btn_r5min;
	IBOutlet UIButton *btn_r15min;
	IBOutlet UIButton *btn_r30min;
	IBOutlet UIButton *btn_r1hr;
	IBOutlet UIButton *btn_r1day;
	
	IBOutlet UIButton *btn_ok;
	IBOutlet UIButton *day;
	IBOutlet UIButton *week;
	IBOutlet UIButton *month;	
	
	IBOutlet UITextField *date_text;
	IBOutlet UIToolbar *tool;
	IBOutlet UIDatePicker *picker;
    NSDate *selectedDate;
    int setTime;
    NSString *strTaskName;
    NSString *strMID;
    NSString *strSID;
    DAL *dal;
    
 
}
@property(nonatomic,retain)NSString *strSID;
@property(nonatomic,retain) NSString *strMID;
@property(nonatomic,retain) NSString *strTaskName;
-(IBAction)clickOnNone:(id)sender;
-(IBAction)clickOn5min:(id)sender;
-(IBAction)clickOn15min:(id)sender;
-(IBAction)clickOn30min:(id)sender;
-(IBAction)clickOn1hr:(id)sender;
-(IBAction)clickOn1day:(id)sender;

-(IBAction)clickOnok:(id)sender;
-(IBAction)clickOnday:(id)sender;
-(IBAction)clickOnweek:(id)sender;
-(IBAction)clickOnmonth:(id)sender;

-(IBAction)showdate:(id)sender;
-(IBAction)clickOnDone:(id)sender;


-(IBAction)changeTaskArr:(id)sender;
- (void)showReminder:(NSString *)text;
@end
