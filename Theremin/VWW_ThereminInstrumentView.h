//
//  VWW_ThereminInstrumentView.h
//  Theremin
//
//  Created by Zakk Hoyt on 7/29/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VWW_ThereminSynthesizerSettings.h"

@protocol VWW_ThereminInstrumentViewDelegate <NSObject>
//-(void)touchBegan;
//-(void)touchEnded;
@end

@interface VWW_ThereminInstrumentView : UIView
@property (nonatomic, assign) id <VWW_ThereminInstrumentViewDelegate> delegate;
@property (nonatomic, retain) VWW_ThereminSynthesizerSettings* settings;
@property (nonatomic, retain) UIColor* crosshairColor;
@end
