//
//  Settings.m
//  PlannerApp
//
//  Created by Openxcell on 2/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Settings.h"
#import "SyncSubView.h"
#import "PlannerAppAppDelegate.h"
#import "LocationsAlerts.h"
#import "LoginPage.h"
#import "AddNewLocation.h"
#import <QuartzCore/QuartzCore.h>
#import "GMGridView.h"
#import "GMGridViewLayoutStrategies.h"
#import "OptionsViewController.h"
#import "OptionsViewController.h"

@interface Settings () <GMGridViewDataSource, GMGridViewSortingDelegate, GMGridViewTransformationDelegate>
{
    __gm_weak GMGridView *_gmGridView1;
    __gm_weak GMGridView *_gmGridView2;
    
    __gm_weak UIButton *_buttonOptionsGrid1;
    __gm_weak UIButton *_buttonOptionsGrid2;
    
    UIPopoverController *_popOverController;
    UIViewController *_optionsController1;
    UIViewController *_optionsController2;
}

- (void)computeViewFrames;
- (void)showOptionsFromButton:(UIButton *)button;
- (void)optionsDoneAction;

@end

@implementation Settings

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
        arrName=[[NSMutableArray alloc] init];
        arrTab=[[NSMutableArray alloc] init];
        arrName= [[NSUserDefaults standardUserDefaults] objectForKey:@"tab"];
        NSLog(@"%@",arrName);
        arrTabName=[[NSMutableArray alloc] init];
        for(int i=0;i<[arrName count];i++){
            if([[arrName objectAtIndex:i] isEqualToString:@"Work"]){
                [arrTab addObject:@"Work.png"];
                [arrTabName addObject:[arrName objectAtIndex:i]];
                
            }
            else if([[arrName objectAtIndex:i] isEqualToString:@"Personal"]){
                [arrTab addObject:@"Personal.png"];
                [arrTabName addObject:[arrName objectAtIndex:i]];
                
            }
            else if([[arrName objectAtIndex:i] isEqualToString:@"Family"]){
                [arrTab addObject:@"Family.png"];
                [arrTabName addObject:[arrName objectAtIndex:i]];
                
            }
            else if([[arrName objectAtIndex:i] isEqualToString:@"Health"]){
                [arrTab addObject:@"Healt.png"];
                [arrTabName addObject:[arrName objectAtIndex:i]];
                
            }
            else if([[arrName objectAtIndex:i] isEqualToString:@"Finance"]){
                [arrTab addObject:@"Finance.png"];
                [arrTabName addObject:[arrName objectAtIndex:i]];
                
            }
            else if([[arrName objectAtIndex:i] isEqualToString:@"Shared"]){
                [arrTab addObject:@"Shared.png"];
                [arrTabName addObject:[arrName objectAtIndex:i]];
                
            }
            else if([[arrName objectAtIndex:i] isEqualToString:@"Urgent"]){
                [arrTab addObject:@"Urgent.png"];
                [arrTabName addObject:[arrName objectAtIndex:i]];
                
            }
            else if([[arrName objectAtIndex:i] isEqualToString:@"Shopping"]){
                [arrTab addObject:@"Shopping.png"];
                [arrTabName addObject:[arrName objectAtIndex:i]];
                
            }
            
        }

               
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
    //    
    //    _gmGridView1.sortingDelegate   = self;
    //    _gmGridView1.transformDelegate = self;
    //    _gmGridView1.dataSource = self;
    self.title=@"Settings";
    
    self.contentSizeForViewInPopover=CGSizeMake(678, 780);
    
    _gmGridView2.sortingDelegate   = self;
    _gmGridView2.transformDelegate = self;
    _gmGridView2.dataSource = self;
    
       
    // _gmGridView1.mainSuperView = self.navigationController.view;
    _gmGridView2.mainSuperView = self.navigationController.view;
   
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    appdel=(PlannerAppAppDelegate *)[[UIApplication sharedApplication]delegate ];
    self.navigationController.navigationBarHidden=TRUE;
    tblLocation.hidden=TRUE;
    arrLoc=[[NSMutableArray alloc] initWithObjects:@"Location 1",@"Location 2",@"Location 3",@"Location 4",@"Location 5", nil];
    lblSelLoc.font=[UIFont fontWithName:@"HelenBgCondensed-Bold" size:20];
    lblColr.font=[UIFont fontWithName:@"HelenBgCondensed-Bold" size:20];
  
    lblLocationAlert.font=[UIFont fontWithName:@"HelenBgCondensed-Bold" size:20];
    lblSorting.font=[UIFont fontWithName:@"HelenBgCondensed-Bold" size:20];
    lblSettings.font=[UIFont fontWithName:@"HelenBgCondensed-Bold" size:24];
    lbltab.font=[UIFont fontWithName:@"HelenBgCondensed-Bold" size:20];
    lblPush.font=[UIFont fontWithName:@"HelenBgCondensed-Bold" size:20];
    lblSync.font=[UIFont fontWithName:@"HelenBgCondensed-Bold" size:20];

  
    arrColor=[[NSMutableArray alloc] initWithObjects:@"0",@"0",@"0",@"0", nil];
    arrSync=[[NSMutableArray alloc] initWithObjects:@"0",@"0",@"0", nil];
    arrPrio=[[NSMutableArray alloc] initWithObjects:@"0",@"0", nil];
    
    UITapGestureRecognizer *doubleTap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
    doubleTap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:doubleTap];
    [doubleTap release];
    isNoti=YES;
   }

- (IBAction)tapDetected:(UIGestureRecognizer *)sender{
    
    NSLog(@"tap");
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"dissmissSetting" object:self];
    // PlannerAppViewController *plannerOb=[[PlannerAppViewController alloc] init];
    
    //[plannerOb dissmissProgress:sender];
    
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [arrLoc count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    UIImageView * background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TBLBg.png"]];
    [tableView setBackgroundView:background];
    [background release];
    
    cell.textLabel.font=[UIFont fontWithName:@"HelenBgCondensed-Bold" size:20];
    cell.textLabel.textColor=[UIColor whiteColor];
    cell.textLabel.text=[arrLoc objectAtIndex:indexPath.row];
       return cell;
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    tblLocation.hidden=TRUE; 
    lblSelLoc.text=[arrLoc objectAtIndex:indexPath.row];
     
}
-(IBAction)logOut:(id)sender{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Logout"
                                                  message:@"Are You Sure You Want To Logout?" 
                                                 delegate:self 
                                        cancelButtonTitle:nil 
                                        otherButtonTitles:@"YES",@"NO",nil];
    [alert show];
    [alert release];
}
-(IBAction)addNewLocation:(id)sender{
    AddNewLocation *addNewLoc=[[AddNewLocation alloc] init];
    [self.navigationController pushViewController:addNewLoc animated:YES];
    [addNewLoc release];
}
-(IBAction)ClickDrop:(id)sender{
    tblLocation.hidden=FALSE;
   
    [tblLocation reloadData];
}
-(IBAction)clickGoogle:(id)sender{
    [btnGoogle setSelected:YES];
    [btnYahoo setSelected:NO];
    [btnTodo setSelected:NO];
    [arrSync replaceObjectAtIndex:0 withObject:@"1"];
    [arrSync replaceObjectAtIndex:1 withObject:@"0"];
    [arrSync replaceObjectAtIndex:2 withObject:@"0"];
   
    
}
-(IBAction)clickYahoo:(id)sender{
    [btnGoogle setSelected:NO];
    [btnYahoo setSelected:YES];
    [btnTodo setSelected:NO];
    [arrSync replaceObjectAtIndex:0 withObject:@"0"];
    [arrSync replaceObjectAtIndex:1 withObject:@"1"];
    [arrSync replaceObjectAtIndex:2 withObject:@"0"];
   
}
-(IBAction)clickTodo:(id)sender{
    [btnGoogle setSelected:NO];
    [btnYahoo setSelected:NO];
    [btnTodo setSelected:YES];
    [arrSync replaceObjectAtIndex:0 withObject:@"0"];
    [arrSync replaceObjectAtIndex:1 withObject:@"0"];
    [arrSync replaceObjectAtIndex:2 withObject:@"1"];
}
  -(IBAction)clickPrio:(id)sender{
    
    [btnStat setSelected:NO];
    [btnPrio setSelected:YES];
    [arrPrio replaceObjectAtIndex:0 withObject:@"1"];
    [arrPrio replaceObjectAtIndex:1 withObject:@"0"];
}
-(IBAction)clickStat:(id)sender{
    [btnStat setSelected:YES];
    [btnPrio setSelected:NO];
    [arrPrio replaceObjectAtIndex:0 withObject:@"0"];
    [arrPrio replaceObjectAtIndex:1 withObject:@"1"];
}
-(IBAction)clickBlack:(id)sender{
    [btnBlack setSelected:YES];
    [btnPink setSelected:NO];
    [btnYellow setSelected:NO];
    [btnBlue setSelected:NO];
    [arrColor replaceObjectAtIndex:0 withObject:@"1"];
    [arrColor replaceObjectAtIndex:1 withObject:@"0"];
    [arrColor replaceObjectAtIndex:2 withObject:@"0"];
    [arrColor replaceObjectAtIndex:3 withObject:@"0"];
}
-(IBAction)clickYellow:(id)sender{
    [btnBlack setSelected:NO];
    [btnPink setSelected:NO];
    [btnYellow setSelected:YES];
    [btnBlue setSelected:NO];
    [arrColor replaceObjectAtIndex:0 withObject:@"0"];
    [arrColor replaceObjectAtIndex:1 withObject:@"1"];
    [arrColor replaceObjectAtIndex:2 withObject:@"0"];
    [arrColor replaceObjectAtIndex:3 withObject:@"0"];
}
-(IBAction)clickBlue:(id)sender{
    [btnBlack setSelected:NO];
    [btnPink setSelected:NO];
    [btnYellow setSelected:NO];
    [btnBlue setSelected:YES];
    [arrColor replaceObjectAtIndex:0 withObject:@"0"];
    [arrColor replaceObjectAtIndex:1 withObject:@"0"];
    [arrColor replaceObjectAtIndex:2 withObject:@"1"];
    [arrColor replaceObjectAtIndex:3 withObject:@"0"];
}
-(IBAction)clickPink:(id)sender{
    [btnBlack setSelected:NO];
    [btnPink setSelected:YES];
    [btnYellow setSelected:NO];
    [btnBlue setSelected:NO];
    [arrColor replaceObjectAtIndex:0 withObject:@"0"];
    [arrColor replaceObjectAtIndex:1 withObject:@"0"];
    [arrColor replaceObjectAtIndex:2 withObject:@"0"];
    [arrColor replaceObjectAtIndex:3 withObject:@"0"];
}
-(IBAction)clickNotification:(id)sender{
    if(isNoti){
        isNoti=NO;
        [btnNotification setSelected:YES];
    }
    else{
        isNoti=YES;
        [btnNotification setSelected:NO];
    }
}
- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	
	if (buttonIndex == 0)
	{
        appdel.str=@"100";
        NSHTTPCookieStorage* cookies = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (NSHTTPCookie* cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
            [cookies deleteCookie:cookie];
        }
        NSString *str=@"";
        [[NSUserDefaults standardUserDefaults] setValue:str forKey:@"fbtoken"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"loginName"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"loginPassword"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSUserDefaults standardUserDefaults] setValue:@"NO" forKey:@"ischeck"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"dissmissSetting" object:self];
        		
	}
    else{
        
    }
}
#pragma mark Reoder



//////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark ViewController implementation
//////////////////////////////////////////////////////////////




- (id)init
{
    if ((self = [super init])) 
    {
        //self.title = @"Demo 2";
    }
    return self;
}

//////////////////////////////////////////////////////////////
#pragma mark View lifecycle
//////////////////////////////////////////////////////////////

- (void)loadView
{
    [super loadView];
    //self.view.backgroundColor = [UIColor whiteColor];
    
      
    GMGridView *gmGridView2 = [[GMGridView alloc] initWithFrame:CGRectMake(0, 0, 608, 60)];
    gmGridView2.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    gmGridView2.style = GMGridViewStylePush;
    gmGridView2.itemSpacing = 0;
    gmGridView2.minEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    gmGridView2.centerGrid = YES;
    gmGridView2.layoutStrategy = [GMGridViewLayoutStrategyFactory strategyFromType:GMGridViewLayoutHorizontal];
    [tabView addSubview:gmGridView2];
    _gmGridView2 = gmGridView2;
    
       
    [self computeViewFrames];
}

- (void)viewDidLayoutSubviews
{
    [self computeViewFrames];
}





//////////////////////////////////////////////////////////////
#pragma mark Controller events
//////////////////////////////////////////////////////////////


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

//////////////////////////////////////////////////////////////
#pragma mark Privates
//////////////////////////////////////////////////////////////

- (void)computeViewFrames
{
    
    _gmGridView2.frame=CGRectMake(8,30,600,60);
    
    
}

- (void)showOptionsFromButton:(UIButton *)button
{
    UIViewController *optionsControllerToShow = button == _buttonOptionsGrid1 ? _optionsController1 : _optionsController2;
    
   
    
        if(![_popOverController isPopoverVisible])
        {
            _popOverController = [[UIPopoverController alloc] initWithContentViewController:optionsControllerToShow];
            [_popOverController presentPopoverFromRect:button.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        }
        else
        {
            [self optionsDoneAction];
        }
    
}

- (void)optionsDoneAction
{
        
    
        [_popOverController dismissPopoverAnimated:YES];
        _popOverController = nil;

}

//////////////////////////////////////////////////////////////
#pragma mark GMGridViewDataSource
//////////////////////////////////////////////////////////////

- (NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
{
    return [arrTabName count];
}

- (CGSize)sizeForItemsInGMGridView:(GMGridView *)gridView
{
   
    
        return CGSizeMake(74, 41);
    
}

- (GMGridViewCell *)GMGridView:(GMGridView *)gridView cellForItemAtIndex:(NSInteger)index
{
    CGSize size = [self sizeForItemsInGMGridView:gridView];
    
    GMGridViewCell *cell = [gridView dequeueReusableCell];
    
    if (!cell) 
    {
        cell = [[GMGridViewCell alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        NSLog(@"%@",[arrTab objectAtIndex:index]);
        view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[arrTab objectAtIndex:index]]]];
       // view.backgroundColor = (gridView == _gmGridView1) ? [UIColor purpleColor] : [UIColor greenColor];
       // view.layer.masksToBounds = NO;
       // view.layer.cornerRadius = 8;
        //view.layer.shadowColor = [UIColor grayColor].CGColor;
        //view.layer.shadowOffset = CGSizeMake(5, 5);
        //view.layer.shadowPath = [UIBezierPath bezierPathWithRect:view.bounds].CGPath;
        //view.layer.shadowRadius = 8;
        
        cell.contentView = view;
    }
    
    [[cell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
       
    return cell;
}


//////////////////////////////////////////////////////////////
#pragma mark GMGridViewSortingDelegate
//////////////////////////////////////////////////////////////

- (void)GMGridView:(GMGridView *)gridView didStartMovingCell:(GMGridViewCell *)cell
{
    [UIView animateWithDuration:0.3 
                          delay:0 
                        options:UIViewAnimationOptionAllowUserInteraction 
                     animations:^{
                         //cell.contentView.backgroundColor = [UIColor orangeColor];
                         cell.contentView.layer.shadowOpacity = 0.7;
                     } 
                     completion:nil
     ];
}

- (void)GMGridView:(GMGridView *)gridView didEndMovingCell:(GMGridViewCell *)cell
{
    [UIView animateWithDuration:0.3 
                          delay:0 
                        options:UIViewAnimationOptionAllowUserInteraction 
                     animations:^{  
                         //cell.contentView.backgroundColor = (gridView == _gmGridView1) ? [UIColor purpleColor] : [UIColor greenColor];
                         cell.contentView.layer.shadowOpacity = 0;
                     }
                     completion:nil
     ];
}

- (BOOL)GMGridView:(GMGridView *)gridView shouldAllowShakingBehaviorWhenMovingCell:(GMGridViewCell *)cell atIndex:(NSInteger)index
{
    return YES;
}

- (void)GMGridView:(GMGridView *)gridView moveItemAtIndex:(NSInteger)oldIndex toIndex:(NSInteger)newIndex
{
    NSString *item = [[arrTab objectAtIndex:oldIndex] retain];
    [arrTab removeObject:item];
    [arrTab insertObject:item atIndex:newIndex];
    NSLog(@"%@",arrTab);
    [item release];
    
    
    NSString *item1 = [[arrTabName objectAtIndex:oldIndex] retain];
    [arrTabName removeObject:item1];
    [arrTabName insertObject:item1 atIndex:newIndex];
    NSLog(@"%@",arrTabName);
    [item1 release];
    [[NSUserDefaults standardUserDefaults] setObject:arrTabName forKey:@"tab"];
    [[NSUserDefaults standardUserDefaults] synchronize];


    // We dont care about this in this demo (see demo 1 for examples)
}

- (void)GMGridView:(GMGridView *)gridView exchangeItemAtIndex:(NSInteger)index1 withItemAtIndex:(NSInteger)index2
{
    // We dont care about this in this demo (see demo 1 for examples)
}


//////////////////////////////////////////////////////////////
#pragma mark DraggableGridViewTransformingDelegate
//////////////////////////////////////////////////////////////

- (CGSize)GMGridView:(GMGridView *)gridView sizeInFullSizeForCell:(GMGridViewCell *)cell atIndex:(NSInteger)index
{
   
        return CGSizeMake(75, 37);
    
}

- (UIView *)GMGridView:(GMGridView *)gridView fullSizeViewForCell:(GMGridViewCell *)cell atIndex:(NSInteger)index
{
    UIView *fullView = [[UIView alloc] init];
    fullView.backgroundColor = [UIColor yellowColor];
    fullView.layer.masksToBounds = NO;
    fullView.layer.cornerRadius = 8;
    
    CGSize size = [self GMGridView:gridView sizeInFullSizeForCell:cell atIndex:index];
    fullView.bounds = CGRectMake(0, 0, size.width, size.height);
    
    UILabel *label = [[UILabel alloc] initWithFrame:fullView.bounds];
    label.text = [NSString stringWithFormat:@"Fullscreen View for cell at index %d", index];
    label.textAlignment = UITextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    
   
        label.font = [UIFont boldSystemFontOfSize:20];
    
    
    [fullView addSubview:label];
    
    
    return fullView;
}

- (void)GMGridView:(GMGridView *)gridView didStartTransformingCell:(GMGridViewCell *)cell
{
    [UIView animateWithDuration:0.5 
                          delay:0 
                        options:UIViewAnimationOptionAllowUserInteraction 
                     animations:^{
                         cell.contentView.backgroundColor = [UIColor blueColor];
                         cell.contentView.layer.shadowOpacity = 0.7;
                     } 
                     completion:nil];
}

- (void)GMGridView:(GMGridView *)gridView didEndTransformingCell:(GMGridViewCell *)cell
{
    [UIView animateWithDuration:0.5 
                          delay:0 
                        options:UIViewAnimationOptionAllowUserInteraction 
                     animations:^{
                         cell.contentView.backgroundColor = (gridView == _gmGridView1) ? [UIColor purpleColor] : [UIColor greenColor];
                         cell.contentView.layer.shadowOpacity = 0;
                     } 
                     completion:nil];
}

- (void)GMGridView:(GMGridView *)gridView didEnterFullSizeForCell:(GMGridViewCell *)cell
{
    
}

-(void)viewWillDisappear:(BOOL)animated{
     
    
}

-(void)dealloc{
    [super dealloc];
   
}
@end
