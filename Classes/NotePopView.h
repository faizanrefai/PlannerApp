//
//  NotePopView.h
//  PlannerApp
//
//  Created by openxcell tech.. on 2/11/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAL.h"

@interface NotePopView : UIViewController {
    NSString *strStid;
    NSString *strMtid;
    DAL *dal;
    IBOutlet UITextView *txtView;
}
-(IBAction)clickOnDone:(id)sender;
@property(nonatomic,retain) NSString *strStid;
@property(nonatomic,retain)NSString *strMtid;
@end
