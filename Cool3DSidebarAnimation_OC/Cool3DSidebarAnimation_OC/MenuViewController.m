//
//  MenuViewController.m
//  Cool3DSidebarAnimation_OC
//
//  Created by Mazy on 2017/8/3.
//  Copyright © 2017年 Mazy. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuItemCell.h"
#import "ViewController.h"

@interface MenuViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *menuItems;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource: @"MenuItems" ofType: @"plist"];
    
    self.menuItems = [NSArray arrayWithContentsOfFile: path];
    
    self.tableView.rowHeight = self.tableView.bounds.size.height / self.menuItems.count;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    ViewController *parentVC = (ViewController *)self.navigationController.parentViewController;

    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        
        NSDictionary *object = _menuItems[indexPath.row];
        DetailViewController *detailVC = (DetailViewController *)segue.destinationViewController;
        detailVC.menuItem = object;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuItemCell *cell = [tableView dequeueReusableCellWithIdentifier: @"menuItemCell" forIndexPath:indexPath];
    NSDictionary *dict = self.menuItems[indexPath.row];
    [cell configForMenuItem:dict];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *item = self.menuItems[indexPath.row];
    ViewController *vc = (ViewController *)self.navigationController.parentViewController;
    vc.menuItem = item;
}

@end
