//
//  PlayViewController.m
//  XiGuaMusicPlayer
//
//  Created by little_Fking_cute on 2022/4/16.
//

#import "PlayViewController.h"
#import "Common.h"
#import "UIImage+SFFont.h"


@interface PlayViewController ()

/// 进度条
@property (nonatomic, weak)UISlider *processSlider;

/// 音量条
@property (nonatomic, weak)UISlider *volumeSlider;

/// 下一首歌按钮
@property (nonatomic, weak)UIButton *forwardBtn;

/// 上一首歌按钮
@property (nonatomic, weak)UIButton *backwardBtn;

/// 播放暂停按钮
@property (nonatomic, weak)UIButton *playPauseBtn;

@end

@implementation PlayViewController

- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self layoutSubviews];
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
    [self.view addSubview:volumeSlider];
    self.volumeSlider = volumeSlider;
    
    CGFloat buttonX = CGRectGetMaxX(self.processSlider.frame);
    CGFloat buttonW = CGRectGetMinX(self.volumeSlider.frame) - CGRectGetMaxX(self.processSlider.frame);\
    CGFloat buttonH = sliderH / 3;
    CGFloat buttonY = CGRectGetMinY(self.processSlider.frame);
    for (int i = 0; i < 3; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(buttonX,
                                                                      buttonY,
                                                                      buttonW,
                                                                      buttonH)];
        button.tintColor = [UIColor systemBlueColor];
        [self.view addSubview:button];
        switch (i) {
            case 0:
                [button setImage:[UIImage systemImageNamed:@"backward.fill" configurationWithFontOfSize:40] forState:UIControlStateNormal];
                self.backwardBtn = button;
                break;
            case 1:
                [button setImage:[UIImage systemImageNamed:@"play.fill" configurationWithFontOfSize:40] forState:UIControlStateNormal];
                self.playPauseBtn = button;
                break;
            case 2:
                [button setImage:[UIImage systemImageNamed:@"forward.fill"configurationWithFontOfSize:40] forState:UIControlStateNormal];
                break;
            default:
                break;
        }
        buttonY += buttonH;
    }
}

@end
