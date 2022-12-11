//package com.ruoyi.flowable.config;
//
//import com.sun.prism.paint.Color;
//import org.flowable.bpmn.model.AssociationDirection;
//import org.flowable.image.impl.DefaultProcessDiagramCanvas;
//
//import java.awt.*;
//import java.awt.geom.Line2D;
//import java.awt.geom.RoundRectangle2D;
//
///**
// * @author XuanXuan
// * @date 2021-04-03
// */
//public class MyDefaultProcessDiagramCanvas extends DefaultProcessDiagramCanvas {
//    //设置高亮线的颜色  这里我设置成绿色
//    protected static Color HIGHLIGHT_SEQUENCEFLOW_COLOR = Color.GREEN;
//
//    public MyDefaultProcessDiagramCanvas(int width, int height, int minX, int minY, String imageType, String activityFontName, String labelFontName, String annotationFontName, ClassLoader customClassLoader) {
//        super(width, height, minX, minY, imageType, activityFontName, labelFontName, annotationFontName, customClassLoader);
//    }
//
//    public MyDefaultProcessDiagramCanvas(int width, int height, int minX, int minY, String imageType) {
//        super(width, height, minX, minY, imageType);
//    }
//
//
//    /**
//     * 画线颜色设置
//     */
//    @Override
//    public void drawConnection(int[] xPoints, int[] yPoints, boolean conditional, boolean isDefault, String connectionType,
//                               AssociationDirection associationDirection, boolean highLighted, double scaleFactor) {
//
//        Paint originalPaint = g.getPaint();
//        Stroke originalStroke = g.getStroke();
//
//        g.setPaint(CONNECTION_COLOR);
//        if (connectionType.equals("association")) {
//            g.setStroke(ASSOCIATION_STROKE);
//        } else if (highLighted) {
//            //设置线的颜色
//            g.setPaint(originalPaint);
//            g.setStroke(HIGHLIGHT_FLOW_STROKE);
//        }
//
//        for (int i = 1; i < xPoints.length; i++) {
//            Integer sourceX = xPoints[i - 1];
//            Integer sourceY = yPoints[i - 1];
//            Integer targetX = xPoints[i];
//            Integer targetY = yPoints[i];
//            Line2D.Double line = new Line2D.Double(sourceX, sourceY, targetX, targetY);
//            g.draw(line);
//        }
//
//        if (isDefault) {
//            Line2D.Double line = new Line2D.Double(xPoints[0], yPoints[0], xPoints[1], yPoints[1]);
//            drawDefaultSequenceFlowIndicator(line, scaleFactor);
//        }
//
//        if (conditional) {
//            Line2D.Double line = new Line2D.Double(xPoints[0], yPoints[0], xPoints[1], yPoints[1]);
//            drawConditionalSequenceFlowIndicator(line, scaleFactor);
//        }
//
//        if (associationDirection == AssociationDirection.ONE || associationDirection == AssociationDirection.BOTH) {
//            Line2D.Double line = new Line2D.Double(xPoints[xPoints.length - 2], yPoints[xPoints.length - 2], xPoints[xPoints.length - 1], yPoints[xPoints.length - 1]);
//            drawArrowHead(line, scaleFactor);
//        }
//        if (associationDirection == AssociationDirection.BOTH) {
//            Line2D.Double line = new Line2D.Double(xPoints[1], yPoints[1], xPoints[0], yPoints[0]);
//            drawArrowHead(line, scaleFactor);
//        }
//        g.setPaint(originalPaint);
//        g.setStroke(originalStroke);
//    }
//
//    /**
//     * 高亮节点设置
//     */
//    @Override
//    public void drawHighLight(int x, int y, int width, int height) {
//        Paint originalPaint = g.getPaint();
//        Stroke originalStroke = g.getStroke();
//        //设置高亮节点的颜色
//        g.setPaint(HIGHLIGHT_COLOR);
//        g.setStroke(THICK_TASK_BORDER_STROKE);
//
//        RoundRectangle2D rect = new RoundRectangle2D.Double(x, y, width, height, 20, 20);
//        g.draw(rect);
//
//        g.setPaint(originalPaint);
//        g.setStroke(originalStroke);
//    }
//}
