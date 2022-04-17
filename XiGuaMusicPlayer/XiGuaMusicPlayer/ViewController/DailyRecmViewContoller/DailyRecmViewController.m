//
//  DailyRecmViewController.m
//  XiGuaMusicPlayer
//
//  Created by 谢恩平 on 2022/4/16.
//

#import "DailyRecmViewController.h"
#import "ListTableViewCell.h"
#import "VoiceBroadcastTool.h"

#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

@interface DailyRecmViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation DailyRecmViewController

- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
//    self.tabBarController.tabBar.hidden = NO;
//    UIView *view = [self.tabBarController.view.subviews lastObject];
//    
//    CGFloat tabHeight = self.tabBarController.tabBar.frame.size.height;
//
//    [view setFrame:CGRectMake(0,ScreenHeight-tabHeight-100, ScreenWidth, 100)];

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    self.title = @"每日推荐";

    VoiceBroadcastTool *VBTool = [[VoiceBroadcastTool alloc] init];
    
    [VBTool voiceBroadcastWithString:[NSString stringWithFormat:@"今日为您推荐了%ld首歌曲", self.musicList.count]];
    
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        CGFloat naviHeight = 91; //直接在图层获取的。      
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, naviHeight, ScreenWidth, ScreenHeight-naviHeight)];
        
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
    }
    return _tableView;
}


#pragma mark - Table Delegates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _musicList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *reuseID = @"DailyCell";
    
    ListTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[ListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    
    cell.musicModel = _musicList[indexPath.row];
    //获取model后设置数据。
    [cell setInfo];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return 90;
}



@end
