//
//  ViewController.m
//  DLStretchableTableHeaderView
//
//  Created by David on 2018/1/26.
//  Copyright © 2018年 David. All rights reserved.
//

#import "ViewController.h"
#define SCREEN_WHITH [UIScreen mainScreen].bounds.size.width
#define RATIO 1.5
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIImageView *strechableImageView;
@property(nonatomic,assign)CGRect originFrame;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect frame = CGRectMake(0, 0, SCREEN_WHITH, SCREEN_WHITH / RATIO );
    CGRect imageFrame = frame;
    imageFrame.size.height += 20;
    self.strechableImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header"]];
    self.strechableImageView.frame = imageFrame;
    self.originFrame = imageFrame;
    [self.view addSubview:self.strechableImageView];
    
    CGRect tableViewFrame = self.view.frame;
    tableViewFrame.origin.y = 20;
    tableViewFrame.size.height -=20;
    self.tableView = [[UITableView alloc] initWithFrame: tableViewFrame];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.tableView];
    UIView *headerView = [[UIView alloc] initWithFrame: frame];
    headerView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = headerView;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 15;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cell_id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = @"TableView with strechable header";
    cell.textLabel.font = [UIFont fontWithName:@"Avenir Next" size:18];
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY < 0) {
        self.strechableImageView.frame = ({
            CGRect frame = self.originFrame;
            frame.size.height = self.originFrame.size.height - offsetY;
            frame.size.width = frame.size.height * RATIO;
            frame.origin.x = self.originFrame.origin.x - (frame.size.width - self.originFrame.size.width) / 2;
            frame;
        });
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
