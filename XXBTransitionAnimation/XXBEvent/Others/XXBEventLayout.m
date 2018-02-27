//
//  XXBEventLayout.m
//  XXBEventList
//
//  Created by baidu on 16/7/27.
//  Copyright © 2016年 com.baidu. All rights reserved.
//

#import "XXBEventLayout.h"

@interface XXBEventLayout ()
{
    CGFloat _horizonallyPadding;
    CGFloat _verticallyPadding;
    CGFloat _screenWidth;
    CGFloat _screenHeight;
    CGFloat _cellWidth;
    CGFloat _cellHeight;
    CGFloat _SpringFactor;
}
@property(nonatomic ,assign) CGFloat horizonallyPadding;
@property(nonatomic ,assign) CGFloat verticallyPadding;
@property(nonatomic ,assign) CGFloat screenWidth;
@property(nonatomic ,assign) CGFloat screenHeight;
@property(nonatomic ,assign) CGFloat cellWidth;
@property(nonatomic ,assign) CGFloat cellHeight;
@property(nonatomic ,assign) CGFloat SpringFactor;
@end

@implementation XXBEventLayout

- (instancetype)init {
    if (self = [super init]) {
        [self initData];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initData];
    }
    return self;
}

- (void)initData {
    _horizonallyPadding = 10;
    _verticallyPadding = 10;
    _screenWidth = [UIScreen mainScreen].bounds.size.width;
    _screenHeight = [UIScreen mainScreen].bounds.size.height;
    _cellWidth = _screenWidth - 2 * _horizonallyPadding;
    _cellHeight = 45;
    _SpringFactor = 10;
    self.itemSize = CGSizeMake(_cellWidth, _cellHeight);
    self.headerReferenceSize = CGSizeMake(_screenWidth, _SpringFactor);
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    CGFloat offsetY = self.collectionView.contentOffset.y;
    NSArray *attrsArray = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray *newAttrsArray = [NSMutableArray array];
    CGFloat collectionViewFrameHeight = self.collectionView.frame.size.height;
    CGFloat collectionViewContentHeight = self.collectionView.contentSize.height;
    CGFloat ScrollViewContentInsetBottom = self.collectionView.contentInset.bottom;
    CGFloat bottomOffset = offsetY + collectionViewFrameHeight - collectionViewContentHeight - ScrollViewContentInsetBottom;
    NSUInteger numOfItems = self.collectionView.numberOfSections;
    
    for (UICollectionViewLayoutAttributes *attr in attrsArray) {
        if (attr.representedElementCategory == UICollectionElementCategoryCell) {
            CGRect cellRect = attr.frame;
            if (offsetY <= 0) {
                CGFloat distance = fabs(offsetY) / self.SpringFactor;
                cellRect.origin.y += offsetY + distance * (CGFloat)(attr.indexPath.section + 1);
            }else if (bottomOffset > 0) {
                CGFloat distance = bottomOffset / self.SpringFactor;
                cellRect.origin.y += bottomOffset - distance *
                (CGFloat)(numOfItems - attr.indexPath.section);
            }
            //            attr.frame = cellRect;
            UICollectionViewLayoutAttributes *newAttr = [attr copy];
            newAttr.frame = cellRect;
            [newAttrsArray addObject:newAttr];
        }
    }
    return newAttrsArray;
}
@end
