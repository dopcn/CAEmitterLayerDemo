//
//  LayerSetting.m
//  CAEmitterLayerDemo
//
//  Created by 纬洲 冯 on 06/04/2017.
//  Copyright © 2017 im.enai. All rights reserved.
//

#import "LayerSetting.h"
#import <objc/runtime.h>

@implementation LayerSetting

+ (instancetype)sharedInstance {
    static LayerSetting *setting = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        setting = [[LayerSetting alloc] init];
    });
    return setting;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.emitterShape = kCAEmitterLayerLine;
        self.emitterMode = kCAEmitterLayerOutline;
        self.renderMode = kCAEmitterLayerUnordered;
        
        self.birthRate = 3;
        self.velocity = 10;
        self.lifetime = 50;
        self.yAcceleration = 5;
        self.scale = 1;
    }
    return self;
}

- (NSArray<NSString *> *)propertyNames {
    unsigned int propertyCount = 0;
    objc_property_t * properties = class_copyPropertyList([self class], &propertyCount);
    
    NSMutableArray * propertyNames = [NSMutableArray array];
    for (unsigned int i = 0; i < propertyCount; ++i) {
        objc_property_t property = properties[i];
        const char * name = property_getName(property);
        [propertyNames addObject:[NSString stringWithUTF8String:name]];
    }
    free(properties);
    return [propertyNames copy];
}

@end
