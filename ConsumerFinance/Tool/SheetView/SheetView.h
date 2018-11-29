//
//  SheetView.h
//  CustomSheetView
//
//  Created by 侯荡荡 on 16/11/30.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SheetView;

@protocol SheetViewDelegate <NSObject>
@optional
- (void)sheetView:(SheetView *)sheetView sheetButtonEvent:(id)sender;
@end


@interface SheetView : UIView
@property (nonatomic,   weak) id <SheetViewDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *sheetDataSource;

- (instancetype)initWithTitle:(NSString *)title
                   dataSource:(NSMutableArray *)dataSource
                     delegate:(id <SheetViewDelegate>)delegate
             sheetButtonTitle:(NSString *)sheetButtonTitle;

- (void)displaySheetView;
- (void)closeSheetView;
@end

/*------------------------------------------------------------------------------------*/

@interface SheetViewDataModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subTitle;
@property (nonatomic, strong) NSString *content;
@end

/*------------------------------------------------------------------------------------*/
@class SheetTableViewCell;

@protocol SheetTableViewCellDelegate <NSObject>
- (void) sheetTablewViewCell:(SheetTableViewCell *)tableViewCell deleteData:(id)sneder;
@end


@interface SheetTableViewCell : UITableViewCell
- (void)setObject:(id)object;
- (void)totalCount:(NSInteger)totalCount currentIndex:(NSInteger)index;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *subTitleLabel;
@property (strong, nonatomic) UILabel *contentLabel;
@property (strong, nonatomic) UIButton *deleteButton;
@property (strong, nonatomic) CALayer *line;
@property (weak,   nonatomic) id <SheetTableViewCellDelegate> cellDelegate;
@end





