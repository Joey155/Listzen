//
//  ViewController.m
//  iToDoList
//
//  Created by Joseph Duodu on 6/18/21.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
//- (void)loadView {
//    [super loadView];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // create an array for tasks
    self.tasks = [NSMutableArray array];
    
    // Do any additional setup after loading the view.
    // Define the frame rectangles of the three UI elements
    // CGRectMake() creates a CGRect from (x, y, width, height)
    CGRect winFrame = [[UIScreen mainScreen] bounds];
    CGRect tableFrame = CGRectMake(0, 100, winFrame.size.width, winFrame.size.height-100);
    CGRect fieldFrame = CGRectMake(20, 50, 200, 31);
    CGRect buttonFrame = CGRectMake(228, 30, 70, 70);
    
    //create and configure the UITableView instance
    UITableView *tableForTasks = [[UITableView alloc] initWithFrame:tableFrame
                                                              style: UITableViewStylePlain];
    _taskTable = tableForTasks;
    [tableForTasks setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [tableForTasks setDataSource:self];
    
    // Tell the table view which class to instantiate
    // whenever it needs to create a cell
    [tableForTasks registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    //Create and configure the UITextField instance where new tasks will be entered
    UITextField *textTaskField = [[UITextField alloc] initWithFrame:fieldFrame];
    _taskField = textTaskField;
    [textTaskField setBorderStyle:UITextBorderStyleRoundedRect];
    [textTaskField setPlaceholder:@"Type a task, tap add"];
    
    //Create and configure the UIButton instance
    UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _insertButton = plusButton;
    [plusButton setFrame:buttonFrame];
    
    // Give the button a title
    // disable highlighting effect
    UIImage *image = [UIImage systemImageNamed:@"plus"];
    [plusButton setImage:image forState:UIControlStateNormal];
    [plusButton setAdjustsImageWhenHighlighted:NO];
    
    // Set target and action for the insert button
    [plusButton addTarget:self
                  action:@selector(addTasks:)
        forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview: tableForTasks];
    [self.view addSubview: textTaskField];
    [self.view addSubview: plusButton];
    
}

#pragma mark - Table View management

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Because this table view only has one section
    // the number of rows in it will just be the number items
    // In the task array.
    return [[self tasks] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    // Check for and reuse an existing cell or create a new one if there isn't
    UITableViewCell *cell = [[self taskTable] dequeueReusableCellWithIdentifier:@"Cell"];
    
    // configure the cell based on the model object.
    // In this case I am using am using an array
    // tasks is an NSMutableArray Object
    NSString *item = [[self tasks] objectAtIndex:indexPath.row];
    cell.textLabel.text = item;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
    
        // Remove deleted task from data source
        // This is specific for an NSMutableArray data source
        [[self tasks] removeObjectAtIndex:indexPath.row];
        [[self taskTable] reloadData];
    }
}



#pragma mark - Actions

- (void)addTasks:(id)sender
{
    // Get the task
    NSString *text = [[self taskField] text];
    // Quit here if taskField is empty
    if ([text length] == 0) {
        return;
    }
    
    // Log text to console
    //NSLog(@"Task entered: %@", text);
    // add task object to task array
    [[self tasks] addObject:text];
    
    // Refresh table so that new items show up
    [[self taskTable] reloadData];
    
    // Clear out the text field
    [[self taskField] setText:@""];
    // Dismiss the Keyboard
    [[self taskField] resignFirstResponder];
}

@end
