import inherits from "inherits";
import Viewer from "bpmn-js/lib/Viewer";
import ZoomScrollModule from "diagram-js/lib/navigation/zoomscroll";
import MoveCanvasModule from "diagram-js/lib/navigation/movecanvas";
function CustomViewer(options) {
  Viewer.call(this, options);
}
inherits(CustomViewer, Viewer);
CustomViewer.prototype._modules = [].concat(Viewer.prototype._modules, [ZoomScrollModule, MoveCanvasModule]);
export {
  CustomViewer
};
