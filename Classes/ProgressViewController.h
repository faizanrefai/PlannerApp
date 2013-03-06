//
//  ProgressViewController.h
//  PlannerApp
//
//  Created by Openxcell on 2/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Progress_SubView.h"

@interface ProgressViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
   
	
	NSMutableArray *array_sections;
	NSMutableArray *array_cmplt;
	NSMutableArray *array_progress;
    IBOutlet UITableViewCell *progress_cell;
    IBOutlet UITableView *tbl;
    IBOutlet UIProgressView *prog_view;
    IBOutlet UILabel *lblTaskDes;
}
@property(nonatomic,retain)IBOutlet UITableViewCell *progress_cell;

-(IBAction)goBack:(id)sender;
-(IBAction)btnClick:(id)sender;
@end
