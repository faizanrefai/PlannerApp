//
//  ProgressViewController.m
//  PlannerApp
//
//  Created by Openxcell on 2/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ProgressViewController.h"
#import "PlannerAppViewController.h"
#import "WEPopoverController.h"
@implementation ProgressViewController
@synthesize progress_cell;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"transp-background.png"]];
   
    self.contentSizeForViewInPopover=CGSizeMake(678, 780);
	UIBarButtonItem *doneButton=[[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(goBack:)];
	
	
	[self.navigationItem setLeftBarButtonItem:doneButton];
  
   
	array_sections=[[NSMutableArray alloc]initWithObjects:@"Completed",@"In Progress",@"No Action",@"Added",nil];
	array_cmplt=[[NSMutableArray alloc] initWithObjects:@"Work",@"Personal",@"Family",@"Health",@"Finance",nil];
	array_progress=[[NSMutableArray alloc] initWithObjects:@"Work",@"Personal",@"Family",@"Health",@"Finance",nil];
  //  [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [doneButton release];
	
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
     self.navigationController.navigationBarHidden=TRUE;

    UITapGestureRecognizer *doubleTap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
    doubleTap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:doubleTap];
    [doubleTap release];
     
    


}
- (IBAction)tapDetected:(UIGestureRecognizer *)sender{
   
    NSLog(@"tap");
   
     [[NSNotificationCenter defaultCenter] postNotificationName:@"dissmissProgress" object:self];
   // PlannerAppViewController *plannerOb=[[PlannerAppViewController alloc] init];
    
    //[plannerOb dissmissProgress:sender];
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
   // return [array_sections count];
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
//    if(section == 0)
//	{
//		return [array_cmplt count];
//	}
//	else if(section == 1)
//	{
//		return [array_progress count];
//	}
//	else 
//	{
//		return [array_cmplt count];
//	}


    return [array_sections count];
}
/*
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section==0){
        return @"Completed Tasks";
        //return @"Last Up";
    }
	else if(section == 1)
	{
		return @"Tasks in Progress";
	}
    else if(section == 2){
        return @"No Action";
    }
	else if(section == 3) {
		return @"Added";
	}

}
*/

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"CustomProgressCell" owner:self options:nil];
        cell=self.progress_cell;
        self.progress_cell=nil;
        
    }
    if(indexPath.row == 0)
    {
        lblTaskDes.text=@"Completed Tasks";
        
    }
    else if(indexPath.row == 1)
    {
        lblTaskDes.text=@"In Progress";
        
    }
    else if(indexPath.row == 2)
    {
        lblTaskDes.text=@"No Action";
        
    }
    else if(indexPath.row == 3)
    {
        lblTaskDes.text=@"Added";
        
    }
    
    //UIImageView * background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"transp-background.png"]];
    //[tableView setBackgroundView:background];
    //[background release];


    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;    
  	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//   Progress_SubView *Objprogress=[[Progress_SubView alloc] initWithNibName:@"Progress_SubView" bundle:nil];
//    [self.navigationController pushViewController:Objprogress animated:YES];
//    NSLog(@"hi");
//    [Objprogress release];
    
}

@end
