//
//  VoiceSearchCenter.m
//  XiGuaMusicPlayer
//
//  Created by 谢恩平 on 2022/4/17.
//
#import "VoiceSearchCenter.h"
#import "Common.h"
#import "UIImage+SFFont.h"
#import <AVFoundation/AVFoundation.h>
#import "VoiceBroadcastTool.h"


static VoiceSearchCenter *voiceSearchCenter;

@interface VoiceSearchCenter ()

@property (nonatomic, strong) UIButton *searchBtn;

@property (nonatomic, copy) NSString* displayPinYinContStr;

@end


@implementation VoiceSearchCenter


- (instancetype)init {
    self = [super init];
    
    if (self) {
        
        self.view = [[UIView alloc] init];
        self.view.backgroundColor = [UIColor whiteColor];
        
        self.searchBtn = [[UIButton alloc] init];
        
        [_searchBtn setImage:[UIImage systemImageNamed:@"mic.square" configurationWithFontOfSize:50] forState:UIControlStateNormal];
        [_searchBtn addTarget:self action:@selector(voiceSearch) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:_searchBtn];
        
        
        [self setVoiceOver];
        
        
        
        
    }
    return self;
}



+ (instancetype)defaultCenter {
    if (voiceSearchCenter == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            voiceSearchCenter = [[self alloc] init];
        });
    }
    return voiceSearchCenter;
}


- (void)voiceSearch {
   
    self.displayPinYinContStr = @"你搜索到的歌曲为：陀飞轮。双击播放";
    VoiceBroadcastTool *tool = [[VoiceBroadcastTool alloc] init];
    [tool voiceBroadcastWithString:self.displayPinYinContStr];
    //自定义聚焦的控件，用于播放指定歌曲
    UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification,  self.focusObj);
    
   
}


- (void)setFrameWithRect:(CGRect )rect {
    [self.view setFrame:rect];
    
    [self.searchBtn setFrame:self.view.bounds];
    
}
#pragma mark - 设置旁白
- (void)setVoiceOver {
    
    self.isAccessibilityElement = YES;
    
    self.searchBtn.accessibilityLabel = @"语音搜索";
    self.searchBtn.accessibilityTraits = UIAccessibilityTraitButton;//设置为button
    self.searchBtn.accessibilityHint = @"长按，说出你想要查询歌曲的名字，松开按钮后会为您返回搜索结果";
    
    
}
    
#pragma mark - 设置播报内容
@end
