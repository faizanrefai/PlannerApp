//
//  DelegatePopView.h
//  PlannerApp
//
//  Created by openxcell tech.. on 2/11/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "PlannerAppViewController.h"
#import "PlannerAppAppDelegate.h"
@interface DelegatePopView : UIViewController <ABPeoplePickerNavigationControllerDelegate,ABPersonViewControllerDelegate>
{
	IBOutlet UILabel *name;
    PlannerAppAppDelegate *appdel;
    NSString *strEmail;
    NSString *strMID;
    NSString *strSID;
}
-(IBAction)Click:(id)sender;
@property(nonatomic,retain) NSString *strMID;
@property(nonatomic,retain) NSString *strSID;
-(void)findEmail;
-(void)JSONDelegate:(NSString *)email strid:(NSString *)strid;
@end
