//
//  ResultWindow.h
//  EntDump
//
//  Created by Dora Orak on 17.09.2025.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface ResultWindow : NSWindow
-(instancetype)initWithEntitlements:(NSArray*)entitlements ContentRect:(NSRect)contentRect styleMask:(NSWindowStyleMask)style backing:(NSBackingStoreType)backingType defer:(BOOL)flag;
@end

NS_ASSUME_NONNULL_END
