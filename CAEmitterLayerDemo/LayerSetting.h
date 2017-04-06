//
//  LayerSetting.h
//  CAEmitterLayerDemo
//
//  Created by 纬洲 冯 on 06/04/2017.
//  Copyright © 2017 im.enai. All rights reserved.
//

@import UIKit;

@interface LayerSetting : NSObject

+ (instancetype)sharedInstance;

- (NSArray<NSString*>*)propertyNames;

@property (nonatomic, assign) CGPoint emitterPosition;
@property (nonatomic, assign) CGFloat emitterZPosition;
@property (nonatomic, assign) CGSize emitterSize;
@property (nonatomic, assign) CGFloat emitterDepth;
@property (nonatomic, strong) NSString *emitterShape;
@property (nonatomic, strong) NSString *emitterMode;
@property (nonatomic, strong) NSString *renderMode;

@property (nonatomic, assign) CGFloat birthRate;
@property (nonatomic, assign) CGFloat lifetime;
@property (nonatomic, assign) CGFloat lifetimeRange;
@property (nonatomic, assign) CGFloat emissionLatitude;
@property (nonatomic, assign) CGFloat emissionLongitude;
@property (nonatomic, assign) CGFloat emissionRange;
@property (nonatomic, assign) CGFloat velocity;
@property (nonatomic, assign) CGFloat velocityRange;
@property (nonatomic, assign) CGFloat xAcceleration;
@property (nonatomic, assign) CGFloat yAcceleration;
@property (nonatomic, assign) CGFloat zAcceleration;
@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, assign) CGFloat scaleRange;
@property (nonatomic, assign) CGFloat scaleSpeed;
@property (nonatomic, assign) CGFloat spin;
@property (nonatomic, assign) CGFloat spinRange;

@end
