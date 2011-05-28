unit ExcelConsts;

interface

type
  TOleEnum = OleVariant;

// Constants constants
type
  Constants = TOleEnum;
const
  xlAll = $FFFFEFF8;
  xlAutomatic = $FFFFEFF7;
  xlBoth = $00000001;
  xlCenter = $FFFFEFF4;
  xlChecker = $00000009;
  xlCircle = $00000008;
  xlCorner = $00000002;
  xlCrissCross = $00000010;
  xlCross = $00000004;
  xlDiamond = $00000002;
  xlDistributed = $FFFFEFEB;
  xlDoubleAccounting = $00000005;
  xlFixedValue = $00000001;
  xlFormats = $FFFFEFE6;
  xlGray16 = $00000011;
  xlGray8 = $00000012;
  xlGrid = $0000000F;
  xlHigh = $FFFFEFE1;
  xlInside = $00000002;
  xlJustify = $FFFFEFDE;
  xlLightDown = $0000000D;
  xlLightHorizontal = $0000000B;
  xlLightUp = $0000000E;
  xlLightVertical = $0000000C;
  xlLow = $FFFFEFDA;
  xlManual = $FFFFEFD9;
  xlMinusValues = $00000003;
  xlModule = $FFFFEFD3;
  xlNextToAxis = $00000004;
  xlNone = $FFFFEFD2;
  xlNotes = $FFFFEFD0;
  xlOff = $FFFFEFCE;
  xlOn = $00000001;
  xlPercent = $00000002;
  xlPlus = $00000009;
  xlPlusValues = $00000002;
  xlSemiGray75 = $0000000A;
  xlShowLabel = $00000004;
  xlShowLabelAndPercent = $00000005;
  xlShowPercent = $00000003;
  xlShowValue = $00000002;
  xlSimple = $FFFFEFC6;
  xlSingle = $00000002;
  xlSingleAccounting = $00000004;
  xlSolid = $00000001;
  xlSquare = $00000001;
  xlStar = $00000005;
  xlStError = $00000004;
  xlToolbarButton = $00000002;
  xlTriangle = $00000003;
  xlGray25 = $FFFFEFE4;
  xlGray50 = $FFFFEFE3;
  xlGray75 = $FFFFEFE2;
  xlBottom = $FFFFEFF5;
  xlLeft = $FFFFEFDD;
  xlRight = $FFFFEFC8;
  xlTop = $FFFFEFC0;
  xl3DBar = $FFFFEFFD;
  xl3DSurface = $FFFFEFF9;
  xlBar = $00000002;
  xlColumn = $00000003;
  xlCombination = $FFFFEFF1;
  xlCustom = $FFFFEFEE;
  xlDefaultAutoFormat = $FFFFFFFF;
  xlMaximum = $00000002;
  xlMinimum = $00000004;
  xlOpaque = $00000003;
  xlTransparent = $00000002;
  xlBidi = $FFFFEC78;
  xlLatin = $FFFFEC77;
  xlContext = $FFFFEC76;
  xlLTR = $FFFFEC75;
  xlRTL = $FFFFEC74;
  xlVisualCursor = $00000002;
  xlLogicalCursor = $00000001;
  xlSystem = $00000001;
  xlPartial = $00000003;
  xlHindiNumerals = $00000003;
  xlBidiCalendar = $00000003;
  xlGregorian = $00000002;
  xlComplete = $00000004;
  xlScale = $00000003;
  xlClosed = $00000003;
  xlColor1 = $00000007;
  xlColor2 = $00000008;
  xlColor3 = $00000009;
  xlConstants = $00000002;
  xlContents = $00000002;
  xlBelow = $00000001;
  xlCascade = $00000007;
  xlCenterAcrossSelection = $00000007;
  xlChart4 = $00000002;
  xlChartSeries = $00000011;
  xlChartShort = $00000006;
  xlChartTitles = $00000012;
  xlClassic1 = $00000001;
  xlClassic2 = $00000002;
  xlClassic3 = $00000003;
  xl3DEffects1 = $0000000D;
  xl3DEffects2 = $0000000E;
  xlAbove = $00000000;
  xlAccounting1 = $00000004;
  xlAccounting2 = $00000005;
  xlAccounting3 = $00000006;
  xlAccounting4 = $00000011;
  xlAdd = $00000002;
  xlDebugCodePane = $0000000D;
  xlDesktop = $00000009;
  xlDirect = $00000001;
  xlDivide = $00000005;
  xlDoubleClosed = $00000005;
  xlDoubleOpen = $00000004;
  xlDoubleQuote = $00000001;
  xlEntireChart = $00000014;
  xlExcelMenus = $00000001;
  xlExtended = $00000003;
  xlFill = $00000005;
  xlFirst = $00000000;
  xlFloating = $00000005;
  xlFormula = $00000005;
  xlGeneral = $00000001;
  xlGridline = $00000016;
  xlIcons = $00000001;
  xlImmediatePane = $0000000C;
  xlInteger = $00000002;
  xlLast = $00000001;
  xlLastCell = $0000000B;
  xlList1 = $0000000A;
  xlList2 = $0000000B;
  xlList3 = $0000000C;
  xlLocalFormat1 = $0000000F;
  xlLocalFormat2 = $00000010;
  xlLong = $00000003;
  xlLotusHelp = $00000002;
  xlMacrosheetCell = $00000007;
  xlMixed = $00000002;
  xlMultiply = $00000004;
  xlNarrow = $00000001;
  xlNoDocuments = $00000003;
  xlOpen = $00000002;
  xlOutside = $00000003;
  xlReference = $00000004;
  xlSemiautomatic = $00000002;
  xlShort = $00000001;
  xlSingleQuote = $00000002;
  xlStrict = $00000002;
  xlSubtract = $00000003;
  xlTextBox = $00000010;
  xlTiled = $00000001;
  xlTitleBar = $00000008;
  xlToolbar = $00000001;
  xlVisible = $0000000C;
  xlWatchPane = $0000000B;
  xlWide = $00000003;
  xlWorkbookTab = $00000006;
  xlWorksheet4 = $00000001;
  xlWorksheetCell = $00000003;
  xlWorksheetShort = $00000005;
  xlAllExceptBorders = $00000006;
  xlLeftToRight = $00000002;
  xlTopToBottom = $00000001;
  xlVeryHidden = $00000002;
  xlDrawingObject = $0000000E;

// XlCreator constants
type
  XlCreator = TOleEnum;
const
  xlCreatorCode = $5843454C;

// XlChartGallery constants
type
  XlChartGallery = TOleEnum;
const
  xlBuiltIn = $00000015;
  xlUserDefined = $00000016;
  xlAnyGallery = $00000017;

// XlColorIndex constants
type
  XlColorIndex = TOleEnum;
const
  xlColorIndexAutomatic = $FFFFEFF7;
  xlColorIndexNone = $FFFFEFD2;

// XlEndStyleCap constants
type
  XlEndStyleCap = TOleEnum;
const
  xlCap = $00000001;
  xlNoCap = $00000002;

// XlRowCol constants
type
  XlRowCol = TOleEnum;
const
  xlColumns = $00000002;
  xlRows = $00000001;

// XlScaleType constants
type
  XlScaleType = TOleEnum;
const
  xlScaleLinear = $FFFFEFDC;
  xlScaleLogarithmic = $FFFFEFDB;

// XlDataSeriesType constants
type
  XlDataSeriesType = TOleEnum;
const
  xlAutoFill = $00000004;
  xlChronological = $00000003;
  xlGrowth = $00000002;
  xlDataSeriesLinear = $FFFFEFDC;

// XlAxisCrosses constants
type
  XlAxisCrosses = TOleEnum;
const
  xlAxisCrossesAutomatic = $FFFFEFF7;
  xlAxisCrossesCustom = $FFFFEFEE;
  xlAxisCrossesMaximum = $00000002;
  xlAxisCrossesMinimum = $00000004;

// XlAxisGroup constants
type
  XlAxisGroup = TOleEnum;
const
  xlPrimary = $00000001;
  xlSecondary = $00000002;

// XlBackground constants
type
  XlBackground = TOleEnum;
const
  xlBackgroundAutomatic = $FFFFEFF7;
  xlBackgroundOpaque = $00000003;
  xlBackgroundTransparent = $00000002;

// XlWindowState constants
type
  XlWindowState = TOleEnum;
const
  xlMaximized = $FFFFEFD7;
  xlMinimized = $FFFFEFD4;
  xlNormal = $FFFFEFD1;

// XlAxisType constants
type
  XlAxisType = TOleEnum;
const
  xlCategory = $00000001;
  xlSeriesAxis = $00000003;
  xlValue = $00000002;

// XlArrowHeadLength constants
type
  XlArrowHeadLength = TOleEnum;
const
  xlArrowHeadLengthLong = $00000003;
  xlArrowHeadLengthMedium = $FFFFEFD6;
  xlArrowHeadLengthShort = $00000001;

// XlVAlign constants
type
  XlVAlign = TOleEnum;
const
  xlVAlignBottom = $FFFFEFF5;
  xlVAlignCenter = $FFFFEFF4;
  xlVAlignDistributed = $FFFFEFEB;
  xlVAlignJustify = $FFFFEFDE;
  xlVAlignTop = $FFFFEFC0;

// XlTickMark constants
type
  XlTickMark = TOleEnum;
const
  xlTickMarkCross = $00000004;
  xlTickMarkInside = $00000002;
  xlTickMarkNone = $FFFFEFD2;
  xlTickMarkOutside = $00000003;

// XlErrorBarDirection constants
type
  XlErrorBarDirection = TOleEnum;
const
  xlX = $FFFFEFB8;
  xlY = $00000001;

// XlErrorBarInclude constants
type
  XlErrorBarInclude = TOleEnum;
const
  xlErrorBarIncludeBoth = $00000001;
  xlErrorBarIncludeMinusValues = $00000003;
  xlErrorBarIncludeNone = $FFFFEFD2;
  xlErrorBarIncludePlusValues = $00000002;

// XlDisplayBlanksAs constants
type
  XlDisplayBlanksAs = TOleEnum;
const
  xlInterpolated = $00000003;
  xlNotPlotted = $00000001;
  xlZero = $00000002;

// XlArrowHeadStyle constants
type
  XlArrowHeadStyle = TOleEnum;
const
  xlArrowHeadStyleClosed = $00000003;
  xlArrowHeadStyleDoubleClosed = $00000005;
  xlArrowHeadStyleDoubleOpen = $00000004;
  xlArrowHeadStyleNone = $FFFFEFD2;
  xlArrowHeadStyleOpen = $00000002;

// XlArrowHeadWidth constants
type
  XlArrowHeadWidth = TOleEnum;
const
  xlArrowHeadWidthMedium = $FFFFEFD6;
  xlArrowHeadWidthNarrow = $00000001;
  xlArrowHeadWidthWide = $00000003;

// XlHAlign constants
type
  XlHAlign = TOleEnum;
const
  xlHAlignCenter = $FFFFEFF4;
  xlHAlignCenterAcrossSelection = $00000007;
  xlHAlignDistributed = $FFFFEFEB;
  xlHAlignFill = $00000005;
  xlHAlignGeneral = $00000001;
  xlHAlignJustify = $FFFFEFDE;
  xlHAlignLeft = $FFFFEFDD;
  xlHAlignRight = $FFFFEFC8;

// XlTickLabelPosition constants
type
  XlTickLabelPosition = TOleEnum;
const
  xlTickLabelPositionHigh = $FFFFEFE1;
  xlTickLabelPositionLow = $FFFFEFDA;
  xlTickLabelPositionNextToAxis = $00000004;
  xlTickLabelPositionNone = $FFFFEFD2;

// XlLegendPosition constants
type
  XlLegendPosition = TOleEnum;
const
  xlLegendPositionBottom = $FFFFEFF5;
  xlLegendPositionCorner = $00000002;
  xlLegendPositionLeft = $FFFFEFDD;
  xlLegendPositionRight = $FFFFEFC8;
  xlLegendPositionTop = $FFFFEFC0;

// XlChartPictureType constants
type
  XlChartPictureType = TOleEnum;
const
  xlStackScale = $00000003;
  xlStack = $00000002;
  xlStretch = $00000001;

// XlChartPicturePlacement constants
type
  XlChartPicturePlacement = TOleEnum;
const
  xlSides = $00000001;
  xlEnd = $00000002;
  xlEndSides = $00000003;
  xlFront = $00000004;
  xlFrontSides = $00000005;
  xlFrontEnd = $00000006;
  xlAllFaces = $00000007;

// XlOrientation constants
type
  XlOrientation = TOleEnum;
const
  xlDownward = $FFFFEFB6;
  xlHorizontal = $FFFFEFE0;
  xlUpward = $FFFFEFB5;
  xlVertical = $FFFFEFBA;

// XlTickLabelOrientation constants
type
  XlTickLabelOrientation = TOleEnum;
const
  xlTickLabelOrientationAutomatic = $FFFFEFF7;
  xlTickLabelOrientationDownward = $FFFFEFB6;
  xlTickLabelOrientationHorizontal = $FFFFEFE0;
  xlTickLabelOrientationUpward = $FFFFEFB5;
  xlTickLabelOrientationVertical = $FFFFEFBA;

// XlBorderWeight constants
type
  XlBorderWeight = TOleEnum;
const
  xlHairline = $00000001;
  xlMedium = $FFFFEFD6;
  xlThick = $00000004;
  xlThin = $00000002;

// XlDataSeriesDate constants
type
  XlDataSeriesDate = TOleEnum;
const
  xlDay = $00000001;
  xlMonth = $00000003;
  xlWeekday = $00000002;
  xlYear = $00000004;

// XlUnderlineStyle constants
type
  XlUnderlineStyle = TOleEnum;
const
  xlUnderlineStyleDouble = $FFFFEFE9;
  xlUnderlineStyleDoubleAccounting = $00000005;
  xlUnderlineStyleNone = $FFFFEFD2;
  xlUnderlineStyleSingle = $00000002;
  xlUnderlineStyleSingleAccounting = $00000004;

// XlErrorBarType constants
type
  XlErrorBarType = TOleEnum;
const
  xlErrorBarTypeCustom = $FFFFEFEE;
  xlErrorBarTypeFixedValue = $00000001;
  xlErrorBarTypePercent = $00000002;
  xlErrorBarTypeStDev = $FFFFEFC5;
  xlErrorBarTypeStError = $00000004;

// XlTrendlineType constants
type
  XlTrendlineType = TOleEnum;
const
  xlExponential = $00000005;
  xlLinear = $FFFFEFDC;
  xlLogarithmic = $FFFFEFDB;
  xlMovingAvg = $00000006;
  xlPolynomial = $00000003;
  xlPower = $00000004;

// XlLineStyle constants
type
  XlLineStyle = TOleEnum;
const
  xlContinuous = $00000001;
  xlDash = $FFFFEFED;
  xlDashDot = $00000004;
  xlDashDotDot = $00000005;
  xlDot = $FFFFEFEA;
  xlDouble = $FFFFEFE9;
  xlSlantDashDot = $0000000D;
  xlLineStyleNone = $FFFFEFD2;

// XlDataLabelsType constants
type
  XlDataLabelsType = TOleEnum;
const
  xlDataLabelsShowNone = $FFFFEFD2;
  xlDataLabelsShowValue = $00000002;
  xlDataLabelsShowPercent = $00000003;
  xlDataLabelsShowLabel = $00000004;
  xlDataLabelsShowLabelAndPercent = $00000005;
  xlDataLabelsShowBubbleSizes = $00000006;

// XlMarkerStyle constants
type
  XlMarkerStyle = TOleEnum;
const
  xlMarkerStyleAutomatic = $FFFFEFF7;
  xlMarkerStyleCircle = $00000008;
  xlMarkerStyleDash = $FFFFEFED;
  xlMarkerStyleDiamond = $00000002;
  xlMarkerStyleDot = $FFFFEFEA;
  xlMarkerStyleNone = $FFFFEFD2;
  xlMarkerStylePicture = $FFFFEFCD;
  xlMarkerStylePlus = $00000009;
  xlMarkerStyleSquare = $00000001;
  xlMarkerStyleStar = $00000005;
  xlMarkerStyleTriangle = $00000003;
  xlMarkerStyleX = $FFFFEFB8;

// XlPictureConvertorType constants
type
  XlPictureConvertorType = TOleEnum;
const
  xlBMP = $00000001;
  xlCGM = $00000007;
  xlDRW = $00000004;
  xlDXF = $00000005;
  xlEPS = $00000008;
  xlHGL = $00000006;
  xlPCT = $0000000D;
  xlPCX = $0000000A;
  xlPIC = $0000000B;
  xlPLT = $0000000C;
  xlTIF = $00000009;
  xlWMF = $00000002;
  xlWPG = $00000003;

// XlPattern constants
type
  XlPattern = TOleEnum;
const
  xlPatternAutomatic = $FFFFEFF7;
  xlPatternChecker = $00000009;
  xlPatternCrissCross = $00000010;
  xlPatternDown = $FFFFEFE7;
  xlPatternGray16 = $00000011;
  xlPatternGray25 = $FFFFEFE4;
  xlPatternGray50 = $FFFFEFE3;
  xlPatternGray75 = $FFFFEFE2;
  xlPatternGray8 = $00000012;
  xlPatternGrid = $0000000F;
  xlPatternHorizontal = $FFFFEFE0;
  xlPatternLightDown = $0000000D;
  xlPatternLightHorizontal = $0000000B;
  xlPatternLightUp = $0000000E;
  xlPatternLightVertical = $0000000C;
  xlPatternNone = $FFFFEFD2;
  xlPatternSemiGray75 = $0000000A;
  xlPatternSolid = $00000001;
  xlPatternUp = $FFFFEFBE;
  xlPatternVertical = $FFFFEFBA;

// XlChartSplitType constants
type
  XlChartSplitType = TOleEnum;
const
  xlSplitByPosition = $00000001;
  xlSplitByPercentValue = $00000003;
  xlSplitByCustomSplit = $00000004;
  xlSplitByValue = $00000002;

// XlDataLabelPosition constants
type
  XlDataLabelPosition = TOleEnum;
const
  xlLabelPositionCenter = $FFFFEFF4;
  xlLabelPositionAbove = $00000000;
  xlLabelPositionBelow = $00000001;
  xlLabelPositionLeft = $FFFFEFDD;
  xlLabelPositionRight = $FFFFEFC8;
  xlLabelPositionOutsideEnd = $00000002;
  xlLabelPositionInsideEnd = $00000003;
  xlLabelPositionInsideBase = $00000004;
  xlLabelPositionBestFit = $00000005;
  xlLabelPositionMixed = $00000006;
  xlLabelPositionCustom = $00000007;

// XlTimeUnit constants
type
  XlTimeUnit = TOleEnum;
const
  xlDays = $00000000;
  xlMonths = $00000001;
  xlYears = $00000002;

// XlCategoryType constants
type
  XlCategoryType = TOleEnum;
const
  xlCategoryScale = $00000002;
  xlTimeScale = $00000003;
  xlAutomaticScale = $FFFFEFF7;

// XlBarShape constants
type
  XlBarShape = TOleEnum;
const
  xlBox = $00000000;
  xlPyramidToPoint = $00000001;
  xlPyramidToMax = $00000002;
  xlCylinder = $00000003;
  xlConeToPoint = $00000004;
  xlConeToMax = $00000005;

// XlChartType constants
type
  XlChartType = TOleEnum;
const
  xlColumnClustered = $00000033;
  xlColumnStacked = $00000034;
  xlColumnStacked100 = $00000035;
  xl3DColumnClustered = $00000036;
  xl3DColumnStacked = $00000037;
  xl3DColumnStacked100 = $00000038;
  xlBarClustered = $00000039;
  xlBarStacked = $0000003A;
  xlBarStacked100 = $0000003B;
  xl3DBarClustered = $0000003C;
  xl3DBarStacked = $0000003D;
  xl3DBarStacked100 = $0000003E;
  xlLineStacked = $0000003F;
  xlLineStacked100 = $00000040;
  xlLineMarkers = $00000041;
  xlLineMarkersStacked = $00000042;
  xlLineMarkersStacked100 = $00000043;
  xlPieOfPie = $00000044;
  xlPieExploded = $00000045;
  xl3DPieExploded = $00000046;
  xlBarOfPie = $00000047;
  xlXYScatterSmooth = $00000048;
  xlXYScatterSmoothNoMarkers = $00000049;
  xlXYScatterLines = $0000004A;
  xlXYScatterLinesNoMarkers = $0000004B;
  xlAreaStacked = $0000004C;
  xlAreaStacked100 = $0000004D;
  xl3DAreaStacked = $0000004E;
  xl3DAreaStacked100 = $0000004F;
  xlDoughnutExploded = $00000050;
  xlRadarMarkers = $00000051;
  xlRadarFilled = $00000052;
  xlSurface = $00000053;
  xlSurfaceWireframe = $00000054;
  xlSurfaceTopView = $00000055;
  xlSurfaceTopViewWireframe = $00000056;
  xlBubble = $0000000F;
  xlBubble3DEffect = $00000057;
  xlStockHLC = $00000058;
  xlStockOHLC = $00000059;
  xlStockVHLC = $0000005A;
  xlStockVOHLC = $0000005B;
  xlCylinderColClustered = $0000005C;
  xlCylinderColStacked = $0000005D;
  xlCylinderColStacked100 = $0000005E;
  xlCylinderBarClustered = $0000005F;
  xlCylinderBarStacked = $00000060;
  xlCylinderBarStacked100 = $00000061;
  xlCylinderCol = $00000062;
  xlConeColClustered = $00000063;
  xlConeColStacked = $00000064;
  xlConeColStacked100 = $00000065;
  xlConeBarClustered = $00000066;
  xlConeBarStacked = $00000067;
  xlConeBarStacked100 = $00000068;
  xlConeCol = $00000069;
  xlPyramidColClustered = $0000006A;
  xlPyramidColStacked = $0000006B;
  xlPyramidColStacked100 = $0000006C;
  xlPyramidBarClustered = $0000006D;
  xlPyramidBarStacked = $0000006E;
  xlPyramidBarStacked100 = $0000006F;
  xlPyramidCol = $00000070;
  xl3DColumn = $FFFFEFFC;
  xlLine = $00000004;
  xl3DLine = $FFFFEFFB;
  xl3DPie = $FFFFEFFA;
  xlPie = $00000005;
  xlXYScatter = $FFFFEFB7;
  xl3DArea = $FFFFEFFE;
  xlArea = $00000001;
  xlDoughnut = $FFFFEFE8;
  xlRadar = $FFFFEFC9;

// XlChartItem constants
type
  XlChartItem = TOleEnum;
const
  xlDataLabel = $00000000;
  xlChartArea = $00000002;
  xlSeries = $00000003;
  xlChartTitle = $00000004;
  xlWalls = $00000005;
  xlCorners = $00000006;
  xlDataTable = $00000007;
  xlTrendline = $00000008;
  xlErrorBars = $00000009;
  xlXErrorBars = $0000000A;
  xlYErrorBars = $0000000B;
  xlLegendEntry = $0000000C;
  xlLegendKey = $0000000D;
  xlShape = $0000000E;
  xlMajorGridlines = $0000000F;
  xlMinorGridlines = $00000010;
  xlAxisTitle = $00000011;
  xlUpBars = $00000012;
  xlPlotArea = $00000013;
  xlDownBars = $00000014;
  xlAxis = $00000015;
  xlSeriesLines = $00000016;
  xlFloor = $00000017;
  xlLegend = $00000018;
  xlHiLoLines = $00000019;
  xlDropLines = $0000001A;
  xlRadarAxisLabels = $0000001B;
  xlNothing = $0000001C;
  xlLeaderLines = $0000001D;

// XlSizeRepresents constants
type
  XlSizeRepresents = TOleEnum;
const
  xlSizeIsWidth = $00000002;
  xlSizeIsArea = $00000001;

// XlInsertShiftDirection constants
type
  XlInsertShiftDirection = TOleEnum;
const
  xlShiftDown = $FFFFEFE7;
  xlShiftToRight = $FFFFEFBF;

// XlDeleteShiftDirection constants
type
  XlDeleteShiftDirection = TOleEnum;
const
  xlShiftToLeft = $FFFFEFC1;
  xlShiftUp = $FFFFEFBE;

// XlDirection constants
type
  XlDirection = TOleEnum;
const
  xlDown = $FFFFEFE7;
  xlToLeft = $FFFFEFC1;
  xlToRight = $FFFFEFBF;
  xlUp = $FFFFEFBE;

// XlConsolidationFunction constants
type
  XlConsolidationFunction = TOleEnum;
const
  xlAverage = $FFFFEFF6;
  xlCount = $FFFFEFF0;
  xlCountNums = $FFFFEFEF;
  xlMax = $FFFFEFD8;
  xlMin = $FFFFEFD5;
  xlProduct = $FFFFEFCB;
  xlStDev = $FFFFEFC5;
  xlStDevP = $FFFFEFC4;
  xlSum = $FFFFEFC3;
  xlVar = $FFFFEFBC;
  xlVarP = $FFFFEFBB;

// XlSheetType constants
type
  XlSheetType = TOleEnum;
const
  xlChart = $FFFFEFF3;
  xlDialogSheet = $FFFFEFEC;
  xlExcel4IntlMacroSheet = $00000004;
  xlExcel4MacroSheet = $00000003;
  xlWorksheet = $FFFFEFB9;

// XlLocationInTable constants
type
  XlLocationInTable = TOleEnum;
const
  xlColumnHeader = $FFFFEFF2;
  xlColumnItem = $00000005;
  xlDataHeader = $00000003;
  xlDataItem = $00000007;
  xlPageHeader = $00000002;
  xlPageItem = $00000006;
  xlRowHeader = $FFFFEFC7;
  xlRowItem = $00000004;
  xlTableBody = $00000008;

// XlFindLookIn constants
type
  XlFindLookIn = TOleEnum;
const
  xlFormulas = $FFFFEFE5;
  xlComments = $FFFFEFD0;
  xlValues = $FFFFEFBD;

// XlWindowType constants
type
  XlWindowType = TOleEnum;
const
  xlChartAsWindow = $00000005;
  xlChartInPlace = $00000004;
  xlClipboard = $00000003;
  xlInfo = $FFFFEFDF;
  xlWorkbook = $00000001;

// XlPivotFieldDataType constants
type
  XlPivotFieldDataType = TOleEnum;
const
  xlDate = $00000002;
  xlNumber = $FFFFEFCF;
  xlText = $FFFFEFC2;

// XlCopyPictureFormat constants
type
  XlCopyPictureFormat = TOleEnum;
const
  xlBitmap = $00000002;
  xlPicture = $FFFFEFCD;

// XlPivotTableSourceType constants
type
  XlPivotTableSourceType = TOleEnum;
const
  xlConsolidation = $00000003;
  xlDatabase = $00000001;
  xlExternal = $00000002;
  xlPivotTable = $FFFFEFCC;

// XlReferenceStyle constants
type
  XlReferenceStyle = TOleEnum;
const
  xlA1 = $00000001;
  xlR1C1 = $FFFFEFCA;

// XlMSApplication constants
type
  XlMSApplication = TOleEnum;
const
  xlMicrosoftAccess = $00000004;
  xlMicrosoftFoxPro = $00000005;
  xlMicrosoftMail = $00000003;
  xlMicrosoftPowerPoint = $00000002;
  xlMicrosoftProject = $00000006;
  xlMicrosoftSchedulePlus = $00000007;
  xlMicrosoftWord = $00000001;

// XlMouseButton constants
type
  XlMouseButton = TOleEnum;
const
  xlNoButton = $00000000;
  xlPrimaryButton = $00000001;
  xlSecondaryButton = $00000002;

// XlCutCopyMode constants
type
  XlCutCopyMode = TOleEnum;
const
  xlCopy = $00000001;
  xlCut = $00000002;

// XlFillWith constants
type
  XlFillWith = TOleEnum;
const
  xlFillWithAll = $FFFFEFF8;
  xlFillWithContents = $00000002;
  xlFillWithFormats = $FFFFEFE6;

// XlFilterAction constants
type
  XlFilterAction = TOleEnum;
const
  xlFilterCopy = $00000002;
  xlFilterInPlace = $00000001;

// XlOrder constants
type
  XlOrder = TOleEnum;
const
  xlDownThenOver = $00000001;
  xlOverThenDown = $00000002;

// XlLinkType constants
type
  XlLinkType = TOleEnum;
const
  xlLinkTypeExcelLinks = $00000001;
  xlLinkTypeOLELinks = $00000002;

// XlApplyNamesOrder constants
type
  XlApplyNamesOrder = TOleEnum;
const
  xlColumnThenRow = $00000002;
  xlRowThenColumn = $00000001;

// XlEnableCancelKey constants
type
  XlEnableCancelKey = TOleEnum;
const
  xlDisabled = $00000000;
  xlErrorHandler = $00000002;
  xlInterrupt = $00000001;

// XlPageBreak constants
type
  XlPageBreak = TOleEnum;
const
  xlPageBreakAutomatic = $FFFFEFF7;
  xlPageBreakManual = $FFFFEFD9;

// XlOLEType constants
type
  XlOLEType = TOleEnum;
const
  xlOLEControl = $00000002;
  xlOLEEmbed = $00000001;
  xlOLELink = $00000000;

// XlPageOrientation constants
type
  XlPageOrientation = TOleEnum;
const
  xlLandscape = $00000002;
  xlPortrait = $00000001;

// XlLinkInfo constants
type
  XlLinkInfo = TOleEnum;
const
  xlEditionDate = $00000002;
  xlUpdateState = $00000001;

// XlCommandUnderlines constants
type
  XlCommandUnderlines = TOleEnum;
const
  xlCommandUnderlinesAutomatic = $FFFFEFF7;
  xlCommandUnderlinesOff = $FFFFEFCE;
  xlCommandUnderlinesOn = $00000001;

// XlOLEVerb constants
type
  XlOLEVerb = TOleEnum;
const
  xlVerbOpen = $00000002;
  xlVerbPrimary = $00000001;

// XlCalculation constants
type
  XlCalculation = TOleEnum;
const
  xlCalculationAutomatic = $FFFFEFF7;
  xlCalculationManual = $FFFFEFD9;
  xlCalculationSemiautomatic = $00000002;

// XlFileAccess constants
type
  XlFileAccess = TOleEnum;
const
  xlReadOnly = $00000003;
  xlReadWrite = $00000002;

// XlEditionType constants
type
  XlEditionType = TOleEnum;
const
  xlPublisher = $00000001;
  xlSubscriber = $00000002;

// XlObjectSize constants
type
  XlObjectSize = TOleEnum;
const
  xlFitToPage = $00000002;
  xlFullPage = $00000003;
  xlScreenSize = $00000001;

// XlLookAt constants
type
  XlLookAt = TOleEnum;
const
  xlPart = $00000002;
  xlWhole = $00000001;

// XlMailSystem constants
type
  XlMailSystem = TOleEnum;
const
  xlMAPI = $00000001;
  xlNoMailSystem = $00000000;
  xlPowerTalk = $00000002;

// XlLinkInfoType constants
type
  XlLinkInfoType = TOleEnum;
const
  xlLinkInfoOLELinks = $00000002;
  xlLinkInfoPublishers = $00000005;
  xlLinkInfoSubscribers = $00000006;

// XlCVError constants
type
  XlCVError = TOleEnum;
const
  xlErrDiv0 = $000007D7;
  xlErrNA = $000007FA;
  xlErrName = $000007ED;
  xlErrNull = $000007D0;
  xlErrNum = $000007F4;
  xlErrRef = $000007E7;
  xlErrValue = $000007DF;

// XlEditionFormat constants
type
  XlEditionFormat = TOleEnum;
const
  xlBIFF = $00000002;
  xlPICT = $00000001;
  xlRTF = $00000004;
  xlVALU = $00000008;

// XlLink constants
type
  XlLink = TOleEnum;
const
  xlExcelLinks = $00000001;
  xlOLELinks = $00000002;
  xlPublishers = $00000005;
  xlSubscribers = $00000006;

// XlCellType constants
type
  XlCellType = TOleEnum;
const
  xlCellTypeBlanks = $00000004;
  xlCellTypeConstants = $00000002;
  xlCellTypeFormulas = $FFFFEFE5;
  xlCellTypeLastCell = $0000000B;
  xlCellTypeComments = $FFFFEFD0;
  xlCellTypeVisible = $0000000C;
  xlCellTypeAllFormatConditions = $FFFFEFB4;
  xlCellTypeSameFormatConditions = $FFFFEFB3;
  xlCellTypeAllValidation = $FFFFEFB2;
  xlCellTypeSameValidation = $FFFFEFB1;

// XlArrangeStyle constants
type
  XlArrangeStyle = TOleEnum;
const
  xlArrangeStyleCascade = $00000007;
  xlArrangeStyleHorizontal = $FFFFEFE0;
  xlArrangeStyleTiled = $00000001;
  xlArrangeStyleVertical = $FFFFEFBA;

// XlMousePointer constants
type
  XlMousePointer = TOleEnum;
const
  xlIBeam = $00000003;
  xlDefault = $FFFFEFD1;
  xlNorthwestArrow = $00000001;
  xlWait = $00000002;

// XlEditionOptionsOption constants
type
  XlEditionOptionsOption = TOleEnum;
const
  xlAutomaticUpdate = $00000004;
  xlCancel = $00000001;
  xlChangeAttributes = $00000006;
  xlManualUpdate = $00000005;
  xlOpenSource = $00000003;
  xlSelect = $00000003;
  xlSendPublisher = $00000002;
  xlUpdateSubscriber = $00000002;

// XlAutoFillType constants
type
  XlAutoFillType = TOleEnum;
const
  xlFillCopy = $00000001;
  xlFillDays = $00000005;
  xlFillDefault = $00000000;
  xlFillFormats = $00000003;
  xlFillMonths = $00000007;
  xlFillSeries = $00000002;
  xlFillValues = $00000004;
  xlFillWeekdays = $00000006;
  xlFillYears = $00000008;
  xlGrowthTrend = $0000000A;
  xlLinearTrend = $00000009;

// XlAutoFilterOperator constants
type
  XlAutoFilterOperator = TOleEnum;
const
  xlAnd = $00000001;
  xlBottom10Items = $00000004;
  xlBottom10Percent = $00000006;
  xlOr = $00000002;
  xlTop10Items = $00000003;
  xlTop10Percent = $00000005;

// XlClipboardFormat constants
type
  XlClipboardFormat = TOleEnum;
const
  xlClipboardFormatBIFF = $00000008;
  xlClipboardFormatBIFF2 = $00000012;
  xlClipboardFormatBIFF3 = $00000014;
  xlClipboardFormatBIFF4 = $0000001E;
  xlClipboardFormatBinary = $0000000F;
  xlClipboardFormatBitmap = $00000009;
  xlClipboardFormatCGM = $0000000D;
  xlClipboardFormatCSV = $00000005;
  xlClipboardFormatDIF = $00000004;
  xlClipboardFormatDspText = $0000000C;
  xlClipboardFormatEmbeddedObject = $00000015;
  xlClipboardFormatEmbedSource = $00000016;
  xlClipboardFormatLink = $0000000B;
  xlClipboardFormatLinkSource = $00000017;
  xlClipboardFormatLinkSourceDesc = $00000020;
  xlClipboardFormatMovie = $00000018;
  xlClipboardFormatNative = $0000000E;
  xlClipboardFormatObjectDesc = $0000001F;
  xlClipboardFormatObjectLink = $00000013;
  xlClipboardFormatOwnerLink = $00000011;
  xlClipboardFormatPICT = $00000002;
  xlClipboardFormatPrintPICT = $00000003;
  xlClipboardFormatRTF = $00000007;
  xlClipboardFormatScreenPICT = $0000001D;
  xlClipboardFormatStandardFont = $0000001C;
  xlClipboardFormatStandardScale = $0000001B;
  xlClipboardFormatSYLK = $00000006;
  xlClipboardFormatTable = $00000010;
  xlClipboardFormatText = $00000000;
  xlClipboardFormatToolFace = $00000019;
  xlClipboardFormatToolFacePICT = $0000001A;
  xlClipboardFormatVALU = $00000001;
  xlClipboardFormatWK1 = $0000000A;

// XlFileFormat constants
type
  XlFileFormat = TOleEnum;
const
  xlAddIn = $00000012;
  xlCSV = $00000006;
  xlCSVMac = $00000016;
  xlCSVMSDOS = $00000018;
  xlCSVWindows = $00000017;
  xlDBF2 = $00000007;
  xlDBF3 = $00000008;
  xlDBF4 = $0000000B;
  xlDIF = $00000009;
  xlExcel2 = $00000010;
  xlExcel2FarEast = $0000001B;
  xlExcel3 = $0000001D;
  xlExcel4 = $00000021;
  xlExcel5 = $00000027;
  xlExcel7 = $00000027;
  xlExcel9795 = $0000002B;
  xlExcel4Workbook = $00000023;
  xlIntlAddIn = $0000001A;
  xlIntlMacro = $00000019;
  xlWorkbookNormal = $FFFFEFD1;
  xlSYLK = $00000002;
  xlTemplate = $00000011;
  xlCurrentPlatformText = $FFFFEFC2;
  xlTextMac = $00000013;
  xlTextMSDOS = $00000015;
  xlTextPrinter = $00000024;
  xlTextWindows = $00000014;
  xlWJ2WD1 = $0000000E;
  xlWK1 = $00000005;
  xlWK1ALL = $0000001F;
  xlWK1FMT = $0000001E;
  xlWK3 = $0000000F;
  xlWK4 = $00000026;
  xlWK3FM3 = $00000020;
  xlWKS = $00000004;
  xlWorks2FarEast = $0000001C;
  xlWQ1 = $00000022;
  xlWJ3 = $00000028;
  xlWJ3FJ3 = $00000029;

// XlApplicationInternational constants
type
  XlApplicationInternational = TOleEnum;
const
  xl24HourClock = $00000021;
  xl4DigitYears = $0000002B;
  xlAlternateArraySeparator = $00000010;
  xlColumnSeparator = $0000000E;
  xlCountryCode = $00000001;
  xlCountrySetting = $00000002;
  xlCurrencyBefore = $00000025;
  xlCurrencyCode = $00000019;
  xlCurrencyDigits = $0000001B;
  xlCurrencyLeadingZeros = $00000028;
  xlCurrencyMinusSign = $00000026;
  xlCurrencyNegative = $0000001C;
  xlCurrencySpaceBefore = $00000024;
  xlCurrencyTrailingZeros = $00000027;
  xlDateOrder = $00000020;
  xlDateSeparator = $00000011;
  xlDayCode = $00000015;
  xlDayLeadingZero = $0000002A;
  xlDecimalSeparator = $00000003;
  xlGeneralFormatName = $0000001A;
  xlHourCode = $00000016;
  xlLeftBrace = $0000000C;
  xlLeftBracket = $0000000A;
  xlListSeparator = $00000005;
  xlLowerCaseColumnLetter = $00000009;
  xlLowerCaseRowLetter = $00000008;
  xlMDY = $0000002C;
  xlMetric = $00000023;
  xlMinuteCode = $00000017;
  xlMonthCode = $00000014;
  xlMonthLeadingZero = $00000029;
  xlMonthNameChars = $0000001E;
  xlNoncurrencyDigits = $0000001D;
  xlNonEnglishFunctions = $00000022;
  xlRightBrace = $0000000D;
  xlRightBracket = $0000000B;
  xlRowSeparator = $0000000F;
  xlSecondCode = $00000018;
  xlThousandsSeparator = $00000004;
  xlTimeLeadingZero = $0000002D;
  xlTimeSeparator = $00000012;
  xlUpperCaseColumnLetter = $00000007;
  xlUpperCaseRowLetter = $00000006;
  xlWeekdayNameChars = $0000001F;
  xlYearCode = $00000013;

// XlPageBreakExtent constants
type
  XlPageBreakExtent = TOleEnum;
const
  xlPageBreakFull = $00000001;
  xlPageBreakPartial = $00000002;

// XlCellInsertionMode constants
type
  XlCellInsertionMode = TOleEnum;
const
  xlOverwriteCells = $00000000;
  xlInsertDeleteCells = $00000001;
  xlInsertEntireRows = $00000002;

// XlFormulaLabel constants
type
  XlFormulaLabel = TOleEnum;
const
  xlNoLabels = $FFFFEFD2;
  xlRowLabels = $00000001;
  xlColumnLabels = $00000002;
  xlMixedLabels = $00000003;

// XlHighlightChangesTime constants
type
  XlHighlightChangesTime = TOleEnum;
const
  xlSinceMyLastSave = $00000001;
  xlAllChanges = $00000002;
  xlNotYetReviewed = $00000003;

// XlCommentDisplayMode constants
type
  XlCommentDisplayMode = TOleEnum;
const
  xlNoIndicator = $00000000;
  xlCommentIndicatorOnly = $FFFFFFFF;
  xlCommentAndIndicator = $00000001;

// XlFormatConditionType constants
type
  XlFormatConditionType = TOleEnum;
const
  xlCellValue = $00000001;
  xlExpression = $00000002;

// XlFormatConditionOperator constants
type
  XlFormatConditionOperator = TOleEnum;
const
  xlBetween = $00000001;
  xlNotBetween = $00000002;
  xlEqual = $00000003;
  xlNotEqual = $00000004;
  xlGreater = $00000005;
  xlLess = $00000006;
  xlGreaterEqual = $00000007;
  xlLessEqual = $00000008;

// XlEnableSelection constants
type
  XlEnableSelection = TOleEnum;
const
  xlNoRestrictions = $00000000;
  xlUnlockedCells = $00000001;
  xlNoSelection = $FFFFEFD2;

// XlDVType constants
type
  XlDVType = TOleEnum;
const
  xlValidateInputOnly = $00000000;
  xlValidateWholeNumber = $00000001;
  xlValidateDecimal = $00000002;
  xlValidateList = $00000003;
  xlValidateDate = $00000004;
  xlValidateTime = $00000005;
  xlValidateTextLength = $00000006;
  xlValidateCustom = $00000007;

// XlIMEMode constants
type
  XlIMEMode = TOleEnum;
const
  xlIMEModeNoControl = $00000000;
  xlIMEModeOn = $00000001;
  xlIMEModeOff = $00000002;
  xlIMEModeDisable = $00000003;
  xlIMEModeHiragana = $00000004;
  xlIMEModeKatakana = $00000005;
  xlIMEModeKatakanaHalf = $00000006;
  xlIMEModeAlphaFull = $00000007;
  xlIMEModeAlpha = $00000008;
  xlIMEModeHangulFull = $00000009;
  xlIMEModeHangul = $0000000A;

// XlDVAlertStyle constants
type
  XlDVAlertStyle = TOleEnum;
const
  xlValidAlertStop = $00000001;
  xlValidAlertWarning = $00000002;
  xlValidAlertInformation = $00000003;

// XlChartLocation constants
type
  XlChartLocation = TOleEnum;
const
  xlLocationAsNewSheet = $00000001;
  xlLocationAsObject = $00000002;
  xlLocationAutomatic = $00000003;

// XlPaperSize constants
type
  XlPaperSize = TOleEnum;
const
  xlPaper10x14 = $00000010;
  xlPaper11x17 = $00000011;
  xlPaperA3 = $00000008;
  xlPaperA4 = $00000009;
  xlPaperA4Small = $0000000A;
  xlPaperA5 = $0000000B;
  xlPaperB4 = $0000000C;
  xlPaperB5 = $0000000D;
  xlPaperCsheet = $00000018;
  xlPaperDsheet = $00000019;
  xlPaperEnvelope10 = $00000014;
  xlPaperEnvelope11 = $00000015;
  xlPaperEnvelope12 = $00000016;
  xlPaperEnvelope14 = $00000017;
  xlPaperEnvelope9 = $00000013;
  xlPaperEnvelopeB4 = $00000021;
  xlPaperEnvelopeB5 = $00000022;
  xlPaperEnvelopeB6 = $00000023;
  xlPaperEnvelopeC3 = $0000001D;
  xlPaperEnvelopeC4 = $0000001E;
  xlPaperEnvelopeC5 = $0000001C;
  xlPaperEnvelopeC6 = $0000001F;
  xlPaperEnvelopeC65 = $00000020;
  xlPaperEnvelopeDL = $0000001B;
  xlPaperEnvelopeItaly = $00000024;
  xlPaperEnvelopeMonarch = $00000025;
  xlPaperEnvelopePersonal = $00000026;
  xlPaperEsheet = $0000001A;
  xlPaperExecutive = $00000007;
  xlPaperFanfoldLegalGerman = $00000029;
  xlPaperFanfoldStdGerman = $00000028;
  xlPaperFanfoldUS = $00000027;
  xlPaperFolio = $0000000E;
  xlPaperLedger = $00000004;
  xlPaperLegal = $00000005;
  xlPaperLetter = $00000001;
  xlPaperLetterSmall = $00000002;
  xlPaperNote = $00000012;
  xlPaperQuarto = $0000000F;
  xlPaperStatement = $00000006;
  xlPaperTabloid = $00000003;
  xlPaperUser = $00000100;

// XlPasteSpecialOperation constants
type
  XlPasteSpecialOperation = TOleEnum;
const
  xlPasteSpecialOperationAdd = $00000002;
  xlPasteSpecialOperationDivide = $00000005;
  xlPasteSpecialOperationMultiply = $00000004;
  xlPasteSpecialOperationNone = $FFFFEFD2;
  xlPasteSpecialOperationSubtract = $00000003;

// XlPasteType constants
type
  XlPasteType = TOleEnum;
const
  xlPasteAll = $FFFFEFF8;
  xlPasteAllExceptBorders = $00000006;
  xlPasteFormats = $FFFFEFE6;
  xlPasteFormulas = $FFFFEFE5;
  xlPasteComments = $FFFFEFD0;
  xlPasteValues = $FFFFEFBD;

// XlPhoneticCharacterType constants
type
  XlPhoneticCharacterType = TOleEnum;
const
  xlKatakanaHalf = $00000000;
  xlKatakana = $00000001;
  xlHiragana = $00000002;
  xlNoConversion = $00000003;

// XlPhoneticAlignment constants
type
  XlPhoneticAlignment = TOleEnum;
const
  xlPhoneticAlignNoControl = $00000000;
  xlPhoneticAlignLeft = $00000001;
  xlPhoneticAlignCenter = $00000002;
  xlPhoneticAlignDistributed = $00000003;

// XlPictureAppearance constants
type
  XlPictureAppearance = TOleEnum;
const
  xlPrinter = $00000002;
  xlScreen = $00000001;

// XlPivotFieldOrientation constants
type
  XlPivotFieldOrientation = TOleEnum;
const
  xlColumnField = $00000002;
  xlDataField = $00000004;
  xlHidden = $00000000;
  xlPageField = $00000003;
  xlRowField = $00000001;

// XlPivotFieldCalculation constants
type
  XlPivotFieldCalculation = TOleEnum;
const
  xlDifferenceFrom = $00000002;
  xlIndex = $00000009;
  xlNoAdditionalCalculation = $FFFFEFD1;
  xlPercentDifferenceFrom = $00000004;
  xlPercentOf = $00000003;
  xlPercentOfColumn = $00000007;
  xlPercentOfRow = $00000006;
  xlPercentOfTotal = $00000008;
  xlRunningTotal = $00000005;

// XlPlacement constants
type
  XlPlacement = TOleEnum;
const
  xlFreeFloating = $00000003;
  xlMove = $00000002;
  xlMoveAndSize = $00000001;

// XlPlatform constants
type
  XlPlatform = TOleEnum;
const
  xlMacintosh = $00000001;
  xlMSDOS = $00000003;
  xlWindows = $00000002;

// XlPrintLocation constants
type
  XlPrintLocation = TOleEnum;
const
  xlPrintSheetEnd = $00000001;
  xlPrintInPlace = $00000010;
  xlPrintNoComments = $FFFFEFD2;

// XlPriority constants
type
  XlPriority = TOleEnum;
const
  xlPriorityHigh = $FFFFEFE1;
  xlPriorityLow = $FFFFEFDA;
  xlPriorityNormal = $FFFFEFD1;

// XlPTSelectionMode constants
type
  XlPTSelectionMode = TOleEnum;
const
  xlLabelOnly = $00000001;
  xlDataAndLabel = $00000000;
  xlDataOnly = $00000002;
  xlOrigin = $00000003;
  xlButton = $0000000F;
  xlBlanks = $00000004;

// XlRangeAutoFormat constants
type
  XlRangeAutoFormat = TOleEnum;
const
  xlRangeAutoFormat3DEffects1 = $0000000D;
  xlRangeAutoFormat3DEffects2 = $0000000E;
  xlRangeAutoFormatAccounting1 = $00000004;
  xlRangeAutoFormatAccounting2 = $00000005;
  xlRangeAutoFormatAccounting3 = $00000006;
  xlRangeAutoFormatAccounting4 = $00000011;
  xlRangeAutoFormatClassic1 = $00000001;
  xlRangeAutoFormatClassic2 = $00000002;
  xlRangeAutoFormatClassic3 = $00000003;
  xlRangeAutoFormatColor1 = $00000007;
  xlRangeAutoFormatColor2 = $00000008;
  xlRangeAutoFormatColor3 = $00000009;
  xlRangeAutoFormatList1 = $0000000A;
  xlRangeAutoFormatList2 = $0000000B;
  xlRangeAutoFormatList3 = $0000000C;
  xlRangeAutoFormatLocalFormat1 = $0000000F;
  xlRangeAutoFormatLocalFormat2 = $00000010;
  xlRangeAutoFormatLocalFormat3 = $00000013;
  xlRangeAutoFormatLocalFormat4 = $00000014;
  xlRangeAutoFormatNone = $FFFFEFD2;
  xlRangeAutoFormatSimple = $FFFFEFC6;

// XlReferenceType constants
type
  XlReferenceType = TOleEnum;
const
  xlAbsolute = $00000001;
  xlAbsRowRelColumn = $00000002;
  xlRelative = $00000004;
  xlRelRowAbsColumn = $00000003;

// XlRoutingSlipDelivery constants
type
  XlRoutingSlipDelivery = TOleEnum;
const
  xlAllAtOnce = $00000002;
  xlOneAfterAnother = $00000001;

// XlRoutingSlipStatus constants
type
  XlRoutingSlipStatus = TOleEnum;
const
  xlNotYetRouted = $00000000;
  xlRoutingComplete = $00000002;
  xlRoutingInProgress = $00000001;

// XlRunAutoMacro constants
type
  XlRunAutoMacro = TOleEnum;
const
  xlAutoActivate = $00000003;
  xlAutoClose = $00000002;
  xlAutoDeactivate = $00000004;
  xlAutoOpen = $00000001;

// XlSaveAction constants
type
  XlSaveAction = TOleEnum;
const
  xlDoNotSaveChanges = $00000002;
  xlSaveChanges = $00000001;

// XlSaveAsAccessMode constants
type
  XlSaveAsAccessMode = TOleEnum;
const
  xlExclusive = $00000003;
  xlNoChange = $00000001;
  xlShared = $00000002;

// XlSaveConflictResolution constants
type
  XlSaveConflictResolution = TOleEnum;
const
  xlLocalSessionChanges = $00000002;
  xlOtherSessionChanges = $00000003;
  xlUserResolution = $00000001;

// XlSearchDirection constants
type
  XlSearchDirection = TOleEnum;
const
  xlNext = $00000001;
  xlPrevious = $00000002;

// XlSearchOrder constants
type
  XlSearchOrder = TOleEnum;
const
  xlByColumns = $00000002;
  xlByRows = $00000001;

// XlSheetVisibility constants
type
  XlSheetVisibility = TOleEnum;
const
  xlSheetVisible = $FFFFFFFF;
  xlSheetHidden = $00000000;
  xlSheetVeryHidden = $00000002;

// XlSortMethod constants
type
  XlSortMethod = TOleEnum;
const
  xlPinYin = $00000001;
  xlStroke = $00000002;

// XlSortMethodOld constants
type
  XlSortMethodOld = TOleEnum;
const
  xlCodePage = $00000002;
  xlSyllabary = $00000001;

// XlSortOrder constants
type
  XlSortOrder = TOleEnum;
const
  xlAscending = $00000001;
  xlDescending = $00000002;

// XlSortOrientation constants
type
  XlSortOrientation = TOleEnum;
const
  xlSortRows = $00000002;
  xlSortColumns = $00000001;

// XlSortType constants
type
  XlSortType = TOleEnum;
const
  xlSortLabels = $00000002;
  xlSortValues = $00000001;

// XlSpecialCellsValue constants
type
  XlSpecialCellsValue = TOleEnum;
const
  xlErrors = $00000010;
  xlLogical = $00000004;
  xlNumbers = $00000001;
  xlTextValues = $00000002;

// XlSubscribeToFormat constants
type
  XlSubscribeToFormat = TOleEnum;
const
  xlSubscribeToPicture = $FFFFEFCD;
  xlSubscribeToText = $FFFFEFC2;

// XlSummaryRow constants
type
  XlSummaryRow = TOleEnum;
const
  xlSummaryAbove = $00000000;
  xlSummaryBelow = $00000001;

// XlSummaryColumn constants
type
  XlSummaryColumn = TOleEnum;
const
  xlSummaryOnLeft = $FFFFEFDD;
  xlSummaryOnRight = $FFFFEFC8;

// XlSummaryReportType constants
type
  XlSummaryReportType = TOleEnum;
const
  xlSummaryPivotTable = $FFFFEFCC;
  xlStandardSummary = $00000001;

// XlTabPosition constants
type
  XlTabPosition = TOleEnum;
const
  xlTabPositionFirst = $00000000;
  xlTabPositionLast = $00000001;

// XlTextParsingType constants
type
  XlTextParsingType = TOleEnum;
const
  xlDelimited = $00000001;
  xlFixedWidth = $00000002;

// XlTextQualifier constants
type
  XlTextQualifier = TOleEnum;
const
  xlTextQualifierDoubleQuote = $00000001;
  xlTextQualifierNone = $FFFFEFD2;
  xlTextQualifierSingleQuote = $00000002;

// XlWBATemplate constants
type
  XlWBATemplate = TOleEnum;
const
  xlWBATChart = $FFFFEFF3;
  xlWBATExcel4IntlMacroSheet = $00000004;
  xlWBATExcel4MacroSheet = $00000003;
  xlWBATWorksheet = $FFFFEFB9;

// XlWindowView constants
type
  XlWindowView = TOleEnum;
const
  xlNormalView = $00000001;
  xlPageBreakPreview = $00000002;

// XlXLMMacroType constants
type
  XlXLMMacroType = TOleEnum;
const
  xlCommand = $00000002;
  xlFunction = $00000001;
  xlNotXLM = $00000003;

// XlYesNoGuess constants
type
  XlYesNoGuess = TOleEnum;
const
  xlGuess = $00000000;
  xlNo = $00000002;
  xlYes = $00000001;

// XlDisplayShapes constants
type
  XlDisplayShapes = TOleEnum;
const
  XlDisplayShapes_ = $FFFFEFF8;
  xlHide = $00000003;
  xlPlaceholders = $00000002;

// XlBordersIndex constants
type
  XlBordersIndex = TOleEnum;
const
  xlInsideHorizontal = $0000000C;
  xlInsideVertical = $0000000B;
  xlDiagonalDown = $00000005;
  xlDiagonalUp = $00000006;
  xlEdgeBottom = $00000009;
  xlEdgeLeft = $00000007;
  xlEdgeRight = $0000000A;
  xlEdgeTop = $00000008;

// XlToolbarProtection constants
type
  XlToolbarProtection = TOleEnum;
const
  xlNoButtonChanges = $00000001;
  xlNoChanges = $00000004;
  xlNoDockingChanges = $00000003;
  xlToolbarProtectionNone = $FFFFEFD1;
  xlNoShapeChanges = $00000002;

// XlBuiltInDialog constants
type
  XlBuiltInDialog = TOleEnum;
const
  xlDialogOpen = $00000001;
  xlDialogOpenLinks = $00000002;
  xlDialogSaveAs = $00000005;
  xlDialogFileDelete = $00000006;
  xlDialogPageSetup = $00000007;
  xlDialogPrint = $00000008;
  xlDialogPrinterSetup = $00000009;
  xlDialogArrangeAll = $0000000C;
  xlDialogWindowSize = $0000000D;
  xlDialogWindowMove = $0000000E;
  xlDialogRun = $00000011;
  xlDialogSetPrintTitles = $00000017;
  xlDialogFont = $0000001A;
  xlDialogDisplay = $0000001B;
  xlDialogProtectDocument = $0000001C;
  xlDialogCalculation = $00000020;
  xlDialogExtract = $00000023;
  xlDialogDataDelete = $00000024;
  xlDialogSort = $00000027;
  xlDialogDataSeries = $00000028;
  xlDialogTable = $00000029;
  xlDialogFormatNumber = $0000002A;
  xlDialogAlignment = $0000002B;
  xlDialogStyle = $0000002C;
  xlDialogBorder = $0000002D;
  xlDialogCellProtection = $0000002E;
  xlDialogColumnWidth = $0000002F;
  xlDialogClear = $00000034;
  xlDialogPasteSpecial = $00000035;
  xlDialogEditDelete = $00000036;
  xlDialogInsert = $00000037;
  xlDialogPasteNames = $0000003A;
  xlDialogDefineName = $0000003D;
  xlDialogCreateNames = $0000003E;
  xlDialogFormulaGoto = $0000003F;
  xlDialogFormulaFind = $00000040;
  xlDialogGalleryArea = $00000043;
  xlDialogGalleryBar = $00000044;
  xlDialogGalleryColumn = $00000045;
  xlDialogGalleryLine = $00000046;
  xlDialogGalleryPie = $00000047;
  xlDialogGalleryScatter = $00000048;
  xlDialogCombination = $00000049;
  xlDialogGridlines = $0000004C;
  xlDialogAxes = $0000004E;
  xlDialogAttachText = $00000050;
  xlDialogPatterns = $00000054;
  xlDialogMainChart = $00000055;
  xlDialogOverlay = $00000056;
  xlDialogScale = $00000057;
  xlDialogFormatLegend = $00000058;
  xlDialogFormatText = $00000059;
  xlDialogParse = $0000005B;
  xlDialogUnhide = $0000005E;
  xlDialogWorkspace = $0000005F;
  xlDialogActivate = $00000067;
  xlDialogCopyPicture = $0000006C;
  xlDialogDeleteName = $0000006E;
  xlDialogDeleteFormat = $0000006F;
  xlDialogNew = $00000077;
  xlDialogRowHeight = $0000007F;
  xlDialogFormatMove = $00000080;
  xlDialogFormatSize = $00000081;
  xlDialogFormulaReplace = $00000082;
  xlDialogSelectSpecial = $00000084;
  xlDialogApplyNames = $00000085;
  xlDialogReplaceFont = $00000086;
  xlDialogSplit = $00000089;
  xlDialogOutline = $0000008E;
  xlDialogSaveWorkbook = $00000091;
  xlDialogCopyChart = $00000093;
  xlDialogFormatFont = $00000096;
  xlDialogNote = $0000009A;
  xlDialogSetUpdateStatus = $0000009F;
  xlDialogColorPalette = $000000A1;
  xlDialogChangeLink = $000000A6;
  xlDialogAppMove = $000000AA;
  xlDialogAppSize = $000000AB;
  xlDialogMainChartType = $000000B9;
  xlDialogOverlayChartType = $000000BA;
  xlDialogOpenMail = $000000BC;
  xlDialogSendMail = $000000BD;
  xlDialogStandardFont = $000000BE;
  xlDialogConsolidate = $000000BF;
  xlDialogSortSpecial = $000000C0;
  xlDialogGallery3dArea = $000000C1;
  xlDialogGallery3dColumn = $000000C2;
  xlDialogGallery3dLine = $000000C3;
  xlDialogGallery3dPie = $000000C4;
  xlDialogView3d = $000000C5;
  xlDialogGoalSeek = $000000C6;
  xlDialogWorkgroup = $000000C7;
  xlDialogFillGroup = $000000C8;
  xlDialogUpdateLink = $000000C9;
  xlDialogPromote = $000000CA;
  xlDialogDemote = $000000CB;
  xlDialogShowDetail = $000000CC;
  xlDialogObjectProperties = $000000CF;
  xlDialogSaveNewObject = $000000D0;
  xlDialogApplyStyle = $000000D4;
  xlDialogAssignToObject = $000000D5;
  xlDialogObjectProtection = $000000D6;
  xlDialogCreatePublisher = $000000D9;
  xlDialogSubscribeTo = $000000DA;
  xlDialogShowToolbar = $000000DC;
  xlDialogPrintPreview = $000000DE;
  xlDialogEditColor = $000000DF;
  xlDialogFormatMain = $000000E1;
  xlDialogFormatOverlay = $000000E2;
  xlDialogEditSeries = $000000E4;
  xlDialogDefineStyle = $000000E5;
  xlDialogGalleryRadar = $000000F9;
  xlDialogEditionOptions = $000000FB;
  xlDialogZoom = $00000100;
  xlDialogInsertObject = $00000103;
  xlDialogSize = $00000105;
  xlDialogMove = $00000106;
  xlDialogFormatAuto = $0000010D;
  xlDialogGallery3dBar = $00000110;
  xlDialogGallery3dSurface = $00000111;
  xlDialogCustomizeToolbar = $00000114;
  xlDialogWorkbookAdd = $00000119;
  xlDialogWorkbookMove = $0000011A;
  xlDialogWorkbookCopy = $0000011B;
  xlDialogWorkbookOptions = $0000011C;
  xlDialogSaveWorkspace = $0000011D;
  xlDialogChartWizard = $00000120;
  xlDialogAssignToTool = $00000125;
  xlDialogPlacement = $0000012C;
  xlDialogFillWorkgroup = $0000012D;
  xlDialogWorkbookNew = $0000012E;
  xlDialogScenarioCells = $00000131;
  xlDialogScenarioAdd = $00000133;
  xlDialogScenarioEdit = $00000134;
  xlDialogScenarioSummary = $00000137;
  xlDialogPivotTableWizard = $00000138;
  xlDialogPivotFieldProperties = $00000139;
  xlDialogOptionsCalculation = $0000013E;
  xlDialogOptionsEdit = $0000013F;
  xlDialogOptionsView = $00000140;
  xlDialogAddinManager = $00000141;
  xlDialogMenuEditor = $00000142;
  xlDialogAttachToolbars = $00000143;
  xlDialogOptionsChart = $00000145;
  xlDialogVbaInsertFile = $00000148;
  xlDialogVbaProcedureDefinition = $0000014A;
  xlDialogRoutingSlip = $00000150;
  xlDialogMailLogon = $00000153;
  xlDialogInsertPicture = $00000156;
  xlDialogGalleryDoughnut = $00000158;
  xlDialogChartTrend = $0000015E;
  xlDialogWorkbookInsert = $00000162;
  xlDialogOptionsTransition = $00000163;
  xlDialogOptionsGeneral = $00000164;
  xlDialogFilterAdvanced = $00000172;
  xlDialogMailNextLetter = $0000017A;
  xlDialogDataLabel = $0000017B;
  xlDialogInsertTitle = $0000017C;
  xlDialogFontProperties = $0000017D;
  xlDialogMacroOptions = $0000017E;
  xlDialogWorkbookUnhide = $00000180;
  xlDialogWorkbookName = $00000182;
  xlDialogGalleryCustom = $00000184;
  xlDialogAddChartAutoformat = $00000186;
  xlDialogChartAddData = $00000188;
  xlDialogTabOrder = $0000018A;
  xlDialogSubtotalCreate = $0000018E;
  xlDialogWorkbookTabSplit = $0000019F;
  xlDialogWorkbookProtect = $000001A1;
  xlDialogScrollbarProperties = $000001A4;
  xlDialogPivotShowPages = $000001A5;
  xlDialogTextToColumns = $000001A6;
  xlDialogFormatCharttype = $000001A7;
  xlDialogPivotFieldGroup = $000001B1;
  xlDialogPivotFieldUngroup = $000001B2;
  xlDialogCheckboxProperties = $000001B3;
  xlDialogLabelProperties = $000001B4;
  xlDialogListboxProperties = $000001B5;
  xlDialogEditboxProperties = $000001B6;
  xlDialogOpenText = $000001B9;
  xlDialogPushbuttonProperties = $000001BD;
  xlDialogFilter = $000001BF;
  xlDialogFunctionWizard = $000001C2;
  xlDialogSaveCopyAs = $000001C8;
  xlDialogOptionsListsAdd = $000001CA;
  xlDialogSeriesAxes = $000001CC;
  xlDialogSeriesX = $000001CD;
  xlDialogSeriesY = $000001CE;
  xlDialogErrorbarX = $000001CF;
  xlDialogErrorbarY = $000001D0;
  xlDialogFormatChart = $000001D1;
  xlDialogSeriesOrder = $000001D2;
  xlDialogMailEditMailer = $000001D6;
  xlDialogStandardWidth = $000001D8;
  xlDialogScenarioMerge = $000001D9;
  xlDialogProperties = $000001DA;
  xlDialogSummaryInfo = $000001DA;
  xlDialogFindFile = $000001DB;
  xlDialogActiveCellFont = $000001DC;
  xlDialogVbaMakeAddin = $000001DE;
  xlDialogFileSharing = $000001E1;
  xlDialogAutoCorrect = $000001E5;
  xlDialogCustomViews = $000001ED;
  xlDialogInsertNameLabel = $000001F0;
  xlDialogSeriesShape = $000001F8;
  xlDialogChartOptionsDataLabels = $000001F9;
  xlDialogChartOptionsDataTable = $000001FA;
  xlDialogSetBackgroundPicture = $000001FD;
  xlDialogDataValidation = $0000020D;
  xlDialogChartType = $0000020E;
  xlDialogChartLocation = $0000020F;
  xlDialogPhonetic = $0000021A;
  xlDialogChartSourceData = $0000021D;
  xlDialogSeriesOptions = $0000022D;
  xlDialogPivotTableOptions = $00000237;
  xlDialogPivotSolveOrder = $00000238;
  xlDialogPivotCalculatedField = $0000023A;
  xlDialogPivotCalculatedItem = $0000023C;
  xlDialogConditionalFormatting = $00000247;
  xlDialogInsertHyperlink = $00000254;
  xlDialogProtectSharing = $0000026C;

// XlParameterType constants
type
  XlParameterType = TOleEnum;
const
  xlPrompt = $00000000;
  xlConstant = $00000001;
  xlRange = $00000002;

// XlParameterDataType constants
type
  XlParameterDataType = TOleEnum;
const
  xlParamTypeUnknown = $00000000;
  xlParamTypeChar = $00000001;
  xlParamTypeNumeric = $00000002;
  xlParamTypeDecimal = $00000003;
  xlParamTypeInteger = $00000004;
  xlParamTypeSmallInt = $00000005;
  xlParamTypeFloat = $00000006;
  xlParamTypeReal = $00000007;
  xlParamTypeDouble = $00000008;
  xlParamTypeVarChar = $0000000C;
  xlParamTypeDate = $00000009;
  xlParamTypeTime = $0000000A;
  xlParamTypeTimestamp = $0000000B;
  xlParamTypeLongVarChar = $FFFFFFFF;
  xlParamTypeBinary = $FFFFFFFE;
  xlParamTypeVarBinary = $FFFFFFFD;
  xlParamTypeLongVarBinary = $FFFFFFFC;
  xlParamTypeBigInt = $FFFFFFFB;
  xlParamTypeTinyInt = $FFFFFFFA;
  xlParamTypeBit = $FFFFFFF9;

// XlFormControl constants
type
  XlFormControl = TOleEnum;
const
  xlButtonControl = $00000000;
  xlCheckBox = $00000001;
  xlDropDown = $00000002;
  xlEditBox = $00000003;
  xlGroupBox = $00000004;
  xlLabel = $00000005;
  xlListBox = $00000006;
  xlOptionButton = $00000007;
  xlScrollBar = $00000008;
  xlSpinner = $00000009;

implementation

end.

