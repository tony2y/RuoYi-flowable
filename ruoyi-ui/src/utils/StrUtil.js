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
    return  str === undefined || str == null || this.trim(str) === "";

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
  }
};
