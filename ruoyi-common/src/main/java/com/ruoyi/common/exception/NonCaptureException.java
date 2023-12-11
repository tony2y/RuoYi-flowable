package com.ruoyi.common.exception;

/**
 * 不进行捕获的异常
 *
 * @author liming
 * @date 2023/12/10 20:11
 */
public class NonCaptureException extends RuntimeException {
    public NonCaptureException(String message, Throwable cause) {
        super(message, cause);
    }
}
