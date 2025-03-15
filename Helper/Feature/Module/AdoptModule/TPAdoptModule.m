//
//  TPAdoptModule.m
//  Helper
//
//  Created by Topredator on 2025/3/12.
//

#import "TPAdoptModule.h"


#define CREATE_TABLE_ADOPT   @"CREATE TABLE IF NOT EXISTS "  TABLE_NAME_ADOPT                \
"("                                             \
" Adopt_adoptId"             " TEXT PRIMARY KEY,"        \
" Adopt_animalId"          " TEXT,"                    \
" Adopt_applicantId"          " TEXT,"                    \
" Adopt_createTime"          " TEXT,"                    \
" Adopt_status"           " INTEGER DEFAULT (0),"                     \
" Adopt_approverId"           " TEXT"                     \
")"

@implementation TPAdoptModule

@end
