//
//  DailyRecmViewController.m
//  XiGuaMusicPlayer
//
//  Created by 谢恩平 on 2022/4/16.
//

#import "DailyRecmViewController.h"
#import "ListTableViewCell.h"
#import "VoiceBroadcastTool.h"
#import "MusicPlayerCenter.h"
#import "PlayViewController.h"

#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

@interface DailyRecmViewController ()<UITableViewDelegate, UITableViewDataSource,MusicPlayerCenterDelegate>

@property (nonatomic, strong) UITableView *tableView;

/// 记录选中的歌曲的 indexPath
@property (nonatomic, strong)NSIndexPath *selectedIndexPath;

@end

@implementation DailyRecmViewController

- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
    
    [MusicPlayerCenter defaultCenter].delegate = self;
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

//    VoiceBroadcastTool *VBTool = [[VoiceBroadcastTool alloc] init];
//    
//    [VBTool voiceBroadcastWithString:[NSString stringWithFormat:@"今日为您推荐了%ld首歌曲", self.musicList.count]];
//    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_selectedIndexPath == indexPath) {
        // 正在播放歌曲，且点击的 cell 正在播放
        // 直接 push
        PlayViewController *controller = [[PlayViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
        return;
    }
    
    // 没有播放歌曲
    MusicModel *music = self.musicList[indexPath.row];
    MusicPlayerCenter *center = [MusicPlayerCenter defaultCenter];
    center.music = music;
    if (center.progressTimer == nil) {
        center.progressTimer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"updateProgressNotification" object:nil];
        }];
    }
    PlayViewController *controller = [[PlayViewController alloc] init];
    _selectedIndexPath = indexPath;
    
    [self.navigationController pushViewController:controller animated:YES];
}


#pragma mark - MusicPlayerCenterDelegate
- (void)playLastMusicWithPlayMode:(MusicPlayMode)playMode {
    MusicPlayerCenter *center = [MusicPlayerCenter defaultCenter];
    MusicModel *music = [[MusicModel alloc] init];
    NSInteger newRow = 0;
    switch (playMode) {
        case MusicPlayModeRepeat:
            newRow = _selectedIndexPath.row - 1;
            break;
        case MusicPlayModeShuffle:
            // 防止随到同一首
            newRow = _selectedIndexPath.row - arc4random() % (_musicList.count - 1) - 1;
            break;
        default:
            break;
    }
    if (newRow < 0) {
        newRow += _musicList.count;
    }
    
    music = _musicList[newRow];
    center.music = music;
    self.selectedIndexPath = [NSIndexPath indexPathForRow:newRow inSection:_selectedIndexPath.section];
}

- (void)playNextMusicWithPlayMode:(MusicPlayMode)playMode {
    MusicPlayerCenter *center = [MusicPlayerCenter defaultCenter];
    MusicModel *music = [[MusicModel alloc] init];
    NSInteger newRow = 0;
    switch (playMode) {
        case MusicPlayModeRepeat:
            newRow =_selectedIndexPath.row + 1;
            break;
        case MusicPlayModeShuffle:
            newRow = _selectedIndexPath.row + arc4random() % (_musicList.count - 1) + 1;
            break;
        default:
            break;
    }
    if (newRow >= _musicList.count) {
        newRow -= _musicList.count;
    }
    
    music = _musicList[newRow];
    center.music = music;
    self.selectedIndexPath = [NSIndexPath indexPathForRow:newRow inSection:_selectedIndexPath.section];
}


@end
