//
//  PopoverButton.h
//  EntDump
//
//  Created by Dora Orak on 22.09.2025.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface PopoverButton : NSButton

@property (nonatomic, strong) NSPopover *popover;

@end

NS_ASSUME_NONNULL_END
