//
//  MusicModel.m
//  XiGuaMusicPlayer
//
//  Created by little_Fking_cute on 2022/4/16.
//

#import "MusicModel.h"

@implementation MusicModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self == [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype) musicModelWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

@end
