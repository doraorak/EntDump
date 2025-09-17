//
//  CopyableTextField.m
//  EntDump
//
//  Created by Dora Orak on 17.09.2025.
//

#import "CopyableTextField.h"

@implementation CopyableTextField

- (void)copyText:(id)sender {
    NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
    [pasteboard clearContents];
    [pasteboard setString:self.stringValue forType:NSPasteboardTypeString];
}

@end
