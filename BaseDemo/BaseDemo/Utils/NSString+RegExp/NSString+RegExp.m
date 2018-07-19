
///////////////////////////// 正则表达式相关  ///////////////////////////////

#import "NSString+RegExp.h"

@implementation NSString(RegExp)

- (BOOL)isValidateWithRegex:(NSString *)regex
{
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pre evaluateWithObject:self];
}

/** 字符串判空处理 */
-(BOOL)isNull;{
    NSString *object = [self copy];
    if ([object isEqual:@""]) {
       return YES;
    }
    return NO;
}

/* 邮箱验证 MODIFIED BY HELENSONG */
- (BOOL)isValidEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailPred evaluateWithObject:self];
}

/* 手机号码验证 MODIFIED BY HELENSONG */
- (BOOL)isValidPhoneNum
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(147)|(15[^4,\\D])|(17[0-9])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phonePred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phonePred evaluateWithObject:self];
}

/* 车牌号验证 MODIFIED BY HELENSONG */
- (BOOL)isValidCarNo
{
    NSString *carRegex = @"^[A-Za-z]{1}[A-Za-z_0-9]{5}$";
    NSPredicate *carPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    return [carPred evaluateWithObject:self];
}

/** 网址验证 */
- (BOOL)isValidUrl
{
    NSString *regex = @"^((http)|(https))+:[^\\s]+\\.[^\\s]*$";
    return [self isValidateWithRegex:regex];
}

/** 邮政编码 */
- (BOOL)isValidPostalcode {
    NSString *phoneRegex = @"^[0-8]\\d{5}(?!\\d)$";
    NSPredicate *phonePred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phonePred evaluateWithObject:self];
}
/** 纯数字 */
- (BOOL)isValidNumber;{
    NSString *numberRegex =@"[0-9]*";
    NSPredicate *numberPred  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",numberRegex];
    return [numberPred evaluateWithObject:self ];
}

/** 纯英文 */
- (BOOL)isValidEnglish;{
    NSString *englishRegex =@"[a-zA-Z]*";
    NSPredicate *englishPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",englishRegex];
    return [englishPred evaluateWithObject:self];
}

/** 仅输入字母或数字 */
- (BOOL)isValidEnglishOrNumber;{
    NSString *engORnumRegex =@"[a-zA-Z0-9]*";
    NSPredicate *engORnumPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",engORnumRegex];
    return [engORnumPred evaluateWithObject:self];
}

/** 纯汉字 */
- (BOOL)isValidChinese;
{
    NSString *phoneRegex = @"^[\u4e00-\u9fa5]+$";
    NSPredicate *phonePred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phonePred evaluateWithObject:self];
}

/**
 @brief     是否符合IP格式，xxx.xxx.xxx.xxx
 */
- (BOOL)isValidIP;
{
    NSString *regex = [NSString stringWithFormat:@"^(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})$"];
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL rc = [pre evaluateWithObject:self];
    
    if (rc) {
        NSArray *componds = [self componentsSeparatedByString:@","];
        
        BOOL v = YES;
        for (NSString *s in componds) {
            if (s.integerValue > 255) {
                v = NO;
                break;
            }
        }
        
        return v;
    }
    
    return NO;
}

/** 身份证验证 refer to http://blog.csdn.net/afyzgh/article/details/16965107 */
- (BOOL)isValidIdCardNum
{
    NSString *value = [self copy];
    value = [value stringByReplacingOccurrencesOfString:@"X" withString:@"x"];
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    int length = 0;
    if (!value) {
        return NO;
    }else {
        length = (int)value.length;
        if (length != 15 && length !=18) {
            return NO;
        }
    }
    // 省份代码
    NSArray *areasArray =@[@"11", @"12", @"13", @"14", @"15", @"21", @"22", @"23", @"31", @"32", @"33", @"34", @"35", @"36", @"37", @"41", @"42", @"43", @"44", @"45", @"46", @"50", @"51", @"52", @"53", @"54", @"61", @"62", @"63", @"64", @"65", @"71", @"81", @"82", @"91"];
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag = NO;
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag = YES;
            break;
        }
    }
    if (!areaFlag) {
        return NO;
    }
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    int year = 0;
    switch (length) {
        case 15:
            year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
            if (year % 4 ==0 || (year % 100 ==0 && year % 4 ==0)) {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"                   options:NSRegularExpressionCaseInsensitive error:nil];// 测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"           options:NSRegularExpressionCaseInsensitive error:nil];// 测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value options:NSMatchingReportProgress range:NSMakeRange(0, value.length)];
            if(numberofMatch > 0) {
                return YES;
            }else {
                return NO;
            }
        case 18:
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year % 4 ==0 || (year % 100 ==0 && year % 4 ==0)) {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19|20[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"options:NSRegularExpressionCaseInsensitive error:nil];// 测试出生日期的合法性
                
            }else {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19|20[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                         options:NSRegularExpressionCaseInsensitive error:nil];// 测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value options:NSMatchingReportProgress range:NSMakeRange(0, value.length)];
            if(numberofMatch > 0) {
                int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                int Y = S % 11;
                NSString *M = @"F";
                NSString *JYM = @"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)]; // 判断校验位
                if ([M isEqualToString:[[value substringWithRange:NSMakeRange(17,1)] uppercaseString]]) {
                    return YES;// 检测ID的校验位
                }else {
                    return NO;
                }
            }else {
                return NO;
            }
            
        default:
            return NO;
    }
    return NO;
}

/** 银行卡验证*/
- (BOOL)isBankCard;{
   NSString *cardNumber = [self copy];
    if(cardNumber.length==0){
        return NO;
    }
    
    NSString *digitsOnly = @"";
    char c;
    
    for (int i = 0; i < cardNumber.length; i++){
        
        c = [cardNumber characterAtIndex:i];
    
        if (isdigit(c)){
            
            digitsOnly =[digitsOnly stringByAppendingFormat:@"%c",c];
            
         }
        }
    
    int sum = 0;
    int digit = 0;
    int addend = 0;
    
    BOOL timesTwo = false;
    
    for (NSInteger i = digitsOnly.length - 1; i >= 0; i--){
        digit = [digitsOnly characterAtIndex:i] - '0';
        if (timesTwo)
        {
            addend = digit * 2;
            if (addend > 9) {
                addend -= 9;
            }
        }else {
           addend = digit;
        }
        
        sum += addend;
        timesTwo = !timesTwo;
    }
    int modulus = sum % 10;
    return modulus == 0;
    
}

/**
 @brief     是否符合最小长度、最长长度，是否包含中文,首字母是否可以为数字
 @param     minLenth 账号最小长度
 @param     maxLenth 账号最长长度
 @param     containChinese 是否包含中文
 @param     firstCannotBeDigtal 首字母不能为数字
 @return    正则验证成功返回YES, 否则返回NO
 */
- (BOOL)isValidWithMinLenth:(NSInteger)minLenth
                   maxLenth:(NSInteger)maxLenth
             containChinese:(BOOL)containChinese
        firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;
{
    NSString *hanzi = containChinese ? @"\u4e00-\u9fa5" : @"";
    NSString *first = firstCannotBeDigtal ? @"^[a-zA-Z_]" : @"";
    
    NSString *regex = [NSString stringWithFormat:@"%@[%@A-Za-z0-9_]{%d,%d}", first, hanzi, (int)(minLenth-1), (int)(maxLenth-1)];
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pre evaluateWithObject:self];
}

/**
 @brief     是否符合最小长度、最长长度，是否包含中文,数字，字母，其他字符，首字母是否可以为数字
 @param     minLenth 账号最小长度
 @param     maxLenth 账号最长长度
 @param     containChinese 是否包含中文
 @param     containDigtal   包含数字
 @param     containLetter   包含字母
 @param     containOtherCharacter   其他字符
 @param     firstCannotBeDigtal 首字母不能为数字
 @return    正则验证成功返回YES, 否则返回NO
 */
- (BOOL)isValidWithMinLenth:(NSInteger)minLenth
                   maxLenth:(NSInteger)maxLenth
             containChinese:(BOOL)containChinese
              containDigtal:(BOOL)containDigtal
              containLetter:(BOOL)containLetter
      containOtherCharacter:(NSString *)containOtherCharacter
        firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;
{
    NSString *hanzi = containChinese ? @"\u4e00-\u9fa5" : @"";
    NSString *first = firstCannotBeDigtal ? @"^[a-zA-Z_]" : @"";
    NSString *lengthRegex = [NSString stringWithFormat:@"(?=^.{%@,%@}$)", @(minLenth), @(maxLenth)];
    NSString *digtalRegex = containDigtal ? @"(?=(.*\\d.*){1})" : @"";
    NSString *letterRegex = containLetter ? @"(?=(.*[a-zA-Z].*){1})" : @"";
    NSString *characterRegex = [NSString stringWithFormat:@"(?:%@[%@A-Za-z0-9%@]+)", first, hanzi, containOtherCharacter ? containOtherCharacter : @""];
    NSString *regex = [NSString stringWithFormat:@"%@%@%@%@", lengthRegex, digtalRegex, letterRegex, characterRegex];
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pre evaluateWithObject:self];
}

/** 去掉两端空格和换行符 */
- (NSString *)stringByTrimmingBlank
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

/** 去掉html格式 */
- (NSString *)removeHtmlFormat;
{
    NSString *str = [NSString stringWithFormat:@"%@", self];
    
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<[^>]*>" options:NSRegularExpressionCaseInsensitive error:&error];
    if (!error) {
        str = [regex stringByReplacingMatchesInString:str options:0 range:NSMakeRange(0, str.length) withTemplate:@"$2$1"];
    } else {
            NSLog(@"%@", error);
    }
    
    NSArray *html_code = @[
                           @"\"", @"'", @"&", @"<", @">",
                           @"", @"¡", @"¢", @"£", @"¤",
                           @"¥", @"¦", @"§", @"¨", @"©",
                           @"ª", @"«", @"¬", @"", @"®",
                           @"¯", @"°", @"±", @"²", @"³",
                           
                           @"´", @"µ", @"¶", @"·", @"¸",
                           @"¹", @"º", @"»", @"¼", @"½",
                           @"¾", @"¿", @"×", @"÷", @"À",
                           @"Á", @"Â", @"Ã", @"Ä", @"Å",
                           @"Æ", @"Ç", @"È", @"É", @"Ê",
                           
                           @"Ë", @"Ì", @"Í", @"Î", @"Ï",
                           @"Ð", @"Ñ", @"Ò", @"Ó", @"Ô",
                           @"Õ", @"Ö", @"Ø", @"Ù", @"Ú",
                           @"Û", @"Ü", @"Ý", @"Þ", @"ß",
                           @"à", @"á", @"â", @"ã", @"ä",
                           
                           @"å", @"æ", @"ç", @"è", @"é",
                           @"ê", @"ë", @"ì", @"í", @"î",
                           @"ï", @"ð", @"ñ", @"ò", @"ó",
                           @"ô", @"õ", @"ö", @"ø", @"ù",
                           @"ú", @"û", @"ü", @"ý", @"þ",
                           
                           @"ÿ", @"∀", @"∂", @"∃", @"∅",
                           @"∇", @"∈", @"∉", @"∋", @"∏",
                           @"∑", @"−", @"∗", @"√", @"∝",
                           @"∞", @"∠", @"∧", @"∨", @"∩",
                           @"∪", @"∫", @"∴", @"∼", @"≅",
                           
                           @"≈", @"≠", @"≡", @"≤", @"≥",
                           @"⊂", @"⊃", @"⊄", @"⊆", @"⊇",
                           @"⊕", @"⊗", @"⊥", @"⋅", @"Α",
                           @"Β", @"Γ", @"Δ", @"Ε", @"Ζ",
                           @"Η", @"Θ", @"Ι", @"Κ", @"Λ",
                           
                           @"Μ", @"Ν", @"Ξ", @"Ο", @"Π",
                           @"Ρ", @"Σ", @"Τ", @"Υ", @"Φ",
                           @"Χ", @"Ψ", @"Ω", @"α", @"β",
                           @"γ", @"δ", @"ε", @"ζ", @"η",
                           @"θ", @"ι", @"κ", @"λ", @"μ",
                           
                           @"ν", @"ξ", @"ο", @"π", @"ρ",
                           @"ς", @"σ", @"τ", @"υ", @"φ",
                           @"χ", @"ψ", @"ω", @"ϑ", @"ϒ",
                           @"ϖ", @"Œ", @"œ", @"Š", @"š",
                           @"Ÿ", @"ƒ", @"ˆ", @"˜", @"",
                           
                           @"", @"", @"", @"", @"",
                           @"", @"–", @"—", @"‘", @"’",
                           @"‚", @"“", @"”", @"„", @"†",
                           @"‡", @"•", @"…", @"‰", @"′",
                           @"″", @"‹", @"›", @"‾", @"€",
                           
                           @"™", @"←", @"↑", @"→", @"↓",
                           @"↔", @"↵", @"⌈", @"⌉", @"⌊",
                           @"⌋", @"◊", @"♠", @"♣", @"♥",
                           @"♦",
                           ];
    NSArray *code = @[
                      @"&quot;", @"&apos;", @"&amp;", @"&lt;", @"&gt;",
                      @"&nbsp;", @"&iexcl;", @"&cent;", @"&pound;", @"&curren;",
                      @"&yen;", @"&brvbar;", @"&sect;", @"&uml;", @"&copy;",
                      @"&ordf;", @"&laquo;", @"&not;", @"&shy;", @"&reg;",
                      @"&macr;", @"&deg;", @"&plusmn;", @"&sup2;", @"&sup3;",
                      
                      @"&acute;", @"&micro;", @"&para;", @"&middot;", @"&cedil;",
                      @"&sup1;", @"&ordm;", @"&raquo;", @"&frac14;", @"&frac12;",
                      @"&frac34;", @"&iquest;", @"&times;", @"&divide;", @"&Agrave;",
                      @"&Aacute;", @"&Acirc;", @"&Atilde;", @"&Auml;", @"&Aring;",
                      @"&AElig;", @"&Ccedil;", @"&Egrave;", @"&Eacute;", @"&Ecirc;",
                      
                      @"&Euml;", @"&Igrave;", @"&Iacute;", @"&Icirc;", @"&Iuml;",
                      @"&ETH;", @"&Ntilde;", @"&Ograve;", @"&Oacute;", @"&Ocirc;",
                      @"&Otilde;", @"&Ouml;", @"&Oslash;", @"&Ugrave;", @"&Uacute;",
                      @"&Ucirc;", @"&Uuml;", @"&Yacute;", @"&THORN;", @"&szlig;",
                      @"&agrave;", @"&aacute;", @"&acirc;", @"&atilde;", @"&auml;",
                      
                      @"&aring;", @"&aelig;", @"&ccedil;", @"&egrave;", @"&eacute;",
                      @"&ecirc;", @"&euml;", @"&igrave;", @"&iacute;", @"&icirc;",
                      @"&iuml;", @"&eth;", @"&ntilde;", @"&ograve;", @"&oacute;",
                      @"&ocirc;", @"&otilde;", @"&ouml;", @"&oslash;", @"&ugrave;",
                      @"&uacute;", @"&ucirc;", @"&uuml;", @"&yacute;", @"&thorn;",
                      
                      @"&yuml;", @"&forall;", @"&part;", @"&exists;", @"&empty;",
                      @"&nabla;", @"&isin;", @"&notin;", @"&ni;", @"&prod;",
                      @"&sum;", @"&minus;", @"&lowast;", @"&radic;", @"&prop;",
                      @"&infin;", @"&ang;", @"&and;", @"&or;", @"&cap;",
                      @"&cup;", @"&int;", @"&there4;", @"&sim;", @"&cong;",
                      
                      @"&asymp;", @"&ne;", @"&equiv;", @"&le;", @"&ge;",
                      @"&sub;", @"&sup;", @"&nsub;", @"&sube;", @"&supe;",
                      @"&oplus;", @"&otimes;", @"&perp;", @"&sdot;", @"&Alpha;",
                      @"&Beta;", @"&Gamma;", @"&Delta;", @"&Epsilon;", @"&Zeta;",
                      @"&Eta;", @"&Theta;", @"&Iota;", @"&Kappa;", @"&Lambda;",
                      
                      @"&Mu;", @"&Nu;", @"&Xi;", @"&Omicron;", @"&Pi;",
                      @"&Rho;", @"&Sigma;", @"&Tau;", @"&Upsilon;", @"&Phi;",
                      @"&Chi;", @"&Psi;", @"&Omega;", @"&alpha;", @"&beta;",
                      @"&gamma;", @"&delta;", @"&epsilon;", @"&zeta;", @"&eta;",
                      @"&theta;", @"&iota;", @"&kappa;", @"&lambda;", @"&mu;",
                      
                      @"&nu;", @"&xi;", @"&omicron;", @"&pi;", @"&rho;",
                      @"&sigmaf;", @"&sigma;", @"&tau;", @"&upsilon;", @"&phi;",
                      @"&chi;", @"&psi;", @"&omega;", @"&thetasym;", @"&upsih;",
                      @"&piv;", @"&OElig;", @"&oelig;", @"&Scaron;", @"&scaron;",
                      @"&Yuml;", @"&fnof;", @"&circ;", @"&tilde;", @"&ensp;",
                      
                      @"&emsp;", @"&thinsp;", @"&zwnj;", @"&zwj;", @"&lrm;",
                      @"&rlm;", @"&ndash;", @"&mdash;", @"&lsquo;", @"&rsquo;",
                      @"&sbquo;", @"&ldquo;", @"&rdquo;", @"&bdquo;", @"&dagger;",
                      @"&Dagger;", @"&bull;", @"&hellip;", @"&permil;", @"&prime;",
                      @"&Prime;", @"&lsaquo;", @"&rsaquo;", @"&oline;", @"&euro;",
                      
                      @"&trade;", @"&larr;", @"&uarr;", @"&rarr;", @"&darr;",
                      @"&harr;", @"&crarr;", @"&lceil;", @"&rceil;", @"&lfloor;",
                      @"&rfloor;", @"&loz;", @"&spades;", @"&clubs;", @"&hearts;",
                      @"&diams;",
                      ];
    
    NSInteger idx = 0;
    for (NSString *obj in code) {
        str = [str stringByReplacingOccurrencesOfString:(NSString *)obj withString:html_code[idx]];
        idx++;
    }
    return str;
}

/** 工商税号 */
- (BOOL)isValidTaxNo
{
    NSString *emailRegex = @"[0-9]\\d{13}([0-9]|X)$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

/** 字符串是否含有emoji */
- (BOOL)isStringContrainsEmoji{
    
    NSString *string = [self copy];
    
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, string.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        const unichar hs = [substring characterAtIndex:0];
        if (0xd800 <= hs && hs <= 0xdbff) {
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    returnValue = YES;
                }
            }
        } else if (substring.length > 1) {
            const unichar ls = [substring characterAtIndex:1];
            if (ls == 0x20e3) {
                returnValue = YES;
            }
        } else {
            if (0x2100 <= hs && hs <= 0x27ff) {
                returnValue = YES;
            } else if (0x2B05 <= hs && hs <= 0x2b07) {
                returnValue = YES;
            } else if (0x2934 <= hs && hs <= 0x2935) {
                returnValue = YES;
            } else if (0x3297 <= hs && hs <= 0x3299) {
                returnValue = YES;
            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                returnValue = YES;
            }
        }
    }];
    return returnValue;
}

@end
