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
    CGRect fieldFrame = CGRectMake(20, 40, 200, 31);
    CGRect buttonFrame = CGRectMake(228, 40, 72, 31);
    
    //create and configure the UITableView instance
    self.taskTable = [[UITableView alloc] initWithFrame:tableFrame
                                                  style: UITableViewStylePlain];
    self.taskTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.taskTable.dataSource = self;
    
    //Tell the table view which class to instantiate whenever it needs to create a new cell
    [self.taskTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    //Create and configure the UITextField instance where new tasks will be entered00
    self.taskField = [[UITextField alloc] initWithFrame:fieldFrame];
    self.taskField.borderStyle = UITextBorderStyleRoundedRect;
    self.taskField.placeholder = @"Type a task, tap insert";
    
    //Create and configure the UIButton instance
    self.insertButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.insertButton.frame = buttonFrame;
    
    // Give the button a title
    // disable highlighting effect
    UIImage *image = [UIImage systemImageNamed:@"plus"];
    [self.insertButton setImage:image forState:UIControlStateNormal];
    self.insertButton.adjustsImageWhenHighlighted = NO;
    
    // Set target and action for the insert button
    [self.insertButton addTarget:self
                          action:@selector(addTasks:)
                forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview: self.taskTable];
    [self.view addSubview: self.taskField];
    [self.view addSubview: self.insertButton];
    
}

#pragma mark - Table View management

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Because this table view only has one section
    // the number of rows in it will just be the number items
    // In the task array.
    return [self.tasks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    // Check for and reuse an existing cell or create a new one if there isn't
    UITableViewCell *cell = [self.taskTable dequeueReusableCellWithIdentifier:@"Cell"];
    
    // configure the cell based on the model object.
    // In this case I am using am using an array
    // tasks is an NSMutableArray Object
    NSString *item = [self.tasks objectAtIndex:indexPath.row];
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
        [self.tasks removeObjectAtIndex:indexPath.row];
        [self.taskTable reloadData];
    }
}



#pragma mark - Actions

- (void)addTasks:(id)sender
{
    // Get the task
    NSString *text = [self.taskField text];
    // Quit here if taskField is empty
    if ([text length] == 0) {
        return;
    }
    
    // Log text to console
    //NSLog(@"Task entered: %@", text);
    // add task object to task array
    [self.tasks addObject:text];
    
    // Refresh table so that new items show up
    [self.taskTable reloadData];
    
    // Clear out the text field
    [self.taskField setText:@""];
    // Dismiss the Keyboard
    [self.taskField resignFirstResponder];
}





@end
