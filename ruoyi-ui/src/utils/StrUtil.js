/**
 * 字符串工具类
 **/
export const StrUtil = {
  /**
   * 字符串是否为空白 空白的定义如下： <br>
   * 1、为null <br>
   * 2、为不可见字符（如空格）<br>
   * 3、""<br>
   *
   * @param str 被检测的字符串
   * @return boolean 是否为空
   */
  isBlank: function (str) {
    return str === undefined || str == null || this.trim(str) === "";

  },
  /**
   * 字符串是否为非空白 空白的定义如下： <br>
   * 1、不为null <br>
   * 2、不为不可见字符（如空格）<br>
   * 3、不为""<br>
   *
   * @param str 被检测的字符串
   * @return boolean 是否为非空
   */
  isNotBlank: function (str) {
    // == 代表相同,=== 代表严格相同
    return false === StrUtil.isBlank(str);
  },
  /**
   * 字符串是否为空，空的定义如下:<br>
   * 1、为null <br>
   * 2、为""<br>
   *
   * @param str 被检测的字符串
   * @return boolean 是否为空
   */
  isEmpty: function (str) {
    return str == null || str === "";

  },
  /**
   * 字符串是否为非空白 空白的定义如下： <br>
   * 1、不为null <br>
   * 2、不为""<br>
   *
   * @param str 被检测的字符串
   * @return boolean 是否为非空
   */
  isNotEmpty: function (str) {
    return !StrUtil.isEmpty(str);
  },
  /**
   * 空对象转字符串
   *
   * @param str 被检查的字符串
   * @return string 原字符串或者空串
   */
  nullToStr: function (str) {
    if (StrUtil.isEmpty(str)) {
      return "";
    }
    return str;
  },
  /**
   * 空格截取
   *
   * @param str 截取的字符串
   * @return string
   */
  trim: function (str) {
    if (str == null) {
      return "";
    }
    return str.toString().replace(/(^\s*)|(\s*$)|\r|\n/g, "");
  },
  /**
   * 比较两个字符串（大小写敏感）
   *
   * @param str 字符串
   * @param that 比较的字符串
   * @return boolean
   */
  equals: function (str, that) {
    return str === that;
  },
  /**
   * 比较两个字符串（大小写不敏感）
   *
   * @param str 字符串
   * @param that 比较的字符串
   * @return boolean
   */
  equalsIgnoreCase: function (str, that) {
    return String(str).toUpperCase() === String(that).toUpperCase();
  },
  /**
   * 将字符串按指定字符分割
   *
   * @param str 字符串
   * @param sep 比较的字符串
   * @param maxLen 最大长度
   * @return string[] 分割后的数组
   */
  split: function (str, sep, maxLen) {
    if (StrUtil.isEmpty(str)) {
      return null;
    }
    const value = String(str).split(sep);
    return maxLen ? value.slice(0, maxLen - 1) : value;
  },
  /**
   * 字符串格式化(%s )
   *
   * @param str 字符串
   * @return 格式化后的字符串
   */
  sprintf: function (str) {
    let args = arguments, flag = true, i = 1;
    str = str.replace(/%s/g, function () {
      const arg = args[i++];
      if (typeof arg === 'undefined') {
        flag = false;
        return '';
      }
      return arg;
    });
    return flag ? str : '';
  },
  /**
   * 判断字符串是否是以start开头
   *
   * @param str 字符串
   * @param start 开始的字符串
   * @return boolean
   */
  startWith: function (str, start) {
    const reg = new RegExp("^" + start);
    return reg.test(str);
  },
  /**
   * 判断字符串是否是以end结尾
   *
   * @param str 字符串
   * @param end 结尾的字符串
   * @return boolean
   */
  endWith: function (str, end) {
    const reg = new RegExp(end + "$");
    return reg.test(str);
  },
  containsWhitespace: function (input) {
    return this.contains(input, ' ');
  },
  //生成指定个数的字符
  repeat: function (ch, repeatTimes) {
    let result = "";
    for (let i = 0; i < repeatTimes; i++) {
      result += ch;
    }
    return result;
  },
  deleteWhitespace: function (input) {
    return input.replace(/\s+/g, '');
  },
  rightPad: function (input, size, padStr) {
    return input + this.repeat(padStr, size);
  },
  leftPad: function (input, size, padStr) {
    return this.repeat(padStr, size) + input;
  },
  //首小写字母转大写
  capitalize: function (input) {
    let strLen = 0;
    if (input == null || (strLen = input.length) === 0) {
      return input;
    }
    return input.replace(/^[a-z]/, function (matchStr) {
      return matchStr.toLocaleUpperCase();
    });
  },
  //首大写字母转小写
  uncapitalize: function (input) {
    let strLen = 0;
    if (input == null || (strLen = input.length) === 0) {
      return input;
    }
    return input.replace(/^[A-Z]/, function (matchStr) {
      return matchStr.toLocaleLowerCase();
    });
  },
  //大写转小写，小写转大写
  swapCase: function (input) {
    return input.replace(/[a-z]/ig, function (matchStr) {
      if (matchStr >= 'A' && matchStr <= 'Z') {
        return matchStr.toLocaleLowerCase();
      } else if (matchStr >= 'a' && matchStr <= 'z') {
        return matchStr.toLocaleUpperCase();
      }
    });
  },
  //统计含有的子字符串的个数
  countMatches: function (input, sub) {
    if (this.isEmpty(input) || this.isEmpty(sub)) {
      return 0;
    }
    let count = 0;
    let index = 0;
    while ((index = input.indexOf(sub, index)) !== -1) {
      index += sub.length;
      count++;
    }
    return count;
  },
  //只包含字母
  isAlpha: function (input) {
    return /^[a-z]+$/i.test(input);
  },
  //只包含字母、空格
  isAlphaSpace: function (input) {
    return /^[a-z\s]*$/i.test(input);
  },
  //只包含字母、数字
  isAlphanumeric: function (input) {
    return /^[a-z0-9]+$/i.test(input);
  },
  //只包含字母、数字和空格
  isAlphanumericSpace: function (input) {
    return /^[a-z0-9\s]*$/i.test(input);
  },
  //数字
  isNumeric: function (input) {
    return /^(?:[1-9]\d*|0)(?:\.\d+)?$/.test(input);
  },
  //小数
  isDecimal: function (input) {
    return /^[-+]?(?:0|[1-9]\d*)\.\d+$/.test(input);
  },
  //负小数
  isNegativeDecimal: function (input) {
    return /^\-?(?:0|[1-9]\d*)\.\d+$/.test(input);
  },
  //正小数
  isPositiveDecimal: function (input) {
    return /^\+?(?:0|[1-9]\d*)\.\d+$/.test(input);
  },
  //整数
  isInteger: function (input) {
    return /^[-+]?(?:0|[1-9]\d*)$/.test(input);
  },
  //正整数
  isPositiveInteger: function (input) {
    return /^\+?(?:0|[1-9]\d*)$/.test(input);
  },
  //负整数
  isNegativeInteger: function (input) {
    return /^\-?(?:0|[1-9]\d*)$/.test(input);
  },
  //只包含数字和空格
  isNumericSpace: function (input) {
    return /^[\d\s]*$/.test(input);
  },
  isWhitespace: function (input) {
    return /^\s*$/.test(input);
  },
  isAllLowerCase: function (input) {
    return /^[a-z]+$/.test(input);
  },
  isAllUpperCase: function (input) {
    return /^[A-Z]+$/.test(input);
  },
  defaultString: function (input, defaultStr) {
    return input == null ? defaultStr : input;
  },
  defaultIfBlank: function (input, defaultStr) {
    return this.isBlank(input) ? defaultStr : input;
  },
  defaultIfEmpty: function (input, defaultStr) {
    return this.isEmpty(input) ? defaultStr : input;
  },
  //字符串反转
  reverse: function (input) {
    if (this.isBlank(input)) {
      input;
    }
    return input.split("").reverse().join("");
  },
  //删掉特殊字符(英文状态下)
  removeSpecialCharacter: function (input) {
    return input.replace(/[!-/:-@\[-`{-~]/g, "");
  },
  //只包含特殊字符、数字和字母（不包括空格，若想包括空格，改为[ -~]）
  isSpecialCharacterAlphanumeric: function (input) {
    return /^[!-~]+$/.test(input);
  },
  /**
   * 校验时排除某些字符串，即不能包含某些字符串
   * @param {Object} conditions:里面有多个属性，如下：
   *
   * @param {String} matcherFlag 匹配标识
   * 0:数字；1：字母；2：小写字母；3:大写字母；4：特殊字符,指英文状态下的标点符号及括号等；5:中文;
   * 6:数字和字母；7：数字和小写字母；8：数字和大写字母；9：数字、字母和特殊字符；10：数字和中文；
   * 11：小写字母和特殊字符；12：大写字母和特殊字符；13：字母和特殊字符；14：小写字母和中文；15：大写字母和中文；
   * 16：字母和中文；17：特殊字符、和中文；18：特殊字符、字母和中文；19：特殊字符、小写字母和中文；20：特殊字符、大写字母和中文；
   * 100：所有字符;
   * @param {Array} excludeStrArr 排除的字符串，数组格式
   * @param {String} length 长度，可为空。1,2表示长度1到2之间；10，表示10个以上字符；5表示长度为5
   * @param {Boolean} ignoreCase 是否忽略大小写
   * conditions={matcherFlag:"0",excludeStrArr:[],length:"",ignoreCase:true}
   */
  isPatternMustExcludeSomeStr: function (input, conditions) {
    //参数
    const matcherFlag = conditions.matcherFlag;
    const excludeStrArr = conditions.excludeStrArr;
    const length = conditions.length;
    const ignoreCase = conditions.ignoreCase;
    //拼正则
    const size = excludeStrArr.length;
    let regex = (size === 0) ? "^" : "^(?!.*(?:{0}))";
    let subPattern = "";
    for (let i = 0; i < size; i++) {
      excludeStrArr[i] = Bee.StringUtils.escapeMetacharacterOfStr(excludeStrArr[i]);
      subPattern += excludeStrArr[i];
      if (i !== size - 1) {
        subPattern += "|";
      }
    }
    regex = this.format(regex, [subPattern]);
    switch (matcherFlag) {
      case '0':
        regex += "\\d";
        break;
      case '1':
        regex += "[a-zA-Z]";
        break;
      case '2':
        regex += "[a-z]";
        break;
      case '3':
        regex += "[A-Z]";
        break;
      case '4':
        regex += "[!-/:-@\[-`{-~]";
        break;
      case '5':
        regex += "[\u4E00-\u9FA5]";
        break;
      case '6':
        regex += "[a-zA-Z0-9]";
        break;
      case '7':
        regex += "[a-z0-9]";
        break;
      case '8':
        regex += "[A-Z0-9]";
        break;
      case '9':
        regex += "[!-~]";
        break;
      case '10':
        regex += "[0-9\u4E00-\u9FA5]";
        break;
      case '11':
        regex += "[a-z!-/:-@\[-`{-~]";
        break;
      case '12':
        regex += "[A-Z!-/:-@\[-`{-~]";
        break;
      case '13':
        regex += "[a-zA-Z!-/:-@\[-`{-~]";
        break;
      case '14':
        regex += "[a-z\u4E00-\u9FA5]";
        break;
      case '15':
        regex += "[A-Z\u4E00-\u9FA5]";
        break;
      case '16':
        regex += "[a-zA-Z\u4E00-\u9FA5]";
        break;
      case '17':
        regex += "[\u4E00-\u9FA5!-/:-@\[-`{-~]";
        break;
      case '18':
        regex += "[\u4E00-\u9FA5!-~]";
        break;
      case '19':
        regex += "[a-z\u4E00-\u9FA5!-/:-@\[-`{-~]";
        break;
      case '20':
        regex += "[A-Z\u4E00-\u9FA5!-/:-@\[-`{-~]";
        break;
      case '100':
        regex += "[\s\S]";
        break;
      default:
        alert(matcherFlag + ":This type is not supported!");
    }
    regex += this.isNotBlank(length) ? "{" + length + "}" : "+";
    regex += "$";
    const pattern = new RegExp(regex, ignoreCase ? "i" : "");
    return pattern.test(input);
  },
  /**
   * @param {String} message
   * @param {Array} arr
   * 消息格式化
   */
  format: function (message, arr) {
    return message.replace(/{(\d+)}/g, function (matchStr, group1) {
      return arr[group1];
    });
  },
  /**
   * 把连续出现多次的字母字符串进行压缩。如输入:aaabbbbcccccd 输出:3a4b5cd
   * @param {String} input
   * @param {Boolean} ignoreCase : true or false
   */
  compressRepeatedStr: function (input, ignoreCase) {
    const pattern = new RegExp("([a-z])\\1+", ignoreCase ? "ig" : "g");
    return input.replace(pattern, function (matchStr, group1) {
      return matchStr.length + group1;
    });
  },
  /**
   * 校验必须同时包含某些字符串
   * @param {String} input
   * @param {Object} conditions:里面有多个属性，如下：
   *
   * @param {String} matcherFlag 匹配标识
   * 0:数字；1：字母；2：小写字母；3:大写字母；4：特殊字符,指英文状态下的标点符号及括号等；5:中文;
   * 6:数字和字母；7：数字和小写字母；8：数字和大写字母；9：数字、字母和特殊字符；10：数字和中文；
   * 11：小写字母和特殊字符；12：大写字母和特殊字符；13：字母和特殊字符；14：小写字母和中文；15：大写字母和中文；
   * 16：字母和中文；17：特殊字符、和中文；18：特殊字符、字母和中文；19：特殊字符、小写字母和中文；20：特殊字符、大写字母和中文；
   * 100：所有字符;
   * @param {Array} excludeStrArr 排除的字符串，数组格式
   * @param {String} length 长度，可为空。1,2表示长度1到2之间；10，表示10个以上字符；5表示长度为5
   * @param {Boolean} ignoreCase 是否忽略大小写
   * conditions={matcherFlag:"0",containStrArr:[],length:"",ignoreCase:true}
   *
   */
  isPatternMustContainSomeStr: function (input, conditions) {
    //参数
    const matcherFlag = conditions.matcherFlag;
    const containStrArr = conditions.containStrArr;
    const length = conditions.length;
    const ignoreCase = conditions.ignoreCase;
    //创建正则
    const size = containStrArr.length;
    let regex = "^";
    let subPattern = "";
    for (let i = 0; i < size; i++) {
      containStrArr[i] = Bee.StringUtils.escapeMetacharacterOfStr(containStrArr[i]);
      subPattern += "(?=.*" + containStrArr[i] + ")";
    }
    regex += subPattern;
    switch (matcherFlag) {
      case '0':
        regex += "\\d";
        break;
      case '1':
        regex += "[a-zA-Z]";
        break;
      case '2':
        regex += "[a-z]";
        break;
      case '3':
        regex += "[A-Z]";
        break;
      case '4':
        regex += "[!-/:-@\[-`{-~]";
        break;
      case '5':
        regex += "[\u4E00-\u9FA5]";
        break;
      case '6':
        regex += "[a-zA-Z0-9]";
        break;
      case '7':
        regex += "[a-z0-9]";
        break;
      case '8':
        regex += "[A-Z0-9]";
        break;
      case '9':
        regex += "[!-~]";
        break;
      case '10':
        regex += "[0-9\u4E00-\u9FA5]";
        break;
      case '11':
        regex += "[a-z!-/:-@\[-`{-~]";
        break;
      case '12':
        regex += "[A-Z!-/:-@\[-`{-~]";
        break;
      case '13':
        regex += "[a-zA-Z!-/:-@\[-`{-~]";
        break;
      case '14':
        regex += "[a-z\u4E00-\u9FA5]";
        break;
      case '15':
        regex += "[A-Z\u4E00-\u9FA5]";
        break;
      case '16':
        regex += "[a-zA-Z\u4E00-\u9FA5]";
        break;
      case '17':
        regex += "[\u4E00-\u9FA5!-/:-@\[-`{-~]";
        break;
      case '18':
        regex += "[\u4E00-\u9FA5!-~]";
        break;
      case '19':
        regex += "[a-z\u4E00-\u9FA5!-/:-@\[-`{-~]";
        break;
      case '20':
        regex += "[A-Z\u4E00-\u9FA5!-/:-@\[-`{-~]";
        break;
      case '100':
        regex += "[\s\S]";
        break;
      default:
        alert(matcherFlag + ":This type is not supported!");
    }
    regex += this.isNotBlank(length) ? "{" + length + "}" : "+";
    regex += "$";
    const pattern = new RegExp(regex, ignoreCase ? "i" : "");
    return pattern.test(input);
  },
  //中文校验
  isChinese: function (input) {
    return /^[\u4E00-\u9FA5]+$/.test(input);
  },
  //去掉中文字符
  removeChinese: function (input) {
    return input.replace(/[\u4E00-\u9FA5]+/gm, "");
  },
  //转义元字符
  escapeMetacharacter: function (input) {
    const metacharacter = "^$()*+.[]|\\-?{}|";
    if (metacharacter.indexOf(input) >= 0) {
      input = "\\" + input;
    }
    return input;
  },
  //转义字符串中的元字符
  escapeMetacharacterOfStr: function (input) {
    return input.replace(/[\^\$\*\+\.\|\\\-\?\{\}\|]/gm, "\\$&");
  }
};
