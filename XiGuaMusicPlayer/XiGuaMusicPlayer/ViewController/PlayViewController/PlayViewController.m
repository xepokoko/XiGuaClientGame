//
//  PlayViewController.m
//  XiGuaMusicPlayer
//
//  Created by little_Fking_cute on 2022/4/16.
//

#import "PlayViewController.h"
#import "Common.h"
#import "UIImage+SFFont.h"
#import "MusicPlayerCenter.h"


@interface PlayViewController ()

/// 进度条
@property (nonatomic, weak)UISlider *processSlider;
/// 音量条
@property (nonatomic, weak)UISlider *volumeSlider;

/// 收藏按钮
@property (nonatomic,weak)UIButton *likeBtn;
/// 下一首歌按钮
@property (nonatomic, weak)UIButton *forwardBtn;
/// 上一首歌按钮
@property (nonatomic, weak)UIButton *backwardBtn;
/// 播放暂停按钮
@property (nonatomic, weak)UIButton *playPauseBtn;
/// 播放模式 （随机/顺序/单曲循环）
@property  (nonatomic, weak)UIButton *playModeBtn;

@end

@implementation PlayViewController

- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
    [self.tabBarController.view.subviews lastObject].hidden = YES;
    
//    NSNotificationCenter addObserver:self forKeyPath:@ options:<#(NSKeyValueObservingOptions)#> context:<#(nullable void *)#>
}

- (void)viewWillDisappear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = NO;
    [self.tabBarController.view.subviews lastObject].hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self layoutSubviews];
    
    [[MusicPlayerCenter defaultCenter] playMusic];
}

- (void)layoutSubviews {
    CGFloat sliderW = 90;
    CGFloat sliderH = SCREENHEIGHT - 200;
    // 进度条
    CGFloat processSliderCenterX = sliderW / 2;
    CGFloat processSliderCenterY = self.view.frame.size.height / 2;
    UISlider *processSlider = [[UISlider alloc] initWithFrame:CGRectMake(0,
                                                                         0,
                                                                         sliderH,
                                                                         sliderW)];
    processSlider.center = CGPointMake(processSliderCenterX, processSliderCenterY);
    processSlider.transform = CGAffineTransformMakeRotation(-M_PI_2);
    processSlider.maximumValue = [MusicPlayerCenter defaultCenter].player.duration;
    processSlider.minimumTrackTintColor = [UIColor systemBlueColor];
    [self.view addSubview:processSlider];
    self.processSlider = processSlider;
    
    // 音量条
    CGFloat volumeSliderCenterX = SCREENWIDTH - processSliderCenterX;
    CGFloat volumeSliderCenterY = SCREENHEIGHT / 2;
    UISlider *volumeSlider = [[UISlider alloc] initWithFrame:CGRectMake(0,
                                                                        0,
                                                                        sliderH,
                                                                        sliderW)];
    volumeSlider.center = CGPointMake(volumeSliderCenterX, volumeSliderCenterY);
    volumeSlider.transform = CGAffineTransformMakeRotation(-M_PI_2);
    volumeSlider.value = [MusicPlayerCenter defaultCenter].player.volume;
    [volumeSlider addTarget:self action:@selector(changeVolume) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:volumeSlider];
    self.volumeSlider = volumeSlider;
    
    int buttonCount = 5;
    CGFloat buttonX = CGRectGetMaxX(self.processSlider.frame);
    CGFloat buttonW = CGRectGetMinX(self.volumeSlider.frame) - CGRectGetMaxX(self.processSlider.frame);\
    CGFloat buttonH = sliderH / buttonCount;
    CGFloat buttonY = CGRectGetMinY(self.processSlider.frame);
    for (int i = 0; i < buttonCount; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(buttonX,
                                                                      buttonY,
                                                                      buttonW,
                                                                      buttonH)];
        button.tintColor = [UIColor systemBlueColor];
        [self.view addSubview:button];
        switch (i) {
            case 0:
                [button setImage:[UIImage systemImageNamed:@"heart" configurationWithFontOfSize:40] forState:UIControlStateNormal];
                button.tintColor = [UIColor systemRedColor];
                [button addTarget:self action:@selector(likeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
                self.likeBtn = button;
                break;
            case 1:
                [button setImage:[UIImage systemImageNamed:@"backward.fill" configurationWithFontOfSize:40] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(backwardBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
                self.backwardBtn = button;
                break;
            case 2:
                [button setImage:[UIImage systemImageNamed:@"pause.fill" configurationWithFontOfSize:40] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(playPauseBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
                self.playPauseBtn = button;
                break;
            case 3:
                [button setImage:[UIImage systemImageNamed:@"forward.fill"configurationWithFontOfSize:40] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(forwardBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
                self.forwardBtn = button;
                break;
            case 4:
                [button setImage:[UIImage systemImageNamed:@"repeat" configurationWithFontOfSize:40] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(playModeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
                self.playModeBtn = button;
                break;
            default:
                break;
        }
        buttonY += buttonH;
    }
}

#pragma mark - 按钮点击事件
/// 点击上一首
- (void)backwardBtnClicked:(UIButton *)sender {
    
}

/// 播放暂停
- (void)playPauseBtnClicked:(UIButton *)sender {
    MusicPlayerCenter *center = [MusicPlayerCenter defaultCenter];
    
    if ([center isPlaying]) {
        [self.playPauseBtn setImage:[UIImage systemImageNamed:@"play.fill" configurationWithFontOfSize:40] forState:UIControlStateNormal];
    } else {
        [self.playPauseBtn setImage:[UIImage systemImageNamed:@"pause.fill" configurationWithFontOfSize:40] forState:UIControlStateNormal];
    }
    center.playing = !center.playing;
    [center togglePlayPause];
}

/// 点击下一首
- (void)forwardBtnClicked:(UIButton *)sender {
    
}

/// 点击收藏
- (void)likeBtnClicked:(UIButton *)sender {
    NSString *imageName = [NSString string];
    MusicPlayerCenter *center = [MusicPlayerCenter defaultCenter];
    if ([center.music isFavorite]) {
        imageName = @"heart";
    } else {
        imageName = @"heart.fill";
    }
    [self.likeBtn setImage:[UIImage systemImageNamed:imageName configurationWithFontOfSize:40] forState:UIControlStateNormal];
    center.music.favorite = !center.music.favorite;
}

/// 切换播放模式
- (void)playModeBtnClicked:(UIButton *)sender {
    [MusicPlayerCenter defaultCenter].playMode += 1;
    
    NSString *imageName = [NSString string];
    switch ([MusicPlayerCenter defaultCenter].playMode) {
        case 0:
            imageName = @"repeat";
            break;
        case 1:
            imageName = @"repeat.1";
            break;
        case 2:
            imageName = @"shuffle";
            break;
        default:
            break;
    }
    [self.playModeBtn setImage:[UIImage systemImageNamed:imageName configurationWithFontOfSize:40] forState:UIControlStateNormal];
}

/// 更改音量
- (void)changeVolume {
    [MusicPlayerCenter defaultCenter].player.volume = self.volumeSlider.value;
}


@end
