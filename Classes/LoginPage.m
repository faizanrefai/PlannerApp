    //
//  LoginPage.m
//  PlannerApp
//
//  Created by openxcell tech.. on 2/20/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "LoginPage.h"
#import "AlertHandler.h"

@implementation LoginPage
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
    
    flag=1;
    
	
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=TRUE;
    [btnLogin setImage:[UIImage imageNamed:@"login button.png"] forState:UIControlStateNormal];
    isCheck=YES;
    [btnFb setImage:[UIImage imageNamed:@"fbNormal.png"] forState:UIControlStateNormal];
    [btnReg setImage:[UIImage imageNamed:@"sign up button"] forState:UIControlStateNormal];
    appdel=(PlannerAppAppDelegate *)[[UIApplication sharedApplication]delegate];
    self.navigationItem.hidesBackButton=YES;
    
        txt_username.text=@"";
        txt_password.text=@"";
   
    
   
    
}
-(void)JSON
{
    
    [AlertHandler showAlertForProcess];
    NSString *str=[NSString stringWithFormat:@"%@/user_action.php?action=login&email=%@&password=%@&deviceToken=%@",appdel.url,txt_username.text,txt_password.text,[[NSUserDefaults standardUserDefaults] valueForKey:@"PlannerDeviceToken"]];   
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:str]];
    JSONParser *parser = [[JSONParser alloc] initWithRequestForThread:request sel:@selector(searchResult:) andHandler:self];
    NSLog(@"%@",parser);
   
	
}

-(void)searchResult:(NSDictionary*)dictionary
{
    [AlertHandler hideAlert];
    NSLog(@"%@",dictionary);
    NSString *str=[dictionary valueForKey:@"msg"];
    NSString *str1=[NSString stringWithFormat:@"Username or Password is invalid"];
    if([str isEqualToString:str1])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Try Again" message:@"Wrong Email or Password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil ];
        [alert show];
        [alert release];
    }
            
    else
    {
        NSString *str=[dictionary valueForKey:@"uid"];
        
        [[NSUserDefaults standardUserDefaults] setValue:str forKey:@"user_id"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        PlannerAppViewController *plan=[[PlannerAppViewController alloc]initWithNibName:@"PlannerAppViewController" bundle:nil];
        [self.navigationController pushViewController:plan animated:YES];
        [plan release];
    }

}	

-(IBAction)ClickOnLogin:(id)sender
{
    [txt_password resignFirstResponder];
    [txt_username resignFirstResponder];
    if(!isCheck){
       
        [[NSUserDefaults standardUserDefaults] setValue:txt_username.text forKey:@"loginName"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSUserDefaults standardUserDefaults] setValue:txt_password.text forKey:@"loginPassword"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSUserDefaults standardUserDefaults] setValue:@"YES" forKey:@"ischeck"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        NSLog(@"%@    %@    %@ ",[[NSUserDefaults standardUserDefaults]valueForKey:@"loginName"],[[NSUserDefaults standardUserDefaults]valueForKey:@"loginPassword"],[[NSUserDefaults standardUserDefaults]valueForKey:@"ischeck"]);
    }
    else{
        [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"loginName"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"loginPassword"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSUserDefaults standardUserDefaults] setValue:@"NO" forKey:@"ischeck"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    if([txt_username.text isEqualToString:@""]){
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Sorry"
                                                      message:@"Please Enter Your Email" 
                                                     delegate:self 
                                            cancelButtonTitle:nil 
                                            otherButtonTitles:@"OK",nil];
        [alert show];
        [alert release];

    }
    else if([txt_password.text isEqualToString:@""]){
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Sorry"
                                                      message:@"Please Enter A Password" 
                                                     delegate:self 
                                            cancelButtonTitle:nil 
                                            otherButtonTitles:@"OK",nil];
        [alert show];
        [alert release];
    }
    else{
        [btnLogin setImage:[UIImage imageNamed:@"loginpressed.png"] forState:UIControlStateNormal];
        [self JSON];
    }
    
}
-(IBAction)ClickOnRegister:(id)sender
{
    
    [btnReg setImage:[UIImage imageNamed:@"signuppressed"] forState:UIControlStateNormal];
    RegisterPage *reg=[[RegisterPage alloc] initWithNibName:@"RegisterPage" bundle:nil];
    [self.navigationController pushViewController:reg animated:YES];
    [reg release];
    
}
-(IBAction)ClickonCheck:(id)sender{
    [txt_password resignFirstResponder];
    [txt_username resignFirstResponder];
    if(isCheck){
        isCheck=NO;
        [btnCheck setSelected:YES];
        
        
    }
    else{
        
        [btnCheck setSelected:NO];
        isCheck=YES;
        
    }
}
-(IBAction)ClickOnFacebook:(id)sender
{
    [btnFb setImage:[UIImage imageNamed:@"fbPressed.png"] forState:UIControlStateNormal];
    appdel.strLoginID=@"1";
    PlannerAppViewController *plan=[[PlannerAppViewController alloc]initWithNibName:@"PlannerAppViewController" bundle:nil];
    [self.navigationController pushViewController:plan animated:YES];
    [plan release];
}
- (void)textFieldDidBeginEditing:(UITextField*)textField{
   
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


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
    [txt_password release];
    [txt_username release];
    [btnCheck release];
    [btnFb release];
    [btnLogin release];
    [btnReg release];
    
}


@end
