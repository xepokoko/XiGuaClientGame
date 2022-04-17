//
//  VoiceSearchCenter.m
//  XiGuaMusicPlayer
//
//  Created by 谢恩平 on 2022/4/17.
//
#import "VoiceSearchCenter.h"
#import "Common.h"
#import "UIImage+SFFont.h"

static VoiceSearchCenter *voiceSearchCenter;

@interface VoiceSearchCenter ()

@property (nonatomic, strong) UIButton *searchBtn;
@end


@implementation VoiceSearchCenter


- (instancetype)init {
    self = [super init];
    
    if (self) {
        
        self.view = [[UIView alloc] init];
        self.view.backgroundColor = [UIColor systemGrayColor];
        
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
    self.text = @"已搜索到歌曲陀飞轮，单击返回，双击播放";
    
}


- (void)setFrameWithRect:(CGRect )rect {
    [self.view setFrame:rect];
    
    [self.searchBtn setFrame:self.view.bounds];
    
}
#pragma mark - 设置旁白
- (void)setVoiceOver {
    
    self.isAccessibilityElement = YES;
    
    self.accessibilityLabel = @"语音搜索";
    self.accessibilityTraits = UIAccessibilityTraitButton;//设置为button
    self.accessibilityHint = @"长按，说出你想要查询歌曲的名字，松开按钮后会为您返回搜索结果";
    
    
}
@end
