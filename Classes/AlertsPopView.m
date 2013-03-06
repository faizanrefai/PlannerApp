//
//  AlertsPopView.m
//  PlannerApp
//
//  Created by openxcell tech.. on 2/13/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "AlertsPopView.h"


@implementation AlertsPopView
@synthesize strTaskName,strMID,strSID;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.contentSizeForViewInPopover=CGSizeMake(320, 320);
   
	tool.hidden= TRUE;
	picker.hidden = TRUE;
	NSDate *now = [NSDate date];
	
    [picker setDate:now animated:YES];
    UIBarButtonItem *doneButton=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneFolder)];
    
    
    [self.navigationItem setRightBarButtonItem:doneButton];
    [doneButton release];
    
    UIBarButtonItem *canButton=[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    
    
    [self.navigationItem setLeftBarButtonItem:canButton];
    [canButton release];
	 dal=[[DAL alloc] initDatabase:@"Planner.sqlite"];
	
}
-(void)doneFolder{
    
    
    UIApplication *app = [UIApplication sharedApplication];
    [app cancelAllLocalNotifications];
    NSArray *eventArray = [app scheduledLocalNotifications];
    NSMutableArray *arrdd=[[NSMutableArray alloc] init];
    NSString *uidtodelete,*ID;
    if(strMID){
        arrdd=[dal SelectWithStar:@"tblMainTask" withCondition:@"mtid=" withColumnValue:[NSString stringWithFormat:@"%@",strMID]];
        ID=[[arrdd objectAtIndex:0] valueForKey:@"mtid"];
    }
    else{
        arrdd=[dal SelectWithStar:@"tblSubTask" withCondition:@"stid=" withColumnValue:[NSString stringWithFormat:@"%@",strSID]];
        ID=[[arrdd objectAtIndex:0] valueForKey:@"stid"];
    }
    uidtodelete=[[arrdd objectAtIndex:0] valueForKey:@"alertTime"];
    
    for (int i=0; i<[eventArray count]; i++)
    {
        
        UILocalNotification* oneEvent = [eventArray objectAtIndex:i];
        NSDictionary *userInfoCurrent = oneEvent.userInfo;
        NSLog(@"%@",userInfoCurrent);
        NSString *uid=[NSString stringWithFormat:@"%@",[userInfoCurrent valueForKey:@"FIRE_TIME_KEY"]];
        NSString *star=[NSString stringWithFormat:@"%@",[userInfoCurrent valueForKey:@"NOTIFICATION_MESSAGE_KEY"]];
        NSLog(@"%@",ID);
        NSLog(@"%@",star);
        NSLog(@"%@",uidtodelete);
        NSLog(@"%@",uid);
        if ([uid isEqualToString:uidtodelete] && [ID intValue]==[star intValue] )
        {
            //Cancelling local notification
            [app cancelLocalNotification:oneEvent];
            break;
        }
    }

    
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    [dict setObject:[NSString stringWithFormat:@"%@",date_text.text] forKey:@"alertTime"];
    if(strMID)
    {
        [dal updateRecord:dict forID:@"mtid=" inTable:@"tblMainTask" withValue:[NSString stringWithFormat:@"%@",strMID]];
    }
    else{
        [dal updateRecord:dict forID:@"stid=" inTable:@"tblSubTask" withValue:[NSString stringWithFormat:@"%@",strSID]];
    }
        
    Class cls = NSClassFromString(@"UILocalNotification");
	if (cls != nil) {
		
		UILocalNotification *notif = [[cls alloc] init];
		
		NSDate *stDate = [NSDate dateWithTimeInterval:0 sinceDate:selectedDate];
		NSLog(@"%@",stDate);
		
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
        if(setTime==1){
            [offsetComponents setDay:1];
        }
        else{
            [offsetComponents setMinute:setTime];
        }
        // note that I'm setting it to -1
        NSDate *endOfWorldWar3 = [gregorian dateByAddingComponents:offsetComponents toDate:stDate options:0];
        NSLog(@"%@", endOfWorldWar3);
        
		
		
		NSDateFormatter *dtForm = [[NSDateFormatter alloc] init];
		[dtForm setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
		[dtForm setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
		
		
		//date = [dtForm dateFromString:endTime];
		NSLog(@"%@",endOfWorldWar3);
		
		
	    [notif setFireDate:endOfWorldWar3];
		notif.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
        NSLog(@"%@",strTaskName);
		notif.alertBody = [NSString stringWithFormat:@"%@",strTaskName];
		notif.alertAction = @"Show me";
		notif.soundName = UILocalNotificationDefaultSoundName;
		notif.applicationIconBadgeNumber = 1;
		
        //		NSDictionary *userDict = [NSDictionary dictionaryWithObject:@"reminder from planner"
        //                                                             forKey:@"kRemindMeNotificationDataKey"];
        NSDictionary *userDict;
        if(strSID){
        userDict = [NSDictionary dictionaryWithObjectsAndKeys:date_text.text,@"FIRE_TIME_KEY",strSID,@"NOTIFICATION_MESSAGE_KEY",nil];
        }
        else{
            userDict = [NSDictionary dictionaryWithObjectsAndKeys:date_text.text,@"FIRE_TIME_KEY",strMID,@"NOTIFICATION_MESSAGE_KEY",strTaskName,@"remTitle",nil];
        }
        
        
        
		notif.userInfo = userDict;
		
		[[UIApplication sharedApplication] scheduleLocalNotification:notif];
		[notif release];
	}
    
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)cancel
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    
    NSCalendar *gregorian=[[NSCalendar alloc] initWithCalendarIdentifier: NSGregorianCalendar];
	[gregorian setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"IST"]]; 
	//NSDateComponents *timeZoneComps=[[NSDateComponents alloc] init]; 
	//[timeZoneComps setHour:16];
	//specify whatever day, month, and year is appropriate
	
	tool.frame=CGRectMake(0, 70, 320, 44);
	
	
	
	//datePicker = [[UIDatePicker alloc] init];
	NSTimeZone *timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
	
	[picker setDate:[NSDate date]];
	[picker setTimeZone:timeZone];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	[textField resignFirstResponder];
	tool.hidden = FALSE;
	picker.hidden = FALSE;
	
}
- (void)textFieldDidEndEditing:(UITextField *)textField 
{
	[textField resignFirstResponder];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	tool.hidden = YES;
	picker.hidden=YES;
	[textField resignFirstResponder];
	//[to resignFirstResponder];
	return YES;	
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	//[to resignFirstResponder];
	return NO;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	tool.hidden =YES;
	picker.hidden=YES;
	[date_text resignFirstResponder];
}


#pragma mark IBOutlet


-(IBAction)showdate:(id)sender
{
	[date_text resignFirstResponder];
    NSDate *selected = [picker date];
    selectedDate=[picker date];
    date_text.text = [NSString stringWithFormat:@"%@",selected];
    
}

-(IBAction)clickOnDone:(id)sender
{
	[date_text resignFirstResponder];
	tool.hidden = TRUE;
	picker.hidden = TRUE;
    //[[UIApplication sharedApplication] cancelAllLocalNotifications];
    
	
}
-(IBAction)changeTaskArr:(id)sender{
  
    [date_text resignFirstResponder];
    NSDate *selected = [picker date];
    selectedDate=[picker date];
    date_text.text = [NSString stringWithFormat:@"%@",selected];
	

}
- (void)showReminder:(NSString *)text {
	NSLog(@"text is %@",text);
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Reminder" 
                                                        message:text delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
	[alertView show];
	[alertView release];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
