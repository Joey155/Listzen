//
//  ViewController.h
//  iToDoList
//
//  Created by Joseph Duodu on 6/18/21.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController

@property (nonatomic) UITableView *taskTable;
@property (nonatomic) UITextField *taskField;
@property (nonatomic) UIButton    *insertButton;
@property (nonatomic) NSMutableArray *tasks;

- (void)addTasks:(id)sender;

@end

