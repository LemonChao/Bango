//
//  MethodHeader.h
//  Bango
//
//  Created by zchao on 2019/3/7.
//  Copyright © 2019 zchao. All rights reserved.
//

#ifndef MethodHeader_h
#define MethodHeader_h

/**拼接字符串(用法：StringFormat(@"5s%@",@"str")*/
#define StringFormat(format,...)[NSString stringWithFormat:format,##__VA_ARGS__]


#endif /* MethodHeader_h */
