import CustomContextPad from './CustomContextPad';
import CustomPalette from "./CustomPalette";

export default {
  __init__: [ 'paletteProvider','contextPadProvider'],
  paletteProvider: [ 'type', CustomPalette ],
  contextPadProvider: [ 'type', CustomContextPad ],
};
