//
//  ImageAttachmentModel.h
//  ConsumerFinance
//
//  Created by 侯荡荡 on 16/8/22.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageAttachmentModel : NSObject
/*
 archivesId = 201636111108049815;
 catalog = "2016-08-22/";
 classCode = 0101;
 createTime = "2016-08-22";
 createUser = 9cf7c798c00e4e638516922e5ab7870e;
 documentId = 201636111108049815;
 fileId = fd7fbed09d3044388cc1de33e1bf4303;
 pageId = fd7fbed09d3044388cc1de33e1bf4303;
 pageName = idCardFront;
 pageOrder = 1;
 pageRemark = 0;
 pageSize = 342665;
 pageStatus = 1;
 pageType = jpeg;
 picture = "";
 thumbnailId = f9e35babdf8c458f8a2d2d87a5877591;
 updateTime = "";
 updateUser = "";
 */
@property (nonatomic, strong) NSString *archivesId;
@property (nonatomic, strong) NSString *catalog;
@property (nonatomic, strong) NSString *classCode;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *createUser;
@property (nonatomic, strong) NSString *documentId;
@property (nonatomic, strong) NSString *fileId;
@property (nonatomic, strong) NSString *pageId;
@property (nonatomic, strong) NSString *pageName;
@property (nonatomic, strong) NSString *pageOrder;
@property (nonatomic, strong) NSString *pageRemark;
@property (nonatomic, strong) NSString *pageSize;
@property (nonatomic, strong) NSString *pageStatus;
@property (nonatomic, strong) NSString *pageType;
@property (nonatomic, strong) NSString *picture;
@property (nonatomic, strong) NSString *thumbnailId;
@property (nonatomic, strong) NSString *updateTime;
@property (nonatomic, strong) NSString *updateUser;

@end
