//
//  TapView.m
//  PlannerApp
//
//  Created by openxcell tech.. on 2/10/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "TapView.h"
#import "StatusPopView.h"
#import "PriorityPopView.h"
#import "Repeat_days.h"

#import "AlertHandler.h"

@implementation TapView
@synthesize str_mtid,str_stid,strTitle,flagEdit,str_scid;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	self.title=@"Details";
	self.contentSizeForViewInPopover = CGSizeMake(320.0, 300);
    
    array =[[NSMutableArray alloc] initWithObjects:@"Status",@"Priority",@"Alerts",@"Show more...",nil];
	
    
    deleteBtn= [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [deleteBtn setTitle:@"Delete" forState:UIControlStateNormal];
    [deleteBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(deleteTask:) forControlEvents:UIControlEventTouchUpInside];
    deleteBtn.frame = CGRectMake(0,0,40,40);
    deleteBtn.tintColor=[UIColor redColor];
    tbl.tableFooterView=deleteBtn;
    [deleteBtn release];
    UITapGestureRecognizer *doubleTap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
    doubleTap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:doubleTap];
    [doubleTap release];
    
    dal=[[DAL alloc] initDatabase:@"Planner.sqlite"];
    
    UIBarButtonItem *doneButton=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(tapDetected:)];
    
    
    [self.navigationItem setRightBarButtonItem:doneButton];
    [doneButton release];
    
    UIBarButtonItem *cancelButton=[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain  target:self action:@selector(tapDetected:)];
    
    
    [self.navigationItem setLeftBarButtonItem:cancelButton];
    [cancelButton release];
}
-(IBAction)deleteTask:(id)sender{
    [dal deleteFromTable:@"tblMainTask" WhereField:@"mtid=" 
               Condition:[NSString stringWithFormat:@"%@",str_mtid]];
     [[NSNotificationCenter defaultCenter] postNotificationName:@"dismissPopOverViewHome" object:self];

    
}
- (IBAction)tapDetected:(UIGestureRecognizer *)sender{
        
        NSLog(@"tap");
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"dismissPopOverViewHome" object:self];
        // PlannerAppViewController *plannerOb=[[PlannerAppViewController alloc] init];
        
        //[plannerOb dissmissProgress:sender];
        
}
   


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    appdel=(PlannerAppAppDelegate *)[[UIApplication sharedApplication]delegate];
    self.navigationController.navigationBar.tintColor=[UIColor blackColor];
    plan=[[PlannerAppViewController alloc] init];
    if([array count]==4){
    NSString *str = [[NSUserDefaults standardUserDefaults]valueForKey:@"strTitle"];
    [array insertObject:str atIndex:0];
    NSLog(@"str_mtid %@",str_mtid);
        NSLog(@"str_stid %@",str_stid);
    
    
    flagEdit=0;
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 300);
    [tbl reloadData];
}
}
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [array count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    if(indexPath.row==0){
        CGRect rect = CGRectMake(10,10,255.0,31);
        txt=[[UITextField alloc] initWithFrame:rect];
        txt.text=@"";
        txt.delegate=self;
        txt.font=[UIFont fontWithName:@"HelenBgCondensed-Bold" size:20];
        [cell.contentView addSubview:txt];
        NSLog(@"%@",array);
        txt.text=[array objectAtIndex:indexPath.row];
        [txt addTarget:self action:@selector(endOfText:) forControlEvents:UIControlEventEditingDidEnd];
        cell.accessoryType=UITableViewCellAccessoryNone;
        cell.textLabel.text=@"";
        [txt release];
    }
    else if(indexPath.row==4){
        if([[array objectAtIndex:indexPath.row]isEqualToString:@"Show more..."]){
            cell.textLabel.text=[array objectAtIndex:indexPath.row];
            
            cell.textLabel.textAlignment=UITextAlignmentLeft;
            cell.accessoryType=UITableViewCellAccessoryNone;
            cell.textLabel.font=[UIFont fontWithName:@"HelenBgCondensed-Bold" size:20];
        }
        else{
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
             cell.textLabel.textAlignment=UITextAlignmentLeft;
            cell.textLabel.text=[array objectAtIndex:indexPath.row];
            cell.textLabel.font=[UIFont fontWithName:@"HelenBgCondensed-Bold" size:20];
        }
    }
    // Configure the cell...
    else{
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
        cell.textLabel.text=[array objectAtIndex:indexPath.row];
        cell.textLabel.font=[UIFont fontWithName:@"HelenBgCondensed-Bold" size:20];
    }
	return cell;
}


-(IBAction)endOfText:(UITextField *)sender{
    
    UITextField *txt1=(UITextField *)sender;
    NSLog(@"%@",txt1.text);
    strTitle=txt1.text;
    [array replaceObjectAtIndex:0 withObject:txt1.text];
    if(str_stid){
        flagEdit=1;
        [self updateSub];
       
    }
    else{
        flagEdit=1;
        [self updateMain];
        
    }
    
    
}
-(void)updateMain{
    NSMutableDictionary *dica=[[NSMutableDictionary alloc] init];
       
    [dica setObject:[NSString stringWithFormat:@"%@",strTitle] forKey:@"title"];
    [dal updateRecord:dica forID:@"mtid="inTable:@"tblMainTask" withValue:[NSString stringWithFormat:@"%@",str_mtid] ];
    if(dica!=nil){
        [dica removeAllObjects];
        [dica release];
        dica=nil;
    }
   
}

-(void)updateSub{
    NSMutableDictionary *dica=[[NSMutableDictionary alloc] init];
    
    [dica setObject:[NSString stringWithFormat:@"%@",strTitle] forKey:@"title"];
    [dal updateRecord:dica forID:@"stid="inTable:@"tblSubTask" withValue:[NSString stringWithFormat:@"%@",str_stid] ];
    if(dica!=nil){
        [dica removeAllObjects];
        [dica release];
        dica=nil;
    }
}
-(void)JSON_updateSubTaskTitle
{
    [AlertHandler showAlertForProcess];
    NSString *str;
    
    NSString *encoded=(NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)strTitle, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
	
    str=[NSString stringWithFormat:@"%@/update_data.php?type=sub_task&id=%@&title=%@",appdel.url,str_stid,encoded];
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:str]];
    JSONParser *parser = [[JSONParser alloc] initWithRequestForThread:request sel:@selector(searchResultSubTaskUpdateTitle:) andHandler:self];
    NSLog(@"%@",parser);
    
}

-(void)searchResultSubTaskUpdateTitle:(NSDictionary*)dictionary
{
    [AlertHandler hideAlert];
    NSLog(@"%@",dictionary);
    
}
-(void)JSON_updateMainTask
{
    [AlertHandler showAlertForProcess];
    NSString *str;
    NSString *encoded=(NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)strTitle, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
    str=[NSString stringWithFormat:@"%@/update_data.php?type=main_task&id=%@&title=%@",appdel.url,str_mtid,encoded];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:str]];
    JSONParser *parser = [[JSONParser alloc] initWithRequestForThread:request sel:@selector(searchResultMaintaskUpdate:) andHandler:self];
    NSLog(@"%@",parser);
}

-(void)searchResultMaintaskUpdate:(NSDictionary*)dictionary
{
    [AlertHandler hideAlert];
    NSLog(@"dictionary is %@",dictionary);
   
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


-(IBAction)clickOnDone:(id)sender
{
    [txt resignFirstResponder];
    
    
	 [[NSNotificationCenter defaultCenter] postNotificationName:@"dismissPopOverViewHome" object:self];
}

-(IBAction)clickOnCancel:(id)sender
{
	
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    if(indexPath.row==0){
        
       
    }
	if (indexPath.row == 1)
	{
		StatusPopView *stat= [[StatusPopView alloc] initWithNibName:@"StatusPopView" bundle:nil];
        NSLog(@"%@",str_stid);
        
            stat.strID=str_mtid;
        stat.strStid=str_stid;
       
		[self.navigationController pushViewController:stat animated:YES];
        [stat release];
	}
	
	else if(indexPath.row == 2)
	{
		PriorityPopView *priority=[[PriorityPopView alloc] initWithNibName:@"PriorityPopView" bundle:nil];
        priority.strID=str_mtid;
        priority.strStid=str_stid;
		[self.navigationController pushViewController:priority animated:YES];
        [priority release];

	}
	else if(indexPath.row == 3)
	{
		AlertsPopView *alert=[[AlertsPopView alloc] initWithNibName:@"AlertsPopView" bundle:nil];
        alert.strSID=str_stid;
        alert.strMID=str_mtid;
        alert.strTaskName=[[NSUserDefaults standardUserDefaults]valueForKey:@"strTitle"];;
		[self.navigationController pushViewController:alert animated:YES];
        [alert release];
	}
    else if(indexPath.row == 4){
        NSLog(@"%@",array);
        if([[array objectAtIndex:4] isEqualToString:@"Show more..."]){
        
        array =[[NSMutableArray alloc] initWithObjects:@"Status",@"Priority",@"Alerts",@"Repeats",@"Locations",@"Delegate To",@"Invitees",@"Availability",@"Folder",@"Sub Folder",@"Add Note",nil];
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 460);
        if([array count]==11){
                NSString *str = [[NSUserDefaults standardUserDefaults]valueForKey:@"strTitle"];
                [array insertObject:str atIndex:0];
                
            }
        [tableView reloadData];
        }
	else 
	{
		Repeat_days *repeat=[[Repeat_days alloc] initWithNibName:@"Repeat_days" bundle:nil];
        repeat.strMID=str_mtid;
        repeat.strSID=str_stid;
		[self.navigationController pushViewController:repeat animated:YES];
        [repeat release];
				
	}}
	else if(indexPath.row == 5) 
	{
		//LocationsAlerts *location=[[LocationsAlerts alloc] initWithNibName:@"LocationsAlerts" bundle:nil];
		LocationPopView *location=[[LocationPopView alloc] initWithNibName:@"LocationPopView" bundle:nil];
		[self.navigationController pushViewController:location animated:YES];
        [location release];
        
	}

	else if (indexPath.row == 6) 
	{
		DelegatePopView *del=[[DelegatePopView alloc] initWithNibName:@"DelegatePopView" bundle:nil];
        del.strMID=str_mtid;
        del.strSID=str_stid;
		[self.navigationController pushViewController:del animated:YES];
        [del release];
	}
	else if(indexPath.row == 7)
	{
		InviteesPopView *invite=[[InviteesPopView alloc]initWithNibName:@"InviteesPopView" bundle:nil];
        invite.strMID=str_mtid;
        invite.strSID=str_stid;
		[self.navigationController pushViewController:invite animated:YES];
        [invite release];
	}
	else if(indexPath.row == 8)
	{
		AvailabilityPopView *available=[[AvailabilityPopView alloc] initWithNibName:@"AvailabilityPopView" bundle:nil];
        available.strSID=str_stid;
        available.strMID=str_mtid;
		[self.navigationController pushViewController:available animated:YES];
        [available release];
	}

	else if(indexPath.row == 9)
	{
		FolderPopView *folder=[[FolderPopView alloc] initWithNibName:@"FolderPopView" bundle:nil];
        folder.strMID=str_mtid;
        folder.strSID=str_stid;
        folder.strCID=str_scid;
		[self.navigationController pushViewController:folder animated:YES];
        [folder release];
	}
	else if(indexPath.row == 10)
	{
		SubFolderPopView *subFolder=[[SubFolderPopView alloc] initWithNibName:@"SubFolderPopView" bundle:nil];
        subFolder.strMID=str_mtid;
        subFolder.strSID=str_stid;
        subFolder.strCID=str_scid;
		[self.navigationController pushViewController:subFolder animated:YES];
        [subFolder release];
	}
	else if(indexPath.row == 11)
	{
		NotePopView *note = [[NotePopView alloc] initWithNibName:@"NotePopView" bundle:nil];
        note.strMtid=str_mtid;
        note.strStid=str_stid;
		[self.navigationController pushViewController:note animated:YES];
        [note release];
	}
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

