//
//  PriorityPopView.h
//  PlannerApp
//
//  Created by openxcell tech.. on 2/10/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAL.h"

@interface PriorityPopView : UITableViewController 
{
	NSMutableArray *pri_array;
    NSString *strMID;
    NSString *strStid;
    int rowselection;
    DAL *dal;
    NSMutableArray *retrieveArr;
    
}
@property(nonatomic,retain)NSString *strID;
@property(nonatomic,retain)NSString *strStid;
@end
