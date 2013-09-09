//
//  MasterViewController.m
//  DynamicSizedCells
//
//  Created by Ankur Oberoi on 9/9/13.
//  Copyright (c) 2013 Ankur Oberoi. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"
#import "DSCTableViewCell.h"

@interface MasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    _objects = [@[@{ @"text" : @"Dolore Cosby sweater culpa food truck quinoa, photo booth proident qui Brooklyn" },
                @{ @"text" : @"Kitsch Carles Terry Richardson locavore. Messenger bag fugiat consequat nesciunt, Pitchfork aute selfies umami. Chia sint keytar consectetur, Austin Echo Park assumenda Pinterest" },
                @{ @"text" : @"Semiotics banjo minim, ex craft beer sustainable mustache Banksy paleo Schlitz Echo Park Pitchfork mollit cred. Austin bitters lomo put a bird on it, trust fund Schlitz" },
                @{ @"text" : @"kitsch whatever Tonx scenester tousled. Pinterest viral fap excepteur enim, narwhal lomo cliche commodo Shoreditch Intelligentsia minim nisi magna 8-bit" },
                @{ @"text" : @"Tumblr fugiat freegan Marfa lomo." }] mutableCopy];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    
    [_objects insertObject:@{ @"text" : ((NSDate *)[NSDate date]).description } atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DSCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DynamicHeightCell" forIndexPath:indexPath];

    NSDictionary *object = _objects[indexPath.row];
    cell.dynamicTextLabel.text = object[@"text"];
    
    // TODO: 260 comes from the width inside the storyboard
    CGSize maximumLabelSize = CGSizeMake(260, FLT_MAX);
    CGSize expectedLabelSize = [object[@"text"] sizeWithFont:cell.dynamicTextLabel.font constrainedToSize:maximumLabelSize lineBreakMode:cell.dynamicTextLabel.lineBreakMode];
    
    // adjust the label the the new height.
    CGRect newFrame = cell.dynamicTextLabel.frame;
    newFrame.size.height = expectedLabelSize.height;
    cell.dynamicTextLabel.frame = newFrame;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Without creating a cell, just calculate what its height would be
    static int pointsAboveText = 12;
    static int pointsBelowText = 12;
    
    NSDictionary *object = _objects[indexPath.row];
    
    // TODO: there is some code duplication here. In particular, instead of asking the cell, the cell's settings from
    //       the storyboard are manually duplicated here (font, wrapping).
    CGSize maximumLabelSize = CGSizeMake(260, FLT_MAX);
    CGFloat expectedLabelHeight = [object[@"text"] sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping].height;
    
    return pointsAboveText + expectedLabelHeight + pointsBelowText;
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

@end
