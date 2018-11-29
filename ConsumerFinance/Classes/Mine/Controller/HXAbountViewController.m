//
//  HXAbountViewController.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/5/16.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXAbountViewController.h"
#define UILABEL_LINE_SPACE 12
@interface HXAbountViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
}
@property (nonatomic,assign)float height;
@property (nonatomic,strong)NSString * contentStr;
@end

@implementation HXAbountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self editNavi];
    [self contenHeight];
    [self createUI];
    [self hiddeKeyBoard];
}
/**
 *  导航栏
 */
-(void)editNavi{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    self.title = @"关于蔻蓓丽绮";
    self.title = [NSString stringWithFormat:@"关于%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]];
    [self setNavigationBarBackgroundImage];
    [self setBackItemWithIcon:nil];
    self.view.backgroundColor = CommonBackViewColor;
}
-(void)createUI {
    /**
     *  tableView
     */
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 35, 0)];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = CommonBackViewColor;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:_tableView];
    [_tableView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.right.equalTo(self.view).offset(0);
        make.left.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
    }];
    
    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 145)];
    headView.backgroundColor = [UIColor clearColor];
    _tableView.tableHeaderView = headView;
    
//    UILabel * versionLabel = [[UILabel alloc] init];
//    versionLabel.text = SHORT_VERSION ?[NSString stringWithFormat:@"版本号: V%@",SHORT_VERSION]:@"";
//    versionLabel.font = [UIFont systemFontOfSize:12];
//    versionLabel.textColor = ComonCharColor;
//    [headView addSubview:versionLabel];
//    [versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(headView.mas_bottom).offset(-15);
//        make.centerX.equalTo(headView);
//    }];
    
    UIImageView * logoImage = [[UIImageView alloc] init];
//    logoImage.image = [UIImage imageNamed:@"ablogo"];
    //获取APP icon
    NSDictionary *infoPlist = [[NSBundle mainBundle] infoDictionary];
    NSString *icon = [[infoPlist valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject];
    logoImage.image = [UIImage imageNamed:icon];
    
    [headView addSubview:logoImage];
    [logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headView);
        make.centerY.equalTo(headView);
        make.height.mas_equalTo(100);
        make.width.mas_equalTo(100);
    }];
    
}
#pragma mark-tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentity = @"IdentityInfoCell";
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if (!cell) {
        cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
        UILabel * contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 15, SCREEN_WIDTH-60, self.height)];
//        [self setLabelSpace:contentLabel withValue:self.contentStr withFont:[UIFont systemFontOfSize:14]];
        contentLabel.numberOfLines = 0;
        contentLabel.backgroundColor = CommonBackViewColor;
        contentLabel.font = [UIFont fontWithName:@".PingFangSC-Regular" size:14];
        contentLabel.textColor = kUIColorFromRGB(0x666666);
        contentLabel.text = self.contentStr;
        [cell.contentView addSubview:contentLabel];
        cell.contentView.backgroundColor = CommonBackViewColor;
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.contentStr];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:UILABEL_LINE_SPACE];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.contentStr length])];
        contentLabel.attributedText = attributedString;
        
        [contentLabel sizeToFit];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.height;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}
-(void) hiddeKeyBoard{
    
    [self.view endEditing:YES];
    
}
-(void)contenHeight {
    self.contentStr = @"洁铖科技秉承“数据驱动”和“科技驱动”的科学经营观，以与顾客一同实现“健康、美丽、财富共拥有”为美好发展愿景。成立至今，已与国际顶尖美容科技企业、知名健康管理和医疗/美容领域专家教授，互联网大数据等独角兽企业达成战略合作。充分整合美业资源，供应链资源，将生活美容、医疗美容、健康管理，私人抗衰、教育培训及金融服务融于一体，打造线上-女性信用生活消费平台，线下-大型综合美业健康连锁实体相结合的全新生态圈！";
//    self.contentStr = [NSString stringWithFormat:@"%@是一个线下线上联动的综合型女性信用生活平台。整合综合资源打造以“新金融、新零售、新美业”创新商业模式，彻底解决B端和C端痛点，为行业良性发展奠定坚实的基础！",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]];
    self.height = [self getSpaceLabelHeight:self.contentStr withFont:[UIFont systemFontOfSize:14] withWidth:SCREEN_WIDTH-60];
}
-(CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = UILABEL_LINE_SPACE;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                          };
    
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, SCREEN_HEIGHT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}

-(void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = UILABEL_LINE_SPACE; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                          };
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    label.attributedText = attributeStr;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
