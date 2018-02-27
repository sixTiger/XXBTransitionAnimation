//
//  XXBEventCell.m
//  XXBEventList
//
//  Created by baidu on 16/7/27.
//  Copyright © 2016年 com.baidu. All rights reserved.
//

#import "XXBEventCell.h"

@implementation XXBEventCell

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.contentView bringSubviewToFront:self.messageLabel];
}

- (UILabel *)messageLabel {
    if (_messageLabel == nil) {
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:self.contentView.bounds];
        [self.contentView addSubview:messageLabel];
        messageLabel.textAlignment = NSTextAlignmentLeft;
        messageLabel.backgroundColor = [UIColor redColor];
        _messageLabel = messageLabel;
    }
    return _messageLabel;
}
@end
