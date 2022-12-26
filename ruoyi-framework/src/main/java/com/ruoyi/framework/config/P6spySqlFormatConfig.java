//package com.ruoyi.framework.config;
//
//import com.p6spy.engine.spy.appender.MessageFormattingStrategy;
//import com.ruoyi.common.utils.DateUtils;
//import org.apache.commons.lang3.StringUtils;
//
//import java.util.Date;
//
///**
// * 自定义 p6spy sql输出格式
// *
// */
//public class P6spySqlFormatConfig implements MessageFormattingStrategy {
//
//    /**
//     * 过滤掉定时任务的 SQL
//     */
//    @Override
//    public String formatMessage(int connectionId, String now, long elapsed, String category, String prepared, String sql, String url) {
//        return StringUtils.isNotBlank(sql) ? DateUtils.parseDateToStr("yyyy-MM-dd HH:mm:ss", new Date())
//                + " | 耗时 " + elapsed + " ms | SQL 语句：" + StringUtils.LF + sql.replaceAll("[\\s]+", StringUtils.SPACE) + ";" : "";
//    }
//}
