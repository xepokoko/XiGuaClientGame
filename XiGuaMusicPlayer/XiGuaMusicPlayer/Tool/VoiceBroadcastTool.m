//
//  VoiceBroadcastTool.m
//  XiGuaMusicPlayer
//
//  Created by 谢恩平 on 2022/4/17.
//

#import "VoiceBroadcastTool.h"

@implementation VoiceBroadcastTool

- (void)voiceBroadcastWithString:(NSString *)str {
    NSString *oriString = str;

    if ([oriString isEqualToString:@""]) {
        oriString = @"没有听清楚，请重新说一遍";
        return;
    }
    //舌头
    _utterance=[[AVSpeechUtterance alloc] initWithString:oriString];
    //如果识别中文，需设置voice参数
    NSArray*voices=@[[AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"],[AVSpeechSynthesisVoice voiceWithLanguage:@"en-US"],[AVSpeechSynthesisVoice voiceWithLanguage:@"ja-JP"]];
    _utterance.voice=voices[0];
    //语速
    _utterance.rate=0.5;
    //音量
    _utterance.volume=0.8;
    //音调
    _utterance.pitchMultiplier=1;
    
    //通过嘴巴用舌头说话
    [_synthesizer speakUtterance:_utterance];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _synthesizer = [[AVSpeechSynthesizer alloc] init];
    }
    
    return self;
}

@end
