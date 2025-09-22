//
//  PopoverButton.m
//  EntDump
//
//  Created by Dora Orak on 22.09.2025.
//

#import "PopoverButton.h"

@implementation PopoverButton

- (void) showPopover:(id)sender {
    if (self.popover.isShown) {
        [self.popover close];
    } else {
        [self.popover showRelativeToRect:self.bounds ofView:self preferredEdge:NSRectEdgeMaxY];
    }
}

@end
