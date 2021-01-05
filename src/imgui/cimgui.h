#ifndef CIMGUI_INCLUDED
#define CIMGUI_INCLUDED
#include <stdio.h>
#include <stdint.h>
#if defined _WIN32 || defined __CYGWIN__
#ifdef CIMGUI_NO_EXPORT
#define API
#else
#define API __declspec(dllexport)
#endif
#ifndef __GNUC__
#define snprintf sprintf_s
#endif
#else
#ifdef __GNUC__
#define API __attribute__((__visibility__("default")))
#else
#define API
#endif
#endif

#if defined __cplusplus
#define EXTERN extern "C"
#else
#include <stdarg.h>
#include <stdbool.h>
#define EXTERN extern
#endif

#define CIMGUI_API EXTERN API
#define CONST const

#ifdef _MSC_VER
typedef unsigned __int64 ImU64;
#else
//typedef unsigned long long ImU64;
#endif

#ifdef CIMGUI_DEFINE_ENUMS_AND_STRUCTS
typedef struct ImGuiPtrOrIndex ImGuiPtrOrIndex;
typedef struct ImGuiShrinkWidthItem ImGuiShrinkWidthItem;
typedef struct ImGuiDataTypeTempStorage ImGuiDataTypeTempStorage;
typedef struct ImVec2ih ImVec2ih;
typedef struct ImVec1 ImVec1;
typedef struct StbTexteditRow StbTexteditRow;
typedef struct STB_TexteditState STB_TexteditState;
typedef struct StbUndoState StbUndoState;
typedef struct StbUndoRecord StbUndoRecord;
typedef struct ImGuiWindowSettings ImGuiWindowSettings;
typedef struct ImGuiWindowTempData ImGuiWindowTempData;
typedef struct ImGuiWindow ImGuiWindow;
typedef struct ImGuiTabItem ImGuiTabItem;
typedef struct ImGuiTabBar ImGuiTabBar;
typedef struct ImGuiStyleMod ImGuiStyleMod;
typedef struct ImGuiSettingsHandler ImGuiSettingsHandler;
typedef struct ImGuiPopupData ImGuiPopupData;
typedef struct ImGuiNextItemData ImGuiNextItemData;
typedef struct ImGuiNextWindowData ImGuiNextWindowData;
typedef struct ImGuiNavMoveResult ImGuiNavMoveResult;
typedef struct ImGuiMenuColumns ImGuiMenuColumns;
typedef struct ImGuiLastItemDataBackup ImGuiLastItemDataBackup;
typedef struct ImGuiInputTextState ImGuiInputTextState;
typedef struct ImGuiGroupData ImGuiGroupData;
typedef struct ImGuiDataTypeInfo ImGuiDataTypeInfo;
typedef struct ImGuiColumns ImGuiColumns;
typedef struct ImGuiColumnData ImGuiColumnData;
typedef struct ImGuiColorMod ImGuiColorMod;
typedef struct ImDrawDataBuilder ImDrawDataBuilder;
typedef struct ImRect ImRect;
typedef struct ImBitVector ImBitVector;
typedef struct ImFontAtlasCustomRect ImFontAtlasCustomRect;
typedef struct ImGuiStoragePair ImGuiStoragePair;
typedef struct ImGuiTextRange ImGuiTextRange;
typedef struct ImVec4 ImVec4;
typedef struct ImVec2 ImVec2;
typedef struct ImGuiTextFilter ImGuiTextFilter;
typedef struct ImGuiTextBuffer ImGuiTextBuffer;
typedef struct ImGuiStyle ImGuiStyle;
typedef struct ImGuiStorage ImGuiStorage;
typedef struct ImGuiSizeCallbackData ImGuiSizeCallbackData;
typedef struct ImGuiPayload ImGuiPayload;
typedef struct ImGuiOnceUponAFrame ImGuiOnceUponAFrame;
typedef struct ImGuiListClipper ImGuiListClipper;
typedef struct ImGuiInputTextCallbackData ImGuiInputTextCallbackData;
typedef struct ImGuiIO ImGuiIO;
typedef struct ImGuiContext ImGuiContext;
typedef struct ImColor ImColor;
typedef struct ImFontGlyphRangesBuilder ImFontGlyphRangesBuilder;
typedef struct ImFontGlyph ImFontGlyph;
typedef struct ImFontConfig ImFontConfig;
typedef struct ImFontAtlas ImFontAtlas;
typedef struct ImFont ImFont;
typedef struct ImDrawVert ImDrawVert;
typedef struct ImDrawListSplitter ImDrawListSplitter;
typedef struct ImDrawListSharedData ImDrawListSharedData;
typedef struct ImDrawList ImDrawList;
typedef struct ImDrawData ImDrawData;
typedef struct ImDrawCmd ImDrawCmd;
typedef struct ImDrawChannel ImDrawChannel;

struct ImDrawChannel;
struct ImDrawCmd;
struct ImDrawData;
struct ImDrawList;
struct ImDrawListSharedData;
struct ImDrawListSplitter;
struct ImDrawVert;
struct ImFont;
struct ImFontAtlas;
struct ImFontConfig;
struct ImFontGlyph;
struct ImFontGlyphRangesBuilder;
struct ImColor;
struct ImGuiContext;
struct ImGuiIO;
struct ImGuiInputTextCallbackData;
struct ImGuiListClipper;
struct ImGuiOnceUponAFrame;
struct ImGuiPayload;
struct ImGuiSizeCallbackData;
struct ImGuiStorage;
struct ImGuiStyle;
struct ImGuiTextBuffer;
struct ImGuiTextFilter;
typedef int ImGuiCol;
typedef int ImGuiCond;
typedef int ImGuiDataType;
typedef int ImGuiDir;
typedef int ImGuiKey;
typedef int ImGuiNavInput;
typedef int ImGuiMouseButton;
typedef int ImGuiMouseCursor;
typedef int ImGuiStyleVar;
typedef int ImDrawCornerFlags;
typedef int ImDrawListFlags;
typedef int ImFontAtlasFlags;
typedef int ImGuiBackendFlags;
typedef int ImGuiButtonFlags;
typedef int ImGuiColorEditFlags;
typedef int ImGuiConfigFlags;
typedef int ImGuiComboFlags;
typedef int ImGuiDragDropFlags;
typedef int ImGuiFocusedFlags;
typedef int ImGuiHoveredFlags;
typedef int ImGuiInputTextFlags;
typedef int ImGuiKeyModFlags;
typedef int ImGuiPopupFlags;
typedef int ImGuiSelectableFlags;
typedef int ImGuiSliderFlags;
typedef int ImGuiTabBarFlags;
typedef int ImGuiTabItemFlags;
typedef int ImGuiTreeNodeFlags;
typedef int ImGuiWindowFlags;
typedef void *ImTextureID;
typedef unsigned int ImGuiID;
typedef int (*ImGuiInputTextCallback)(ImGuiInputTextCallbackData *data);
typedef void (*ImGuiSizeCallback)(ImGuiSizeCallbackData *data);
typedef unsigned short ImWchar16;
typedef unsigned int ImWchar32;
typedef ImWchar16 ImWchar;
typedef signed char ImS8;
typedef unsigned char ImU8;
typedef signed short ImS16;
typedef unsigned short ImU16;
typedef signed int ImS32;
typedef unsigned int ImU32;
typedef int64_t ImS64;
typedef uint64_t ImU64;
typedef void (*ImDrawCallback)(const ImDrawList *parent_list, const ImDrawCmd *cmd);
typedef unsigned short ImDrawIdx;
struct ImBitVector;
struct ImRect;
struct ImDrawDataBuilder;
struct ImDrawListSharedData;
struct ImGuiColorMod;
struct ImGuiColumnData;
struct ImGuiColumns;
struct ImGuiContext;
struct ImGuiDataTypeInfo;
struct ImGuiGroupData;
struct ImGuiInputTextState;
struct ImGuiLastItemDataBackup;
struct ImGuiMenuColumns;
struct ImGuiNavMoveResult;
struct ImGuiNextWindowData;
struct ImGuiNextItemData;
struct ImGuiPopupData;
struct ImGuiSettingsHandler;
struct ImGuiStyleMod;
struct ImGuiTabBar;
struct ImGuiTabItem;
struct ImGuiWindow;
struct ImGuiWindowTempData;
struct ImGuiWindowSettings;
typedef int ImGuiLayoutType;
typedef int ImGuiButtonFlags;
typedef int ImGuiColumnsFlags;
typedef int ImGuiItemFlags;
typedef int ImGuiItemStatusFlags;
typedef int ImGuiNavHighlightFlags;
typedef int ImGuiNavDirSourceFlags;
typedef int ImGuiNavMoveFlags;
typedef int ImGuiNextItemDataFlags;
typedef int ImGuiNextWindowDataFlags;
typedef int ImGuiSeparatorFlags;
typedef int ImGuiTextFlags;
typedef int ImGuiTooltipFlags;
extern ImGuiContext *GImGui;
typedef FILE *ImFileHandle;
typedef int ImPoolIdx;
typedef struct ImVector
{
  int Size;
  int Capacity;
  void *Data;
} ImVector;
typedef struct ImVector_ImGuiWindowSettings
{
  int Size;
  int Capacity;
  ImGuiWindowSettings *Data;
} ImVector_ImGuiWindowSettings;
typedef struct ImChunkStream_ImGuiWindowSettings
{
  ImVector_ImGuiWindowSettings Buf;
} ImChunkStream_ImGuiWindowSettings;
typedef struct ImVector_ImDrawChannel
{
  int Size;
  int Capacity;
  ImDrawChannel *Data;
} ImVector_ImDrawChannel;
typedef struct ImVector_ImDrawCmd
{
  int Size;
  int Capacity;
  ImDrawCmd *Data;
} ImVector_ImDrawCmd;
typedef struct ImVector_ImDrawIdx
{
  int Size;
  int Capacity;
  ImDrawIdx *Data;
} ImVector_ImDrawIdx;
typedef struct ImVector_ImDrawListPtr
{
  int Size;
  int Capacity;
  ImDrawList **Data;
} ImVector_ImDrawListPtr;
typedef struct ImVector_ImDrawVert
{
  int Size;
  int Capacity;
  ImDrawVert *Data;
} ImVector_ImDrawVert;
typedef struct ImVector_ImFontPtr
{
  int Size;
  int Capacity;
  ImFont **Data;
} ImVector_ImFontPtr;
typedef struct ImVector_ImFontAtlasCustomRect
{
  int Size;
  int Capacity;
  ImFontAtlasCustomRect *Data;
} ImVector_ImFontAtlasCustomRect;
typedef struct ImVector_ImFontConfig
{
  int Size;
  int Capacity;
  ImFontConfig *Data;
} ImVector_ImFontConfig;
typedef struct ImVector_ImFontGlyph
{
  int Size;
  int Capacity;
  ImFontGlyph *Data;
} ImVector_ImFontGlyph;
typedef struct ImVector_ImGuiColorMod
{
  int Size;
  int Capacity;
  ImGuiColorMod *Data;
} ImVector_ImGuiColorMod;
typedef struct ImVector_ImGuiColumnData
{
  int Size;
  int Capacity;
  ImGuiColumnData *Data;
} ImVector_ImGuiColumnData;
typedef struct ImVector_ImGuiColumns
{
  int Size;
  int Capacity;
  ImGuiColumns *Data;
} ImVector_ImGuiColumns;
typedef struct ImVector_ImGuiGroupData
{
  int Size;
  int Capacity;
  ImGuiGroupData *Data;
} ImVector_ImGuiGroupData;
typedef struct ImVector_ImGuiID
{
  int Size;
  int Capacity;
  ImGuiID *Data;
} ImVector_ImGuiID;
typedef struct ImVector_ImGuiItemFlags
{
  int Size;
  int Capacity;
  ImGuiItemFlags *Data;
} ImVector_ImGuiItemFlags;
typedef struct ImVector_ImGuiPopupData
{
  int Size;
  int Capacity;
  ImGuiPopupData *Data;
} ImVector_ImGuiPopupData;
typedef struct ImVector_ImGuiPtrOrIndex
{
  int Size;
  int Capacity;
  ImGuiPtrOrIndex *Data;
} ImVector_ImGuiPtrOrIndex;
typedef struct ImVector_ImGuiSettingsHandler
{
  int Size;
  int Capacity;
  ImGuiSettingsHandler *Data;
} ImVector_ImGuiSettingsHandler;
typedef struct ImVector_ImGuiShrinkWidthItem
{
  int Size;
  int Capacity;
  ImGuiShrinkWidthItem *Data;
} ImVector_ImGuiShrinkWidthItem;
typedef struct ImVector_ImGuiStoragePair
{
  int Size;
  int Capacity;
  ImGuiStoragePair *Data;
} ImVector_ImGuiStoragePair;
typedef struct ImVector_ImGuiStyleMod
{
  int Size;
  int Capacity;
  ImGuiStyleMod *Data;
} ImVector_ImGuiStyleMod;
typedef struct ImVector_ImGuiTabItem
{
  int Size;
  int Capacity;
  ImGuiTabItem *Data;
} ImVector_ImGuiTabItem;
typedef struct ImVector_ImGuiTextRange
{
  int Size;
  int Capacity;
  ImGuiTextRange *Data;
} ImVector_ImGuiTextRange;
typedef struct ImVector_ImGuiWindowPtr
{
  int Size;
  int Capacity;
  ImGuiWindow **Data;
} ImVector_ImGuiWindowPtr;
typedef struct ImVector_ImTextureID
{
  int Size;
  int Capacity;
  ImTextureID *Data;
} ImVector_ImTextureID;
typedef struct ImVector_ImU32
{
  int Size;
  int Capacity;
  ImU32 *Data;
} ImVector_ImU32;
typedef struct ImVector_ImVec2
{
  int Size;
  int Capacity;
  ImVec2 *Data;
} ImVector_ImVec2;
typedef struct ImVector_ImVec4
{
  int Size;
  int Capacity;
  ImVec4 *Data;
} ImVector_ImVec4;
typedef struct ImVector_ImWchar
{
  int Size;
  int Capacity;
  ImWchar *Data;
} ImVector_ImWchar;
typedef struct ImVector_char
{
  int Size;
  int Capacity;
  char *Data;
} ImVector_char;
typedef struct ImVector_float
{
  int Size;
  int Capacity;
  float *Data;
} ImVector_float;
typedef struct ImVector_unsigned_char
{
  int Size;
  int Capacity;
  unsigned char *Data;
} ImVector_unsigned_char;

struct ImVec2
{
  float x, y;
};
struct ImVec4
{
  float x, y, z, w;
};
typedef enum
{
  ImGuiWindowFlags_None = 0,
  ImGuiWindowFlags_NoTitleBar = 1 << 0,
  ImGuiWindowFlags_NoResize = 1 << 1,
  ImGuiWindowFlags_NoMove = 1 << 2,
  ImGuiWindowFlags_NoScrollbar = 1 << 3,
  ImGuiWindowFlags_NoScrollWithMouse = 1 << 4,
  ImGuiWindowFlags_NoCollapse = 1 << 5,
  ImGuiWindowFlags_AlwaysAutoResize = 1 << 6,
  ImGuiWindowFlags_NoBackground = 1 << 7,
  ImGuiWindowFlags_NoSavedSettings = 1 << 8,
  ImGuiWindowFlags_NoMouseInputs = 1 << 9,
  ImGuiWindowFlags_MenuBar = 1 << 10,
  ImGuiWindowFlags_HorizontalScrollbar = 1 << 11,
  ImGuiWindowFlags_NoFocusOnAppearing = 1 << 12,
  ImGuiWindowFlags_NoBringToFrontOnFocus = 1 << 13,
  ImGuiWindowFlags_AlwaysVerticalScrollbar = 1 << 14,
  ImGuiWindowFlags_AlwaysHorizontalScrollbar = 1 << 15,
  ImGuiWindowFlags_AlwaysUseWindowPadding = 1 << 16,
  ImGuiWindowFlags_NoNavInputs = 1 << 18,
  ImGuiWindowFlags_NoNavFocus = 1 << 19,
  ImGuiWindowFlags_UnsavedDocument = 1 << 20,
  ImGuiWindowFlags_NoNav = ImGuiWindowFlags_NoNavInputs | ImGuiWindowFlags_NoNavFocus,
  ImGuiWindowFlags_NoDecoration = ImGuiWindowFlags_NoTitleBar | ImGuiWindowFlags_NoResize | ImGuiWindowFlags_NoScrollbar | ImGuiWindowFlags_NoCollapse,
  ImGuiWindowFlags_NoInputs = ImGuiWindowFlags_NoMouseInputs | ImGuiWindowFlags_NoNavInputs | ImGuiWindowFlags_NoNavFocus,
  ImGuiWindowFlags_NavFlattened = 1 << 23,
  ImGuiWindowFlags_ChildWindow = 1 << 24,
  ImGuiWindowFlags_Tooltip = 1 << 25,
  ImGuiWindowFlags_Popup = 1 << 26,
  ImGuiWindowFlags_Modal = 1 << 27,
  ImGuiWindowFlags_ChildMenu = 1 << 28
} ImGuiWindowFlags_;
typedef enum
{
  ImGuiInputTextFlags_None = 0,
  ImGuiInputTextFlags_CharsDecimal = 1 << 0,
  ImGuiInputTextFlags_CharsHexadecimal = 1 << 1,
  ImGuiInputTextFlags_CharsUppercase = 1 << 2,
  ImGuiInputTextFlags_CharsNoBlank = 1 << 3,
  ImGuiInputTextFlags_AutoSelectAll = 1 << 4,
  ImGuiInputTextFlags_EnterReturnsTrue = 1 << 5,
  ImGuiInputTextFlags_CallbackCompletion = 1 << 6,
  ImGuiInputTextFlags_CallbackHistory = 1 << 7,
  ImGuiInputTextFlags_CallbackAlways = 1 << 8,
  ImGuiInputTextFlags_CallbackCharFilter = 1 << 9,
  ImGuiInputTextFlags_AllowTabInput = 1 << 10,
  ImGuiInputTextFlags_CtrlEnterForNewLine = 1 << 11,
  ImGuiInputTextFlags_NoHorizontalScroll = 1 << 12,
  ImGuiInputTextFlags_AlwaysInsertMode = 1 << 13,
  ImGuiInputTextFlags_ReadOnly = 1 << 14,
  ImGuiInputTextFlags_Password = 1 << 15,
  ImGuiInputTextFlags_NoUndoRedo = 1 << 16,
  ImGuiInputTextFlags_CharsScientific = 1 << 17,
  ImGuiInputTextFlags_CallbackResize = 1 << 18,
  ImGuiInputTextFlags_CallbackEdit = 1 << 19,
  ImGuiInputTextFlags_Multiline = 1 << 20,
  ImGuiInputTextFlags_NoMarkEdited = 1 << 21
} ImGuiInputTextFlags_;
typedef enum
{
  ImGuiTreeNodeFlags_None = 0,
  ImGuiTreeNodeFlags_Selected = 1 << 0,
  ImGuiTreeNodeFlags_Framed = 1 << 1,
  ImGuiTreeNodeFlags_AllowItemOverlap = 1 << 2,
  ImGuiTreeNodeFlags_NoTreePushOnOpen = 1 << 3,
  ImGuiTreeNodeFlags_NoAutoOpenOnLog = 1 << 4,
  ImGuiTreeNodeFlags_DefaultOpen = 1 << 5,
  ImGuiTreeNodeFlags_OpenOnDoubleClick = 1 << 6,
  ImGuiTreeNodeFlags_OpenOnArrow = 1 << 7,
  ImGuiTreeNodeFlags_Leaf = 1 << 8,
  ImGuiTreeNodeFlags_Bullet = 1 << 9,
  ImGuiTreeNodeFlags_FramePadding = 1 << 10,
  ImGuiTreeNodeFlags_SpanAvailWidth = 1 << 11,
  ImGuiTreeNodeFlags_SpanFullWidth = 1 << 12,
  ImGuiTreeNodeFlags_NavLeftJumpsBackHere = 1 << 13,
  ImGuiTreeNodeFlags_CollapsingHeader = ImGuiTreeNodeFlags_Framed | ImGuiTreeNodeFlags_NoTreePushOnOpen | ImGuiTreeNodeFlags_NoAutoOpenOnLog
} ImGuiTreeNodeFlags_;
typedef enum
{
  ImGuiPopupFlags_None = 0,
  ImGuiPopupFlags_MouseButtonLeft = 0,
  ImGuiPopupFlags_MouseButtonRight = 1,
  ImGuiPopupFlags_MouseButtonMiddle = 2,
  ImGuiPopupFlags_MouseButtonMask_ = 0x1F,
  ImGuiPopupFlags_MouseButtonDefault_ = 1,
  ImGuiPopupFlags_NoOpenOverExistingPopup = 1 << 5,
  ImGuiPopupFlags_NoOpenOverItems = 1 << 6,
  ImGuiPopupFlags_AnyPopupId = 1 << 7,
  ImGuiPopupFlags_AnyPopupLevel = 1 << 8,
  ImGuiPopupFlags_AnyPopup = ImGuiPopupFlags_AnyPopupId | ImGuiPopupFlags_AnyPopupLevel
} ImGuiPopupFlags_;
typedef enum
{
  ImGuiSelectableFlags_None = 0,
  ImGuiSelectableFlags_DontClosePopups = 1 << 0,
  ImGuiSelectableFlags_SpanAllColumns = 1 << 1,
  ImGuiSelectableFlags_AllowDoubleClick = 1 << 2,
  ImGuiSelectableFlags_Disabled = 1 << 3,
  ImGuiSelectableFlags_AllowItemOverlap = 1 << 4
} ImGuiSelectableFlags_;
typedef enum
{
  ImGuiComboFlags_None = 0,
  ImGuiComboFlags_PopupAlignLeft = 1 << 0,
  ImGuiComboFlags_HeightSmall = 1 << 1,
  ImGuiComboFlags_HeightRegular = 1 << 2,
  ImGuiComboFlags_HeightLarge = 1 << 3,
  ImGuiComboFlags_HeightLargest = 1 << 4,
  ImGuiComboFlags_NoArrowButton = 1 << 5,
  ImGuiComboFlags_NoPreview = 1 << 6,
  ImGuiComboFlags_HeightMask_ = ImGuiComboFlags_HeightSmall | ImGuiComboFlags_HeightRegular | ImGuiComboFlags_HeightLarge | ImGuiComboFlags_HeightLargest
} ImGuiComboFlags_;
typedef enum
{
  ImGuiTabBarFlags_None = 0,
  ImGuiTabBarFlags_Reorderable = 1 << 0,
  ImGuiTabBarFlags_AutoSelectNewTabs = 1 << 1,
  ImGuiTabBarFlags_TabListPopupButton = 1 << 2,
  ImGuiTabBarFlags_NoCloseWithMiddleMouseButton = 1 << 3,
  ImGuiTabBarFlags_NoTabListScrollingButtons = 1 << 4,
  ImGuiTabBarFlags_NoTooltip = 1 << 5,
  ImGuiTabBarFlags_FittingPolicyResizeDown = 1 << 6,
  ImGuiTabBarFlags_FittingPolicyScroll = 1 << 7,
  ImGuiTabBarFlags_FittingPolicyMask_ = ImGuiTabBarFlags_FittingPolicyResizeDown | ImGuiTabBarFlags_FittingPolicyScroll,
  ImGuiTabBarFlags_FittingPolicyDefault_ = ImGuiTabBarFlags_FittingPolicyResizeDown
} ImGuiTabBarFlags_;
typedef enum
{
  ImGuiTabItemFlags_None = 0,
  ImGuiTabItemFlags_UnsavedDocument = 1 << 0,
  ImGuiTabItemFlags_SetSelected = 1 << 1,
  ImGuiTabItemFlags_NoCloseWithMiddleMouseButton = 1 << 2,
  ImGuiTabItemFlags_NoPushId = 1 << 3,
  ImGuiTabItemFlags_NoTooltip = 1 << 4,
  ImGuiTabItemFlags_NoReorder = 1 << 5,
  ImGuiTabItemFlags_Leading = 1 << 6,
  ImGuiTabItemFlags_Trailing = 1 << 7
} ImGuiTabItemFlags_;
typedef enum
{
  ImGuiFocusedFlags_None = 0,
  ImGuiFocusedFlags_ChildWindows = 1 << 0,
  ImGuiFocusedFlags_RootWindow = 1 << 1,
  ImGuiFocusedFlags_AnyWindow = 1 << 2,
  ImGuiFocusedFlags_RootAndChildWindows = ImGuiFocusedFlags_RootWindow | ImGuiFocusedFlags_ChildWindows
} ImGuiFocusedFlags_;
typedef enum
{
  ImGuiHoveredFlags_None = 0,
  ImGuiHoveredFlags_ChildWindows = 1 << 0,
  ImGuiHoveredFlags_RootWindow = 1 << 1,
  ImGuiHoveredFlags_AnyWindow = 1 << 2,
  ImGuiHoveredFlags_AllowWhenBlockedByPopup = 1 << 3,
  ImGuiHoveredFlags_AllowWhenBlockedByActiveItem = 1 << 5,
  ImGuiHoveredFlags_AllowWhenOverlapped = 1 << 6,
  ImGuiHoveredFlags_AllowWhenDisabled = 1 << 7,
  ImGuiHoveredFlags_RectOnly = ImGuiHoveredFlags_AllowWhenBlockedByPopup | ImGuiHoveredFlags_AllowWhenBlockedByActiveItem | ImGuiHoveredFlags_AllowWhenOverlapped,
  ImGuiHoveredFlags_RootAndChildWindows = ImGuiHoveredFlags_RootWindow | ImGuiHoveredFlags_ChildWindows
} ImGuiHoveredFlags_;
typedef enum
{
  ImGuiDragDropFlags_None = 0,
  ImGuiDragDropFlags_SourceNoPreviewTooltip = 1 << 0,
  ImGuiDragDropFlags_SourceNoDisableHover = 1 << 1,
  ImGuiDragDropFlags_SourceNoHoldToOpenOthers = 1 << 2,
  ImGuiDragDropFlags_SourceAllowNullID = 1 << 3,
  ImGuiDragDropFlags_SourceExtern = 1 << 4,
  ImGuiDragDropFlags_SourceAutoExpirePayload = 1 << 5,
  ImGuiDragDropFlags_AcceptBeforeDelivery = 1 << 10,
  ImGuiDragDropFlags_AcceptNoDrawDefaultRect = 1 << 11,
  ImGuiDragDropFlags_AcceptNoPreviewTooltip = 1 << 12,
  ImGuiDragDropFlags_AcceptPeekOnly = ImGuiDragDropFlags_AcceptBeforeDelivery | ImGuiDragDropFlags_AcceptNoDrawDefaultRect
} ImGuiDragDropFlags_;
typedef enum
{
  ImGuiDataType_S8,
  ImGuiDataType_U8,
  ImGuiDataType_S16,
  ImGuiDataType_U16,
  ImGuiDataType_S32,
  ImGuiDataType_U32,
  ImGuiDataType_S64,
  ImGuiDataType_U64,
  ImGuiDataType_Float,
  ImGuiDataType_Double,
  ImGuiDataType_COUNT
} ImGuiDataType_;
typedef enum
{
  ImGuiDir_None = -1,
  ImGuiDir_Left = 0,
  ImGuiDir_Right = 1,
  ImGuiDir_Up = 2,
  ImGuiDir_Down = 3,
  ImGuiDir_COUNT
} ImGuiDir_;
typedef enum
{
  ImGuiKey_Tab,
  ImGuiKey_LeftArrow,
  ImGuiKey_RightArrow,
  ImGuiKey_UpArrow,
  ImGuiKey_DownArrow,
  ImGuiKey_PageUp,
  ImGuiKey_PageDown,
  ImGuiKey_Home,
  ImGuiKey_End,
  ImGuiKey_Insert,
  ImGuiKey_Delete,
  ImGuiKey_Backspace,
  ImGuiKey_Space,
  ImGuiKey_Enter,
  ImGuiKey_Escape,
  ImGuiKey_KeyPadEnter,
  ImGuiKey_A,
  ImGuiKey_C,
  ImGuiKey_V,
  ImGuiKey_X,
  ImGuiKey_Y,
  ImGuiKey_Z,
  ImGuiKey_COUNT
} ImGuiKey_;
typedef enum
{
  ImGuiKeyModFlags_None = 0,
  ImGuiKeyModFlags_Ctrl = 1 << 0,
  ImGuiKeyModFlags_Shift = 1 << 1,
  ImGuiKeyModFlags_Alt = 1 << 2,
  ImGuiKeyModFlags_Super = 1 << 3
} ImGuiKeyModFlags_;
typedef enum
{
  ImGuiNavInput_Activate,
  ImGuiNavInput_Cancel,
  ImGuiNavInput_Input,
  ImGuiNavInput_Menu,
  ImGuiNavInput_DpadLeft,
  ImGuiNavInput_DpadRight,
  ImGuiNavInput_DpadUp,
  ImGuiNavInput_DpadDown,
  ImGuiNavInput_LStickLeft,
  ImGuiNavInput_LStickRight,
  ImGuiNavInput_LStickUp,
  ImGuiNavInput_LStickDown,
  ImGuiNavInput_FocusPrev,
  ImGuiNavInput_FocusNext,
  ImGuiNavInput_TweakSlow,
  ImGuiNavInput_TweakFast,
  ImGuiNavInput_KeyMenu_,
  ImGuiNavInput_KeyLeft_,
  ImGuiNavInput_KeyRight_,
  ImGuiNavInput_KeyUp_,
  ImGuiNavInput_KeyDown_,
  ImGuiNavInput_COUNT,
  ImGuiNavInput_InternalStart_ = ImGuiNavInput_KeyMenu_
} ImGuiNavInput_;
typedef enum
{
  ImGuiConfigFlags_None = 0,
  ImGuiConfigFlags_NavEnableKeyboard = 1 << 0,
  ImGuiConfigFlags_NavEnableGamepad = 1 << 1,
  ImGuiConfigFlags_NavEnableSetMousePos = 1 << 2,
  ImGuiConfigFlags_NavNoCaptureKeyboard = 1 << 3,
  ImGuiConfigFlags_NoMouse = 1 << 4,
  ImGuiConfigFlags_NoMouseCursorChange = 1 << 5,
  ImGuiConfigFlags_IsSRGB = 1 << 20,
  ImGuiConfigFlags_IsTouchScreen = 1 << 21
} ImGuiConfigFlags_;
typedef enum
{
  ImGuiBackendFlags_None = 0,
  ImGuiBackendFlags_HasGamepad = 1 << 0,
  ImGuiBackendFlags_HasMouseCursors = 1 << 1,
  ImGuiBackendFlags_HasSetMousePos = 1 << 2,
  ImGuiBackendFlags_RendererHasVtxOffset = 1 << 3
} ImGuiBackendFlags_;
typedef enum
{
  ImGuiCol_Text,
  ImGuiCol_TextDisabled,
  ImGuiCol_WindowBg,
  ImGuiCol_ChildBg,
  ImGuiCol_PopupBg,
  ImGuiCol_Border,
  ImGuiCol_BorderShadow,
  ImGuiCol_FrameBg,
  ImGuiCol_FrameBgHovered,
  ImGuiCol_FrameBgActive,
  ImGuiCol_TitleBg,
  ImGuiCol_TitleBgActive,
  ImGuiCol_TitleBgCollapsed,
  ImGuiCol_MenuBarBg,
  ImGuiCol_ScrollbarBg,
  ImGuiCol_ScrollbarGrab,
  ImGuiCol_ScrollbarGrabHovered,
  ImGuiCol_ScrollbarGrabActive,
  ImGuiCol_CheckMark,
  ImGuiCol_SliderGrab,
  ImGuiCol_SliderGrabActive,
  ImGuiCol_Button,
  ImGuiCol_ButtonHovered,
  ImGuiCol_ButtonActive,
  ImGuiCol_Header,
  ImGuiCol_HeaderHovered,
  ImGuiCol_HeaderActive,
  ImGuiCol_Separator,
  ImGuiCol_SeparatorHovered,
  ImGuiCol_SeparatorActive,
  ImGuiCol_ResizeGrip,
  ImGuiCol_ResizeGripHovered,
  ImGuiCol_ResizeGripActive,
  ImGuiCol_Tab,
  ImGuiCol_TabHovered,
  ImGuiCol_TabActive,
  ImGuiCol_TabUnfocused,
  ImGuiCol_TabUnfocusedActive,
  ImGuiCol_PlotLines,
  ImGuiCol_PlotLinesHovered,
  ImGuiCol_PlotHistogram,
  ImGuiCol_PlotHistogramHovered,
  ImGuiCol_TextSelectedBg,
  ImGuiCol_DragDropTarget,
  ImGuiCol_NavHighlight,
  ImGuiCol_NavWindowingHighlight,
  ImGuiCol_NavWindowingDimBg,
  ImGuiCol_ModalWindowDimBg,
  ImGuiCol_COUNT
} ImGuiCol_;
typedef enum
{
  ImGuiStyleVar_Alpha,
  ImGuiStyleVar_WindowPadding,
  ImGuiStyleVar_WindowRounding,
  ImGuiStyleVar_WindowBorderSize,
  ImGuiStyleVar_WindowMinSize,
  ImGuiStyleVar_WindowTitleAlign,
  ImGuiStyleVar_ChildRounding,
  ImGuiStyleVar_ChildBorderSize,
  ImGuiStyleVar_PopupRounding,
  ImGuiStyleVar_PopupBorderSize,
  ImGuiStyleVar_FramePadding,
  ImGuiStyleVar_FrameRounding,
  ImGuiStyleVar_FrameBorderSize,
  ImGuiStyleVar_ItemSpacing,
  ImGuiStyleVar_ItemInnerSpacing,
  ImGuiStyleVar_IndentSpacing,
  ImGuiStyleVar_ScrollbarSize,
  ImGuiStyleVar_ScrollbarRounding,
  ImGuiStyleVar_GrabMinSize,
  ImGuiStyleVar_GrabRounding,
  ImGuiStyleVar_TabRounding,
  ImGuiStyleVar_ButtonTextAlign,
  ImGuiStyleVar_SelectableTextAlign,
  ImGuiStyleVar_COUNT
} ImGuiStyleVar_;
typedef enum
{
  ImGuiButtonFlags_None = 0,
  ImGuiButtonFlags_MouseButtonLeft = 1 << 0,
  ImGuiButtonFlags_MouseButtonRight = 1 << 1,
  ImGuiButtonFlags_MouseButtonMiddle = 1 << 2,
  ImGuiButtonFlags_MouseButtonMask_ = ImGuiButtonFlags_MouseButtonLeft | ImGuiButtonFlags_MouseButtonRight | ImGuiButtonFlags_MouseButtonMiddle,
  ImGuiButtonFlags_MouseButtonDefault_ = ImGuiButtonFlags_MouseButtonLeft
} ImGuiButtonFlags_;
typedef enum
{
  ImGuiColorEditFlags_None = 0,
  ImGuiColorEditFlags_NoAlpha = 1 << 1,
  ImGuiColorEditFlags_NoPicker = 1 << 2,
  ImGuiColorEditFlags_NoOptions = 1 << 3,
  ImGuiColorEditFlags_NoSmallPreview = 1 << 4,
  ImGuiColorEditFlags_NoInputs = 1 << 5,
  ImGuiColorEditFlags_NoTooltip = 1 << 6,
  ImGuiColorEditFlags_NoLabel = 1 << 7,
  ImGuiColorEditFlags_NoSidePreview = 1 << 8,
  ImGuiColorEditFlags_NoDragDrop = 1 << 9,
  ImGuiColorEditFlags_NoBorder = 1 << 10,
  ImGuiColorEditFlags_AlphaBar = 1 << 16,
  ImGuiColorEditFlags_AlphaPreview = 1 << 17,
  ImGuiColorEditFlags_AlphaPreviewHalf = 1 << 18,
  ImGuiColorEditFlags_HDR = 1 << 19,
  ImGuiColorEditFlags_DisplayRGB = 1 << 20,
  ImGuiColorEditFlags_DisplayHSV = 1 << 21,
  ImGuiColorEditFlags_DisplayHex = 1 << 22,
  ImGuiColorEditFlags_Uint8 = 1 << 23,
  ImGuiColorEditFlags_Float = 1 << 24,
  ImGuiColorEditFlags_PickerHueBar = 1 << 25,
  ImGuiColorEditFlags_PickerHueWheel = 1 << 26,
  ImGuiColorEditFlags_InputRGB = 1 << 27,
  ImGuiColorEditFlags_InputHSV = 1 << 28,
  ImGuiColorEditFlags__OptionsDefault = ImGuiColorEditFlags_Uint8 | ImGuiColorEditFlags_DisplayRGB | ImGuiColorEditFlags_InputRGB | ImGuiColorEditFlags_PickerHueBar,
  ImGuiColorEditFlags__DisplayMask = ImGuiColorEditFlags_DisplayRGB | ImGuiColorEditFlags_DisplayHSV | ImGuiColorEditFlags_DisplayHex,
  ImGuiColorEditFlags__DataTypeMask = ImGuiColorEditFlags_Uint8 | ImGuiColorEditFlags_Float,
  ImGuiColorEditFlags__PickerMask = ImGuiColorEditFlags_PickerHueWheel | ImGuiColorEditFlags_PickerHueBar,
  ImGuiColorEditFlags__InputMask = ImGuiColorEditFlags_InputRGB | ImGuiColorEditFlags_InputHSV
} ImGuiColorEditFlags_;
typedef enum
{
  ImGuiSliderFlags_None = 0,
  ImGuiSliderFlags_AlwaysClamp = 1 << 4,
  ImGuiSliderFlags_Logarithmic = 1 << 5,
  ImGuiSliderFlags_NoRoundToFormat = 1 << 6,
  ImGuiSliderFlags_NoInput = 1 << 7,
  ImGuiSliderFlags_InvalidMask_ = 0x7000000F
} ImGuiSliderFlags_;
typedef enum
{
  ImGuiMouseButton_Left = 0,
  ImGuiMouseButton_Right = 1,
  ImGuiMouseButton_Middle = 2,
  ImGuiMouseButton_COUNT = 5
} ImGuiMouseButton_;
typedef enum
{
  ImGuiMouseCursor_None = -1,
  ImGuiMouseCursor_Arrow = 0,
  ImGuiMouseCursor_TextInput,
  ImGuiMouseCursor_ResizeAll,
  ImGuiMouseCursor_ResizeNS,
  ImGuiMouseCursor_ResizeEW,
  ImGuiMouseCursor_ResizeNESW,
  ImGuiMouseCursor_ResizeNWSE,
  ImGuiMouseCursor_Hand,
  ImGuiMouseCursor_NotAllowed,
  ImGuiMouseCursor_COUNT
} ImGuiMouseCursor_;
typedef enum
{
  ImGuiCond_None = 0,
  ImGuiCond_Always = 1 << 0,
  ImGuiCond_Once = 1 << 1,
  ImGuiCond_FirstUseEver = 1 << 2,
  ImGuiCond_Appearing = 1 << 3
} ImGuiCond_;
struct ImGuiStyle
{
  float Alpha;
  ImVec2 WindowPadding;
  float WindowRounding;
  float WindowBorderSize;
  ImVec2 WindowMinSize;
  ImVec2 WindowTitleAlign;
  ImGuiDir WindowMenuButtonPosition;
  float ChildRounding;
  float ChildBorderSize;
  float PopupRounding;
  float PopupBorderSize;
  ImVec2 FramePadding;
  float FrameRounding;
  float FrameBorderSize;
  ImVec2 ItemSpacing;
  ImVec2 ItemInnerSpacing;
  ImVec2 TouchExtraPadding;
  float IndentSpacing;
  float ColumnsMinSpacing;
  float ScrollbarSize;
  float ScrollbarRounding;
  float GrabMinSize;
  float GrabRounding;
  float LogSliderDeadzone;
  float TabRounding;
  float TabBorderSize;
  float TabMinWidthForCloseButton;
  ImGuiDir ColorButtonPosition;
  ImVec2 ButtonTextAlign;
  ImVec2 SelectableTextAlign;
  ImVec2 DisplayWindowPadding;
  ImVec2 DisplaySafeAreaPadding;
  float MouseCursorScale;
  bool AntiAliasedLines;
  bool AntiAliasedLinesUseTex;
  bool AntiAliasedFill;
  float CurveTessellationTol;
  float CircleSegmentMaxError;
  ImVec4 Colors[ImGuiCol_COUNT];
};
struct ImGuiIO
{
  ImGuiConfigFlags ConfigFlags;
  ImGuiBackendFlags BackendFlags;
  ImVec2 DisplaySize;
  float DeltaTime;
  float IniSavingRate;
  const char *IniFilename;
  const char *LogFilename;
  float MouseDoubleClickTime;
  float MouseDoubleClickMaxDist;
  float MouseDragThreshold;
  int KeyMap[ImGuiKey_COUNT];
  float KeyRepeatDelay;
  float KeyRepeatRate;
  void *UserData;
  ImFontAtlas *Fonts;
  float FontGlobalScale;
  bool FontAllowUserScaling;
  ImFont *FontDefault;
  ImVec2 DisplayFramebufferScale;
  bool MouseDrawCursor;
  bool ConfigMacOSXBehaviors;
  bool ConfigInputTextCursorBlink;
  bool ConfigWindowsResizeFromEdges;
  bool ConfigWindowsMoveFromTitleBarOnly;
  float ConfigWindowsMemoryCompactTimer;
  const char *BackendPlatformName;
  const char *BackendRendererName;
  void *BackendPlatformUserData;
  void *BackendRendererUserData;
  void *BackendLanguageUserData;
  const char *(*GetClipboardTextFn)(void *user_data);
  void (*SetClipboardTextFn)(void *user_data, const char *text);
  void *ClipboardUserData;
  void (*ImeSetInputScreenPosFn)(int x, int y);
  void *ImeWindowHandle;
  void *RenderDrawListsFnUnused;
  ImVec2 MousePos;
  bool MouseDown[5];
  float MouseWheel;
  float MouseWheelH;
  bool KeyCtrl;
  bool KeyShift;
  bool KeyAlt;
  bool KeySuper;
  bool KeysDown[512];
  float NavInputs[ImGuiNavInput_COUNT];
  bool WantCaptureMouse;
  bool WantCaptureKeyboard;
  bool WantTextInput;
  bool WantSetMousePos;
  bool WantSaveIniSettings;
  bool NavActive;
  bool NavVisible;
  float Framerate;
  int MetricsRenderVertices;
  int MetricsRenderIndices;
  int MetricsRenderWindows;
  int MetricsActiveWindows;
  int MetricsActiveAllocations;
  ImVec2 MouseDelta;
  ImGuiKeyModFlags KeyMods;
  ImVec2 MousePosPrev;
  ImVec2 MouseClickedPos[5];
  double MouseClickedTime[5];
  bool MouseClicked[5];
  bool MouseDoubleClicked[5];
  bool MouseReleased[5];
  bool MouseDownOwned[5];
  bool MouseDownWasDoubleClick[5];
  float MouseDownDuration[5];
  float MouseDownDurationPrev[5];
  ImVec2 MouseDragMaxDistanceAbs[5];
  float MouseDragMaxDistanceSqr[5];
  float KeysDownDuration[512];
  float KeysDownDurationPrev[512];
  float NavInputsDownDuration[ImGuiNavInput_COUNT];
  float NavInputsDownDurationPrev[ImGuiNavInput_COUNT];
  float PenPressure;
  ImWchar16 InputQueueSurrogate;
  ImVector_ImWchar InputQueueCharacters;
};
struct ImGuiInputTextCallbackData
{
  ImGuiInputTextFlags EventFlag;
  ImGuiInputTextFlags Flags;
  void *UserData;
  ImWchar EventChar;
  ImGuiKey EventKey;
  char *Buf;
  int BufTextLen;
  int BufSize;
  bool BufDirty;
  int CursorPos;
  int SelectionStart;
  int SelectionEnd;
};
struct ImGuiSizeCallbackData
{
  void *UserData;
  ImVec2 Pos;
  ImVec2 CurrentSize;
  ImVec2 DesiredSize;
};
struct ImGuiPayload
{
  void *Data;
  int DataSize;
  ImGuiID SourceId;
  ImGuiID SourceParentId;
  int DataFrameCount;
  char DataType[32 + 1];
  bool Preview;
  bool Delivery;
};
struct ImGuiOnceUponAFrame
{
  int RefFrame;
};
struct ImGuiTextRange
{
  const char *b;
  const char *e;
};
struct ImGuiTextFilter
{
  char InputBuf[256];
  ImVector_ImGuiTextRange Filters;
  int CountGrep;
};
struct ImGuiTextBuffer
{
  ImVector_char Buf;
};
struct ImGuiStoragePair
{
  ImGuiID key;
  union
  {
    int val_i;
    float val_f;
    void *val_p;
  };
};
struct ImGuiStorage
{
  ImVector_ImGuiStoragePair Data;
};
typedef struct ImVector_ImGuiTabBar
{
  int Size;
  int Capacity;
  ImGuiTabBar *Data;
} ImVector_ImGuiTabBar;
typedef struct ImPool_ImGuiTabBar
{
  ImVector_ImGuiTabBar Buf;
  ImGuiStorage Map;
  ImPoolIdx FreeIdx;
} ImPool_ImGuiTabBar;
struct ImGuiListClipper
{
  int DisplayStart;
  int DisplayEnd;
  int ItemsCount;
  int StepNo;
  float ItemsHeight;
  float StartPosY;
};
struct ImColor
{
  ImVec4 Value;
};
struct ImDrawCmd
{
  ImVec4 ClipRect;
  ImTextureID TextureId;
  unsigned int VtxOffset;
  unsigned int IdxOffset;
  unsigned int ElemCount;
  ImDrawCallback UserCallback;
  void *UserCallbackData;
};
struct ImDrawVert
{
  ImVec2 pos;
  ImVec2 uv;
  ImU32 col;
};
struct ImDrawChannel
{
  ImVector_ImDrawCmd _CmdBuffer;
  ImVector_ImDrawIdx _IdxBuffer;
};
struct ImDrawListSplitter
{
  int _Current;
  int _Count;
  ImVector_ImDrawChannel _Channels;
};
typedef enum
{
  ImDrawCornerFlags_None = 0,
  ImDrawCornerFlags_TopLeft = 1 << 0,
  ImDrawCornerFlags_TopRight = 1 << 1,
  ImDrawCornerFlags_BotLeft = 1 << 2,
  ImDrawCornerFlags_BotRight = 1 << 3,
  ImDrawCornerFlags_Top = ImDrawCornerFlags_TopLeft | ImDrawCornerFlags_TopRight,
  ImDrawCornerFlags_Bot = ImDrawCornerFlags_BotLeft | ImDrawCornerFlags_BotRight,
  ImDrawCornerFlags_Left = ImDrawCornerFlags_TopLeft | ImDrawCornerFlags_BotLeft,
  ImDrawCornerFlags_Right = ImDrawCornerFlags_TopRight | ImDrawCornerFlags_BotRight,
  ImDrawCornerFlags_All = 0xF
} ImDrawCornerFlags_;
typedef enum
{
  ImDrawListFlags_None = 0,
  ImDrawListFlags_AntiAliasedLines = 1 << 0,
  ImDrawListFlags_AntiAliasedLinesUseTex = 1 << 1,
  ImDrawListFlags_AntiAliasedFill = 1 << 2,
  ImDrawListFlags_AllowVtxOffset = 1 << 3
} ImDrawListFlags_;
struct ImDrawList
{
  ImVector_ImDrawCmd CmdBuffer;
  ImVector_ImDrawIdx IdxBuffer;
  ImVector_ImDrawVert VtxBuffer;
  ImDrawListFlags Flags;
  const ImDrawListSharedData *_Data;
  const char *_OwnerName;
  unsigned int _VtxCurrentIdx;
  ImDrawVert *_VtxWritePtr;
  ImDrawIdx *_IdxWritePtr;
  ImVector_ImVec4 _ClipRectStack;
  ImVector_ImTextureID _TextureIdStack;
  ImVector_ImVec2 _Path;
  ImDrawCmd _CmdHeader;
  ImDrawListSplitter _Splitter;
};
struct ImDrawData
{
  bool Valid;
  ImDrawList **CmdLists;
  int CmdListsCount;
  int TotalIdxCount;
  int TotalVtxCount;
  ImVec2 DisplayPos;
  ImVec2 DisplaySize;
  ImVec2 FramebufferScale;
};
struct ImFontConfig
{
  void *FontData;
  int FontDataSize;
  bool FontDataOwnedByAtlas;
  int FontNo;
  float SizePixels;
  int OversampleH;
  int OversampleV;
  bool PixelSnapH;
  ImVec2 GlyphExtraSpacing;
  ImVec2 GlyphOffset;
  const ImWchar *GlyphRanges;
  float GlyphMinAdvanceX;
  float GlyphMaxAdvanceX;
  bool MergeMode;
  unsigned int RasterizerFlags;
  float RasterizerMultiply;
  ImWchar EllipsisChar;
  char Name[40];
  ImFont *DstFont;
};
struct ImFontGlyph
{
  unsigned int Codepoint : 31;
  unsigned int Visible : 1;
  float AdvanceX;
  float X0, Y0, X1, Y1;
  float U0, V0, U1, V1;
};
struct ImFontGlyphRangesBuilder
{
  ImVector_ImU32 UsedChars;
};
struct ImFontAtlasCustomRect
{
  unsigned short Width, Height;
  unsigned short X, Y;
  unsigned int GlyphID;
  float GlyphAdvanceX;
  ImVec2 GlyphOffset;
  ImFont *Font;
};
typedef enum
{
  ImFontAtlasFlags_None = 0,
  ImFontAtlasFlags_NoPowerOfTwoHeight = 1 << 0,
  ImFontAtlasFlags_NoMouseCursors = 1 << 1,
  ImFontAtlasFlags_NoBakedLines = 1 << 2
} ImFontAtlasFlags_;
struct ImFontAtlas
{
  bool Locked;
  ImFontAtlasFlags Flags;
  ImTextureID TexID;
  int TexDesiredWidth;
  int TexGlyphPadding;
  unsigned char *TexPixelsAlpha8;
  unsigned int *TexPixelsRGBA32;
  int TexWidth;
  int TexHeight;
  ImVec2 TexUvScale;
  ImVec2 TexUvWhitePixel;
  ImVector_ImFontPtr Fonts;
  ImVector_ImFontAtlasCustomRect CustomRects;
  ImVector_ImFontConfig ConfigData;
  ImVec4 TexUvLines[(63) + 1];
  int PackIdMouseCursors;
  int PackIdLines;
};
struct ImFont
{
  ImVector_float IndexAdvanceX;
  float FallbackAdvanceX;
  float FontSize;
  ImVector_ImWchar IndexLookup;
  ImVector_ImFontGlyph Glyphs;
  const ImFontGlyph *FallbackGlyph;
  ImFontAtlas *ContainerAtlas;
  const ImFontConfig *ConfigData;
  short ConfigDataCount;
  ImWchar FallbackChar;
  ImWchar EllipsisChar;
  bool DirtyLookupTables;
  float Scale;
  float Ascent, Descent;
  int MetricsTotalSurface;
  ImU8 Used4kPagesMap[(0xFFFF + 1) / 4096 / 8];
};
struct StbUndoRecord
{
  int where;
  int insert_length;
  int delete_length;
  int char_storage;
};
struct StbUndoState
{
  StbUndoRecord undo_rec[99];
  ImWchar undo_char[999];
  short undo_point, redo_point;
  int undo_char_point, redo_char_point;
};
struct STB_TexteditState
{
  int cursor;
  int select_start;
  int select_end;
  unsigned char insert_mode;
  int row_count_per_page;
  unsigned char cursor_at_end_of_line;
  unsigned char initialized;
  unsigned char has_preferred_x;
  unsigned char single_line;
  unsigned char padding1, padding2, padding3;
  float preferred_x;
  StbUndoState undostate;
};
struct StbTexteditRow
{
  float x0, x1;
  float baseline_y_delta;
  float ymin, ymax;
  int num_chars;
};
struct ImVec1
{
  float x;
};
struct ImVec2ih
{
  short x, y;
};
struct ImRect
{
  ImVec2 Min;
  ImVec2 Max;
};
struct ImBitVector
{
  ImVector_ImU32 Storage;
};
struct ImDrawListSharedData
{
  ImVec2 TexUvWhitePixel;
  ImFont *Font;
  float FontSize;
  float CurveTessellationTol;
  float CircleSegmentMaxError;
  ImVec4 ClipRectFullscreen;
  ImDrawListFlags InitialFlags;
  ImVec2 ArcFastVtx[12 * 1];
  ImU8 CircleSegmentCounts[64];
  const ImVec4 *TexUvLines;
};
struct ImDrawDataBuilder
{
  ImVector_ImDrawListPtr Layers[2];
};
typedef enum
{
  ImGuiItemFlags_None = 0,
  ImGuiItemFlags_NoTabStop = 1 << 0,
  ImGuiItemFlags_ButtonRepeat = 1 << 1,
  ImGuiItemFlags_Disabled = 1 << 2,
  ImGuiItemFlags_NoNav = 1 << 3,
  ImGuiItemFlags_NoNavDefaultFocus = 1 << 4,
  ImGuiItemFlags_SelectableDontClosePopup = 1 << 5,
  ImGuiItemFlags_MixedValue = 1 << 6,
  ImGuiItemFlags_ReadOnly = 1 << 7,
  ImGuiItemFlags_Default_ = 0
} ImGuiItemFlags_;
typedef enum
{
  ImGuiItemStatusFlags_None = 0,
  ImGuiItemStatusFlags_HoveredRect = 1 << 0,
  ImGuiItemStatusFlags_HasDisplayRect = 1 << 1,
  ImGuiItemStatusFlags_Edited = 1 << 2,
  ImGuiItemStatusFlags_ToggledSelection = 1 << 3,
  ImGuiItemStatusFlags_ToggledOpen = 1 << 4,
  ImGuiItemStatusFlags_HasDeactivated = 1 << 5,
  ImGuiItemStatusFlags_Deactivated = 1 << 6
} ImGuiItemStatusFlags_;
typedef enum
{
  ImGuiButtonFlags_PressedOnClick = 1 << 4,
  ImGuiButtonFlags_PressedOnClickRelease = 1 << 5,
  ImGuiButtonFlags_PressedOnClickReleaseAnywhere = 1 << 6,
  ImGuiButtonFlags_PressedOnRelease = 1 << 7,
  ImGuiButtonFlags_PressedOnDoubleClick = 1 << 8,
  ImGuiButtonFlags_PressedOnDragDropHold = 1 << 9,
  ImGuiButtonFlags_Repeat = 1 << 10,
  ImGuiButtonFlags_FlattenChildren = 1 << 11,
  ImGuiButtonFlags_AllowItemOverlap = 1 << 12,
  ImGuiButtonFlags_DontClosePopups = 1 << 13,
  ImGuiButtonFlags_Disabled = 1 << 14,
  ImGuiButtonFlags_AlignTextBaseLine = 1 << 15,
  ImGuiButtonFlags_NoKeyModifiers = 1 << 16,
  ImGuiButtonFlags_NoHoldingActiveId = 1 << 17,
  ImGuiButtonFlags_NoNavFocus = 1 << 18,
  ImGuiButtonFlags_NoHoveredOnFocus = 1 << 19,
  ImGuiButtonFlags_PressedOnMask_ = ImGuiButtonFlags_PressedOnClick | ImGuiButtonFlags_PressedOnClickRelease | ImGuiButtonFlags_PressedOnClickReleaseAnywhere | ImGuiButtonFlags_PressedOnRelease | ImGuiButtonFlags_PressedOnDoubleClick | ImGuiButtonFlags_PressedOnDragDropHold,
  ImGuiButtonFlags_PressedOnDefault_ = ImGuiButtonFlags_PressedOnClickRelease
} ImGuiButtonFlagsPrivate_;
typedef enum
{
  ImGuiSliderFlags_Vertical = 1 << 20,
  ImGuiSliderFlags_ReadOnly = 1 << 21
} ImGuiSliderFlagsPrivate_;
typedef enum
{
  ImGuiSelectableFlags_NoHoldingActiveID = 1 << 20,
  ImGuiSelectableFlags_SelectOnClick = 1 << 21,
  ImGuiSelectableFlags_SelectOnRelease = 1 << 22,
  ImGuiSelectableFlags_SpanAvailWidth = 1 << 23,
  ImGuiSelectableFlags_DrawHoveredWhenHeld = 1 << 24,
  ImGuiSelectableFlags_SetNavIdOnHover = 1 << 25,
  ImGuiSelectableFlags_NoPadWithHalfSpacing = 1 << 26
} ImGuiSelectableFlagsPrivate_;
typedef enum
{
  ImGuiTreeNodeFlags_ClipLabelForTrailingButton = 1 << 20
} ImGuiTreeNodeFlagsPrivate_;
typedef enum
{
  ImGuiSeparatorFlags_None = 0,
  ImGuiSeparatorFlags_Horizontal = 1 << 0,
  ImGuiSeparatorFlags_Vertical = 1 << 1,
  ImGuiSeparatorFlags_SpanAllColumns = 1 << 2
} ImGuiSeparatorFlags_;
typedef enum
{
  ImGuiTextFlags_None = 0,
  ImGuiTextFlags_NoWidthForLargeClippedText = 1 << 0
} ImGuiTextFlags_;
typedef enum
{
  ImGuiTooltipFlags_None = 0,
  ImGuiTooltipFlags_OverridePreviousTooltip = 1 << 0
} ImGuiTooltipFlags_;
typedef enum
{
  ImGuiLayoutType_Horizontal = 0,
  ImGuiLayoutType_Vertical = 1
} ImGuiLayoutType_;
typedef enum
{
  ImGuiLogType_None = 0,
  ImGuiLogType_TTY,
  ImGuiLogType_File,
  ImGuiLogType_Buffer,
  ImGuiLogType_Clipboard
} ImGuiLogType;
typedef enum
{
  ImGuiAxis_None = -1,
  ImGuiAxis_X = 0,
  ImGuiAxis_Y = 1
} ImGuiAxis;
typedef enum
{
  ImGuiPlotType_Lines,
  ImGuiPlotType_Histogram
} ImGuiPlotType;
typedef enum
{
  ImGuiInputSource_None = 0,
  ImGuiInputSource_Mouse,
  ImGuiInputSource_Nav,
  ImGuiInputSource_NavKeyboard,
  ImGuiInputSource_NavGamepad,
  ImGuiInputSource_COUNT
} ImGuiInputSource;
typedef enum
{
  ImGuiInputReadMode_Down,
  ImGuiInputReadMode_Pressed,
  ImGuiInputReadMode_Released,
  ImGuiInputReadMode_Repeat,
  ImGuiInputReadMode_RepeatSlow,
  ImGuiInputReadMode_RepeatFast
} ImGuiInputReadMode;
typedef enum
{
  ImGuiNavHighlightFlags_None = 0,
  ImGuiNavHighlightFlags_TypeDefault = 1 << 0,
  ImGuiNavHighlightFlags_TypeThin = 1 << 1,
  ImGuiNavHighlightFlags_AlwaysDraw = 1 << 2,
  ImGuiNavHighlightFlags_NoRounding = 1 << 3
} ImGuiNavHighlightFlags_;
typedef enum
{
  ImGuiNavDirSourceFlags_None = 0,
  ImGuiNavDirSourceFlags_Keyboard = 1 << 0,
  ImGuiNavDirSourceFlags_PadDPad = 1 << 1,
  ImGuiNavDirSourceFlags_PadLStick = 1 << 2
} ImGuiNavDirSourceFlags_;
typedef enum
{
  ImGuiNavMoveFlags_None = 0,
  ImGuiNavMoveFlags_LoopX = 1 << 0,
  ImGuiNavMoveFlags_LoopY = 1 << 1,
  ImGuiNavMoveFlags_WrapX = 1 << 2,
  ImGuiNavMoveFlags_WrapY = 1 << 3,
  ImGuiNavMoveFlags_AllowCurrentNavId = 1 << 4,
  ImGuiNavMoveFlags_AlsoScoreVisibleSet = 1 << 5,
  ImGuiNavMoveFlags_ScrollToEdge = 1 << 6
} ImGuiNavMoveFlags_;
typedef enum
{
  ImGuiNavForward_None,
  ImGuiNavForward_ForwardQueued,
  ImGuiNavForward_ForwardActive
} ImGuiNavForward;
typedef enum
{
  ImGuiNavLayer_Main = 0,
  ImGuiNavLayer_Menu = 1,
  ImGuiNavLayer_COUNT
} ImGuiNavLayer;
typedef enum
{
  ImGuiPopupPositionPolicy_Default,
  ImGuiPopupPositionPolicy_ComboBox,
  ImGuiPopupPositionPolicy_Tooltip
} ImGuiPopupPositionPolicy;
struct ImGuiDataTypeTempStorage
{
  ImU8 Data[8];
};
struct ImGuiDataTypeInfo
{
  size_t Size;
  const char *Name;
  const char *PrintFmt;
  const char *ScanFmt;
};
typedef enum
{
  ImGuiDataType_String = ImGuiDataType_COUNT + 1,
  ImGuiDataType_Pointer,
  ImGuiDataType_ID
} ImGuiDataTypePrivate_;
struct ImGuiColorMod
{
  ImGuiCol Col;
  ImVec4 BackupValue;
};
struct ImGuiStyleMod
{
  ImGuiStyleVar VarIdx;
  union
  {
    int BackupInt[2];
    float BackupFloat[2];
  };
};
struct ImGuiGroupData
{
  ImVec2 BackupCursorPos;
  ImVec2 BackupCursorMaxPos;
  ImVec1 BackupIndent;
  ImVec1 BackupGroupOffset;
  ImVec2 BackupCurrLineSize;
  float BackupCurrLineTextBaseOffset;
  ImGuiID BackupActiveIdIsAlive;
  bool BackupActiveIdPreviousFrameIsAlive;
  bool EmitItem;
};
struct ImGuiMenuColumns
{
  float Spacing;
  float Width, NextWidth;
  float Pos[3], NextWidths[3];
};
struct ImGuiInputTextState
{
  ImGuiID ID;
  int CurLenW, CurLenA;
  ImVector_ImWchar TextW;
  ImVector_char TextA;
  ImVector_char InitialTextA;
  bool TextAIsValid;
  int BufCapacityA;
  float ScrollX;
  STB_TexteditState Stb;
  float CursorAnim;
  bool CursorFollow;
  bool SelectedAllMouseLock;
  bool Edited;
  ImGuiInputTextFlags UserFlags;
  ImGuiInputTextCallback UserCallback;
  void *UserCallbackData;
};
struct ImGuiPopupData
{
  ImGuiID PopupId;
  ImGuiWindow *Window;
  ImGuiWindow *SourceWindow;
  int OpenFrameCount;
  ImGuiID OpenParentId;
  ImVec2 OpenPopupPos;
  ImVec2 OpenMousePos;
};
struct ImGuiNavMoveResult
{
  ImGuiWindow *Window;
  ImGuiID ID;
  ImGuiID FocusScopeId;
  float DistBox;
  float DistCenter;
  float DistAxial;
  ImRect RectRel;
};
typedef enum
{
  ImGuiNextWindowDataFlags_None = 0,
  ImGuiNextWindowDataFlags_HasPos = 1 << 0,
  ImGuiNextWindowDataFlags_HasSize = 1 << 1,
  ImGuiNextWindowDataFlags_HasContentSize = 1 << 2,
  ImGuiNextWindowDataFlags_HasCollapsed = 1 << 3,
  ImGuiNextWindowDataFlags_HasSizeConstraint = 1 << 4,
  ImGuiNextWindowDataFlags_HasFocus = 1 << 5,
  ImGuiNextWindowDataFlags_HasBgAlpha = 1 << 6,
  ImGuiNextWindowDataFlags_HasScroll = 1 << 7
} ImGuiNextWindowDataFlags_;
struct ImGuiNextWindowData
{
  ImGuiNextWindowDataFlags Flags;
  ImGuiCond PosCond;
  ImGuiCond SizeCond;
  ImGuiCond CollapsedCond;
  ImVec2 PosVal;
  ImVec2 PosPivotVal;
  ImVec2 SizeVal;
  ImVec2 ContentSizeVal;
  ImVec2 ScrollVal;
  bool CollapsedVal;
  ImRect SizeConstraintRect;
  ImGuiSizeCallback SizeCallback;
  void *SizeCallbackUserData;
  float BgAlphaVal;
  ImVec2 MenuBarOffsetMinVal;
};
typedef enum
{
  ImGuiNextItemDataFlags_None = 0,
  ImGuiNextItemDataFlags_HasWidth = 1 << 0,
  ImGuiNextItemDataFlags_HasOpen = 1 << 1
} ImGuiNextItemDataFlags_;
struct ImGuiNextItemData
{
  ImGuiNextItemDataFlags Flags;
  float Width;
  ImGuiID FocusScopeId;
  ImGuiCond OpenCond;
  bool OpenVal;
};
struct ImGuiShrinkWidthItem
{
  int Index;
  float Width;
};
struct ImGuiPtrOrIndex
{
  void *Ptr;
  int Index;
};
typedef enum
{
  ImGuiColumnsFlags_None = 0,
  ImGuiColumnsFlags_NoBorder = 1 << 0,
  ImGuiColumnsFlags_NoResize = 1 << 1,
  ImGuiColumnsFlags_NoPreserveWidths = 1 << 2,
  ImGuiColumnsFlags_NoForceWithinWindow = 1 << 3,
  ImGuiColumnsFlags_GrowParentContentsSize = 1 << 4
} ImGuiColumnsFlags_;
struct ImGuiColumnData
{
  float OffsetNorm;
  float OffsetNormBeforeResize;
  ImGuiColumnsFlags Flags;
  ImRect ClipRect;
};
struct ImGuiColumns
{
  ImGuiID ID;
  ImGuiColumnsFlags Flags;
  bool IsFirstFrame;
  bool IsBeingResized;
  int Current;
  int Count;
  float OffMinX, OffMaxX;
  float LineMinY, LineMaxY;
  float HostCursorPosY;
  float HostCursorMaxPosX;
  ImRect HostInitialClipRect;
  ImRect HostBackupClipRect;
  ImRect HostBackupParentWorkRect;
  ImVector_ImGuiColumnData Columns;
  ImDrawListSplitter Splitter;
};
struct ImGuiWindowSettings
{
  ImGuiID ID;
  ImVec2ih Pos;
  ImVec2ih Size;
  bool Collapsed;
  bool WantApply;
};
struct ImGuiSettingsHandler
{
  const char *TypeName;
  ImGuiID TypeHash;
  void (*ClearAllFn)(ImGuiContext *ctx, ImGuiSettingsHandler *handler);
  void (*ReadInitFn)(ImGuiContext *ctx, ImGuiSettingsHandler *handler);
  void *(*ReadOpenFn)(ImGuiContext *ctx, ImGuiSettingsHandler *handler, const char *name);
  void (*ReadLineFn)(ImGuiContext *ctx, ImGuiSettingsHandler *handler, void *entry, const char *line);
  void (*ApplyAllFn)(ImGuiContext *ctx, ImGuiSettingsHandler *handler);
  void (*WriteAllFn)(ImGuiContext *ctx, ImGuiSettingsHandler *handler, ImGuiTextBuffer *out_buf);
  void *UserData;
};
struct ImGuiContext
{
  bool Initialized;
  bool FontAtlasOwnedByContext;
  ImGuiIO IO;
  ImGuiStyle Style;
  ImFont *Font;
  float FontSize;
  float FontBaseSize;
  ImDrawListSharedData DrawListSharedData;
  double Time;
  int FrameCount;
  int FrameCountEnded;
  int FrameCountRendered;
  bool WithinFrameScope;
  bool WithinFrameScopeWithImplicitWindow;
  bool WithinEndChild;
  bool TestEngineHookItems;
  ImGuiID TestEngineHookIdInfo;
  void *TestEngine;
  ImVector_ImGuiWindowPtr Windows;
  ImVector_ImGuiWindowPtr WindowsFocusOrder;
  ImVector_ImGuiWindowPtr WindowsTempSortBuffer;
  ImVector_ImGuiWindowPtr CurrentWindowStack;
  ImGuiStorage WindowsById;
  int WindowsActiveCount;
  ImGuiWindow *CurrentWindow;
  ImGuiWindow *HoveredWindow;
  ImGuiWindow *HoveredRootWindow;
  ImGuiWindow *HoveredWindowUnderMovingWindow;
  ImGuiWindow *MovingWindow;
  ImGuiWindow *WheelingWindow;
  ImVec2 WheelingWindowRefMousePos;
  float WheelingWindowTimer;
  ImGuiID HoveredId;
  ImGuiID HoveredIdPreviousFrame;
  bool HoveredIdAllowOverlap;
  bool HoveredIdDisabled;
  float HoveredIdTimer;
  float HoveredIdNotActiveTimer;
  ImGuiID ActiveId;
  ImGuiID ActiveIdIsAlive;
  float ActiveIdTimer;
  bool ActiveIdIsJustActivated;
  bool ActiveIdAllowOverlap;
  bool ActiveIdNoClearOnFocusLoss;
  bool ActiveIdHasBeenPressedBefore;
  bool ActiveIdHasBeenEditedBefore;
  bool ActiveIdHasBeenEditedThisFrame;
  ImU32 ActiveIdUsingNavDirMask;
  ImU32 ActiveIdUsingNavInputMask;
  ImU64 ActiveIdUsingKeyInputMask;
  ImVec2 ActiveIdClickOffset;
  ImGuiWindow *ActiveIdWindow;
  ImGuiInputSource ActiveIdSource;
  int ActiveIdMouseButton;
  ImGuiID ActiveIdPreviousFrame;
  bool ActiveIdPreviousFrameIsAlive;
  bool ActiveIdPreviousFrameHasBeenEditedBefore;
  ImGuiWindow *ActiveIdPreviousFrameWindow;
  ImGuiID LastActiveId;
  float LastActiveIdTimer;
  ImGuiNextWindowData NextWindowData;
  ImGuiNextItemData NextItemData;
  ImVector_ImGuiColorMod ColorModifiers;
  ImVector_ImGuiStyleMod StyleModifiers;
  ImVector_ImFontPtr FontStack;
  ImVector_ImGuiPopupData OpenPopupStack;
  ImVector_ImGuiPopupData BeginPopupStack;
  ImGuiWindow *NavWindow;
  ImGuiID NavId;
  ImGuiID NavFocusScopeId;
  ImGuiID NavActivateId;
  ImGuiID NavActivateDownId;
  ImGuiID NavActivatePressedId;
  ImGuiID NavInputId;
  ImGuiID NavJustTabbedId;
  ImGuiID NavJustMovedToId;
  ImGuiID NavJustMovedToFocusScopeId;
  ImGuiKeyModFlags NavJustMovedToKeyMods;
  ImGuiID NavNextActivateId;
  ImGuiInputSource NavInputSource;
  ImRect NavScoringRect;
  int NavScoringCount;
  ImGuiNavLayer NavLayer;
  int NavIdTabCounter;
  bool NavIdIsAlive;
  bool NavMousePosDirty;
  bool NavDisableHighlight;
  bool NavDisableMouseHover;
  bool NavAnyRequest;
  bool NavInitRequest;
  bool NavInitRequestFromMove;
  ImGuiID NavInitResultId;
  ImRect NavInitResultRectRel;
  bool NavMoveRequest;
  ImGuiNavMoveFlags NavMoveRequestFlags;
  ImGuiNavForward NavMoveRequestForward;
  ImGuiKeyModFlags NavMoveRequestKeyMods;
  ImGuiDir NavMoveDir, NavMoveDirLast;
  ImGuiDir NavMoveClipDir;
  ImGuiNavMoveResult NavMoveResultLocal;
  ImGuiNavMoveResult NavMoveResultLocalVisibleSet;
  ImGuiNavMoveResult NavMoveResultOther;
  ImGuiWindow *NavWrapRequestWindow;
  ImGuiNavMoveFlags NavWrapRequestFlags;
  ImGuiWindow *NavWindowingTarget;
  ImGuiWindow *NavWindowingTargetAnim;
  ImGuiWindow *NavWindowingListWindow;
  float NavWindowingTimer;
  float NavWindowingHighlightAlpha;
  bool NavWindowingToggleLayer;
  ImGuiWindow *FocusRequestCurrWindow;
  ImGuiWindow *FocusRequestNextWindow;
  int FocusRequestCurrCounterRegular;
  int FocusRequestCurrCounterTabStop;
  int FocusRequestNextCounterRegular;
  int FocusRequestNextCounterTabStop;
  bool FocusTabPressed;
  ImDrawData DrawData;
  ImDrawDataBuilder DrawDataBuilder;
  float DimBgRatio;
  ImDrawList BackgroundDrawList;
  ImDrawList ForegroundDrawList;
  ImGuiMouseCursor MouseCursor;
  bool DragDropActive;
  bool DragDropWithinSource;
  bool DragDropWithinTarget;
  ImGuiDragDropFlags DragDropSourceFlags;
  int DragDropSourceFrameCount;
  int DragDropMouseButton;
  ImGuiPayload DragDropPayload;
  ImRect DragDropTargetRect;
  ImGuiID DragDropTargetId;
  ImGuiDragDropFlags DragDropAcceptFlags;
  float DragDropAcceptIdCurrRectSurface;
  ImGuiID DragDropAcceptIdCurr;
  ImGuiID DragDropAcceptIdPrev;
  int DragDropAcceptFrameCount;
  ImGuiID DragDropHoldJustPressedId;
  ImVector_unsigned_char DragDropPayloadBufHeap;
  unsigned char DragDropPayloadBufLocal[16];
  ImGuiTabBar *CurrentTabBar;
  ImPool_ImGuiTabBar TabBars;
  ImVector_ImGuiPtrOrIndex CurrentTabBarStack;
  ImVector_ImGuiShrinkWidthItem ShrinkWidthBuffer;
  ImVec2 LastValidMousePos;
  ImGuiInputTextState InputTextState;
  ImFont InputTextPasswordFont;
  ImGuiID TempInputId;
  ImGuiColorEditFlags ColorEditOptions;
  float ColorEditLastHue;
  float ColorEditLastSat;
  float ColorEditLastColor[3];
  ImVec4 ColorPickerRef;
  float SliderCurrentAccum;
  bool SliderCurrentAccumDirty;
  bool DragCurrentAccumDirty;
  float DragCurrentAccum;
  float DragSpeedDefaultRatio;
  float ScrollbarClickDeltaToGrabCenter;
  int TooltipOverrideCount;
  ImVector_char ClipboardHandlerData;
  ImVector_ImGuiID MenusIdSubmittedThisFrame;
  ImVec2 PlatformImePos;
  ImVec2 PlatformImeLastPos;
  char PlatformLocaleDecimalPoint;
  bool SettingsLoaded;
  float SettingsDirtyTimer;
  ImGuiTextBuffer SettingsIniData;
  ImVector_ImGuiSettingsHandler SettingsHandlers;
  ImChunkStream_ImGuiWindowSettings SettingsWindows;
  bool LogEnabled;
  ImGuiLogType LogType;
  ImFileHandle LogFile;
  ImGuiTextBuffer LogBuffer;
  float LogLinePosY;
  bool LogLineFirstItem;
  int LogDepthRef;
  int LogDepthToExpand;
  int LogDepthToExpandDefault;
  bool DebugItemPickerActive;
  ImGuiID DebugItemPickerBreakId;
  float FramerateSecPerFrame[120];
  int FramerateSecPerFrameIdx;
  float FramerateSecPerFrameAccum;
  int WantCaptureMouseNextFrame;
  int WantCaptureKeyboardNextFrame;
  int WantTextInputNextFrame;
  char TempBuffer[1024 * 3 + 1];
};
struct ImGuiWindowTempData
{
  ImVec2 CursorPos;
  ImVec2 CursorPosPrevLine;
  ImVec2 CursorStartPos;
  ImVec2 CursorMaxPos;
  ImVec2 CurrLineSize;
  ImVec2 PrevLineSize;
  float CurrLineTextBaseOffset;
  float PrevLineTextBaseOffset;
  ImVec1 Indent;
  ImVec1 ColumnsOffset;
  ImVec1 GroupOffset;
  ImGuiID LastItemId;
  ImGuiItemStatusFlags LastItemStatusFlags;
  ImRect LastItemRect;
  ImRect LastItemDisplayRect;
  ImGuiNavLayer NavLayerCurrent;
  int NavLayerActiveMask;
  int NavLayerActiveMaskNext;
  ImGuiID NavFocusScopeIdCurrent;
  bool NavHideHighlightOneFrame;
  bool NavHasScroll;
  bool MenuBarAppending;
  ImVec2 MenuBarOffset;
  ImGuiMenuColumns MenuColumns;
  int TreeDepth;
  ImU32 TreeJumpToParentOnPopMask;
  ImVector_ImGuiWindowPtr ChildWindows;
  ImGuiStorage *StateStorage;
  ImGuiColumns *CurrentColumns;
  ImGuiLayoutType LayoutType;
  ImGuiLayoutType ParentLayoutType;
  int FocusCounterRegular;
  int FocusCounterTabStop;
  ImGuiItemFlags ItemFlags;
  float ItemWidth;
  float TextWrapPos;
  ImVector_ImGuiItemFlags ItemFlagsStack;
  ImVector_float ItemWidthStack;
  ImVector_float TextWrapPosStack;
  ImVector_ImGuiGroupData GroupStack;
  short StackSizesBackup[6];
};
struct ImGuiWindow
{
  char *Name;
  ImGuiID ID;
  ImGuiWindowFlags Flags;
  ImVec2 Pos;
  ImVec2 Size;
  ImVec2 SizeFull;
  ImVec2 ContentSize;
  ImVec2 ContentSizeExplicit;
  ImVec2 WindowPadding;
  float WindowRounding;
  float WindowBorderSize;
  int NameBufLen;
  ImGuiID MoveId;
  ImGuiID ChildId;
  ImVec2 Scroll;
  ImVec2 ScrollMax;
  ImVec2 ScrollTarget;
  ImVec2 ScrollTargetCenterRatio;
  ImVec2 ScrollTargetEdgeSnapDist;
  ImVec2 ScrollbarSizes;
  bool ScrollbarX, ScrollbarY;
  bool Active;
  bool WasActive;
  bool WriteAccessed;
  bool Collapsed;
  bool WantCollapseToggle;
  bool SkipItems;
  bool Appearing;
  bool Hidden;
  bool IsFallbackWindow;
  bool HasCloseButton;
  signed char ResizeBorderHeld;
  short BeginCount;
  short BeginOrderWithinParent;
  short BeginOrderWithinContext;
  ImGuiID PopupId;
  ImS8 AutoFitFramesX, AutoFitFramesY;
  ImS8 AutoFitChildAxises;
  bool AutoFitOnlyGrows;
  ImGuiDir AutoPosLastDirection;
  int HiddenFramesCanSkipItems;
  int HiddenFramesCannotSkipItems;
  ImGuiCond SetWindowPosAllowFlags;
  ImGuiCond SetWindowSizeAllowFlags;
  ImGuiCond SetWindowCollapsedAllowFlags;
  ImVec2 SetWindowPosVal;
  ImVec2 SetWindowPosPivot;
  ImVector_ImGuiID IDStack;
  ImGuiWindowTempData DC;
  ImRect OuterRectClipped;
  ImRect InnerRect;
  ImRect InnerClipRect;
  ImRect WorkRect;
  ImRect ParentWorkRect;
  ImRect ClipRect;
  ImRect ContentRegionRect;
  ImVec2ih HitTestHoleSize;
  ImVec2ih HitTestHoleOffset;
  int LastFrameActive;
  float LastTimeActive;
  float ItemWidthDefault;
  ImGuiStorage StateStorage;
  ImVector_ImGuiColumns ColumnsStorage;
  float FontWindowScale;
  int SettingsOffset;
  ImDrawList *DrawList;
  ImDrawList DrawListInst;
  ImGuiWindow *ParentWindow;
  ImGuiWindow *RootWindow;
  ImGuiWindow *RootWindowForTitleBarHighlight;
  ImGuiWindow *RootWindowForNav;
  ImGuiWindow *NavLastChildNavWindow;
  ImGuiID NavLastIds[ImGuiNavLayer_COUNT];
  ImRect NavRectRel[ImGuiNavLayer_COUNT];
  bool MemoryCompacted;
  int MemoryDrawListIdxCapacity;
  int MemoryDrawListVtxCapacity;
};
struct ImGuiLastItemDataBackup
{
  ImGuiID LastItemId;
  ImGuiItemStatusFlags LastItemStatusFlags;
  ImRect LastItemRect;
  ImRect LastItemDisplayRect;
};
typedef enum
{
  ImGuiTabBarFlags_DockNode = 1 << 20,
  ImGuiTabBarFlags_IsFocused = 1 << 21,
  ImGuiTabBarFlags_SaveSettings = 1 << 22
} ImGuiTabBarFlagsPrivate_;
typedef enum
{
  ImGuiTabItemFlags_NoCloseButton = 1 << 20,
  ImGuiTabItemFlags_Button = 1 << 21
} ImGuiTabItemFlagsPrivate_;
struct ImGuiTabItem
{
  ImGuiID ID;
  ImGuiTabItemFlags Flags;
  int LastFrameVisible;
  int LastFrameSelected;
  float Offset;
  float Width;
  float ContentWidth;
  ImS16 NameOffset;
  ImS8 BeginOrder;
  ImS8 IndexDuringLayout;
  bool WantClose;
};
struct ImGuiTabBar
{
  ImVector_ImGuiTabItem Tabs;
  ImGuiID ID;
  ImGuiID SelectedTabId;
  ImGuiID NextSelectedTabId;
  ImGuiID VisibleTabId;
  int CurrFrameVisible;
  int PrevFrameVisible;
  ImRect BarRect;
  float LastTabContentHeight;
  float WidthAllTabs;
  float WidthAllTabsIdeal;
  float ScrollingAnim;
  float ScrollingTarget;
  float ScrollingTargetDistToVisibility;
  float ScrollingSpeed;
  float ScrollingRectMinX;
  float ScrollingRectMaxX;
  ImGuiTabBarFlags Flags;
  ImGuiID ReorderRequestTabId;
  ImS8 ReorderRequestDir;
  ImS8 TabsActiveCount;
  bool WantLayout;
  bool VisibleTabWasSubmitted;
  bool TabsAddedNew;
  short LastTabItemIdx;
  ImVec2 FramePadding;
  ImGuiTextBuffer TabsNames;
};
#else
struct GLFWwindow;
struct SDL_Window;
typedef union SDL_Event SDL_Event;
#endif // CIMGUI_DEFINE_ENUMS_AND_STRUCTS

#ifndef CIMGUI_DEFINE_ENUMS_AND_STRUCTS
typedef ImGuiStorage::ImGuiStoragePair ImGuiStoragePair;
typedef ImGuiTextFilter::ImGuiTextRange ImGuiTextRange;
typedef ImStb::STB_TexteditState STB_TexteditState;
typedef ImStb::StbTexteditRow StbTexteditRow;
typedef ImStb::StbUndoRecord StbUndoRecord;
typedef ImStb::StbUndoState StbUndoState;
typedef ImChunkStream<ImGuiWindowSettings> ImChunkStream_ImGuiWindowSettings;
typedef ImPool<ImGuiTabBar> ImPool_ImGuiTabBar;
typedef ImVector<ImDrawChannel> ImVector_ImDrawChannel;
typedef ImVector<ImDrawCmd> ImVector_ImDrawCmd;
typedef ImVector<ImDrawIdx> ImVector_ImDrawIdx;
typedef ImVector<ImDrawList *> ImVector_ImDrawListPtr;
typedef ImVector<ImDrawVert> ImVector_ImDrawVert;
typedef ImVector<ImFont *> ImVector_ImFontPtr;
typedef ImVector<ImFontAtlasCustomRect> ImVector_ImFontAtlasCustomRect;
typedef ImVector<ImFontConfig> ImVector_ImFontConfig;
typedef ImVector<ImFontGlyph> ImVector_ImFontGlyph;
typedef ImVector<ImGuiColorMod> ImVector_ImGuiColorMod;
typedef ImVector<ImGuiColumnData> ImVector_ImGuiColumnData;
typedef ImVector<ImGuiColumns> ImVector_ImGuiColumns;
typedef ImVector<ImGuiGroupData> ImVector_ImGuiGroupData;
typedef ImVector<ImGuiID> ImVector_ImGuiID;
typedef ImVector<ImGuiItemFlags> ImVector_ImGuiItemFlags;
typedef ImVector<ImGuiPopupData> ImVector_ImGuiPopupData;
typedef ImVector<ImGuiPtrOrIndex> ImVector_ImGuiPtrOrIndex;
typedef ImVector<ImGuiSettingsHandler> ImVector_ImGuiSettingsHandler;
typedef ImVector<ImGuiShrinkWidthItem> ImVector_ImGuiShrinkWidthItem;
typedef ImVector<ImGuiStoragePair> ImVector_ImGuiStoragePair;
typedef ImVector<ImGuiStyleMod> ImVector_ImGuiStyleMod;
typedef ImVector<ImGuiTabItem> ImVector_ImGuiTabItem;
typedef ImVector<ImGuiTextRange> ImVector_ImGuiTextRange;
typedef ImVector<ImGuiWindow *> ImVector_ImGuiWindowPtr;
typedef ImVector<ImTextureID> ImVector_ImTextureID;
typedef ImVector<ImU32> ImVector_ImU32;
typedef ImVector<ImVec2> ImVector_ImVec2;
typedef ImVector<ImVec4> ImVector_ImVec4;
typedef ImVector<ImWchar> ImVector_ImWchar;
typedef ImVector<char> ImVector_char;
typedef ImVector<float> ImVector_float;
typedef ImVector<unsigned char> ImVector_unsigned_char;
#endif //CIMGUI_DEFINE_ENUMS_AND_STRUCTS
CIMGUI_API ImVec2 *ImVec2_ImVec2Nil(void);
CIMGUI_API void ImVec2_destroy(ImVec2 *self);
CIMGUI_API ImVec2 *ImVec2_ImVec2Float(float _x, float _y);
CIMGUI_API ImVec4 *ImVec4_ImVec4Nil(void);
CIMGUI_API void ImVec4_destroy(ImVec4 *self);
CIMGUI_API ImVec4 *ImVec4_ImVec4Float(float _x, float _y, float _z, float _w);
CIMGUI_API ImGuiContext *igCreateContext(ImFontAtlas *shared_font_atlas);
CIMGUI_API void igDestroyContext(ImGuiContext *ctx);
CIMGUI_API ImGuiContext *igGetCurrentContext(void);
CIMGUI_API void igSetCurrentContext(ImGuiContext *ctx);
CIMGUI_API ImGuiIO *igGetIO(void);
CIMGUI_API ImGuiStyle *igGetStyle(void);
CIMGUI_API void igNewFrame(void);
CIMGUI_API void igEndFrame(void);
CIMGUI_API void igRender(void);
CIMGUI_API ImDrawData *igGetDrawData(void);
CIMGUI_API void igShowDemoWindow(bool *p_open);
CIMGUI_API void igShowAboutWindow(bool *p_open);
CIMGUI_API void igShowMetricsWindow(bool *p_open);
CIMGUI_API void igShowStyleEditor(ImGuiStyle *ref);
CIMGUI_API bool igShowStyleSelector(const char *label);
CIMGUI_API void igShowFontSelector(const char *label);
CIMGUI_API void igShowUserGuide(void);
CIMGUI_API const char *igGetVersion(void);
CIMGUI_API void igStyleColorsDark(ImGuiStyle *dst);
CIMGUI_API void igStyleColorsClassic(ImGuiStyle *dst);
CIMGUI_API void igStyleColorsLight(ImGuiStyle *dst);
CIMGUI_API bool igBegin(const char *name, bool *p_open, ImGuiWindowFlags flags);
CIMGUI_API void igEnd(void);
CIMGUI_API bool igBeginChildStr(const char *str_id, const ImVec2 size, bool border, ImGuiWindowFlags flags);
CIMGUI_API bool igBeginChildID(ImGuiID id, const ImVec2 size, bool border, ImGuiWindowFlags flags);
CIMGUI_API void igEndChild(void);
CIMGUI_API bool igIsWindowAppearing(void);
CIMGUI_API bool igIsWindowCollapsed(void);
CIMGUI_API bool igIsWindowFocused(ImGuiFocusedFlags flags);
CIMGUI_API bool igIsWindowHovered(ImGuiHoveredFlags flags);
CIMGUI_API ImDrawList *igGetWindowDrawList(void);
CIMGUI_API void igGetWindowPos(ImVec2 *pOut);
CIMGUI_API void igGetWindowSize(ImVec2 *pOut);
CIMGUI_API float igGetWindowWidth(void);
CIMGUI_API float igGetWindowHeight(void);
CIMGUI_API void igSetNextWindowPos(const ImVec2 pos, ImGuiCond cond, const ImVec2 pivot);
CIMGUI_API void igSetNextWindowSize(const ImVec2 size, ImGuiCond cond);
CIMGUI_API void igSetNextWindowSizeConstraints(const ImVec2 size_min, const ImVec2 size_max, ImGuiSizeCallback custom_callback, void *custom_callback_data);
CIMGUI_API void igSetNextWindowContentSize(const ImVec2 size);
CIMGUI_API void igSetNextWindowCollapsed(bool collapsed, ImGuiCond cond);
CIMGUI_API void igSetNextWindowFocus(void);
CIMGUI_API void igSetNextWindowBgAlpha(float alpha);
CIMGUI_API void igSetWindowPosVec2(const ImVec2 pos, ImGuiCond cond);
CIMGUI_API void igSetWindowSizeVec2(const ImVec2 size, ImGuiCond cond);
CIMGUI_API void igSetWindowCollapsedBool(bool collapsed, ImGuiCond cond);
CIMGUI_API void igSetWindowFocusNil(void);
CIMGUI_API void igSetWindowFontScale(float scale);
CIMGUI_API void igSetWindowPosStr(const char *name, const ImVec2 pos, ImGuiCond cond);
CIMGUI_API void igSetWindowSizeStr(const char *name, const ImVec2 size, ImGuiCond cond);
CIMGUI_API void igSetWindowCollapsedStr(const char *name, bool collapsed, ImGuiCond cond);
CIMGUI_API void igSetWindowFocusStr(const char *name);
CIMGUI_API void igGetContentRegionMax(ImVec2 *pOut);
CIMGUI_API void igGetContentRegionAvail(ImVec2 *pOut);
CIMGUI_API void igGetWindowContentRegionMin(ImVec2 *pOut);
CIMGUI_API void igGetWindowContentRegionMax(ImVec2 *pOut);
CIMGUI_API float igGetWindowContentRegionWidth(void);
CIMGUI_API float igGetScrollX(void);
CIMGUI_API float igGetScrollY(void);
CIMGUI_API float igGetScrollMaxX(void);
CIMGUI_API float igGetScrollMaxY(void);
CIMGUI_API void igSetScrollXFloat(float scroll_x);
CIMGUI_API void igSetScrollYFloat(float scroll_y);
CIMGUI_API void igSetScrollHereX(float center_x_ratio);
CIMGUI_API void igSetScrollHereY(float center_y_ratio);
CIMGUI_API void igSetScrollFromPosXFloat(float local_x, float center_x_ratio);
CIMGUI_API void igSetScrollFromPosYFloat(float local_y, float center_y_ratio);
CIMGUI_API void igPushFont(ImFont *font);
CIMGUI_API void igPopFont(void);
CIMGUI_API void igPushStyleColorU32(ImGuiCol idx, ImU32 col);
CIMGUI_API void igPushStyleColorVec4(ImGuiCol idx, const ImVec4 col);
CIMGUI_API void igPopStyleColor(int count);
CIMGUI_API void igPushStyleVarFloat(ImGuiStyleVar idx, float val);
CIMGUI_API void igPushStyleVarVec2(ImGuiStyleVar idx, const ImVec2 val);
CIMGUI_API void igPopStyleVar(int count);
CIMGUI_API const ImVec4 *igGetStyleColorVec4(ImGuiCol idx);
CIMGUI_API ImFont *igGetFont(void);
CIMGUI_API float igGetFontSize(void);
CIMGUI_API void igGetFontTexUvWhitePixel(ImVec2 *pOut);
CIMGUI_API ImU32 igGetColorU32Col(ImGuiCol idx, float alpha_mul);
CIMGUI_API ImU32 igGetColorU32Vec4(const ImVec4 col);
CIMGUI_API ImU32 igGetColorU32U32(ImU32 col);
CIMGUI_API void igPushItemWidth(float item_width);
CIMGUI_API void igPopItemWidth(void);
CIMGUI_API void igSetNextItemWidth(float item_width);
CIMGUI_API float igCalcItemWidth(void);
CIMGUI_API void igPushTextWrapPos(float wrap_local_pos_x);
CIMGUI_API void igPopTextWrapPos(void);
CIMGUI_API void igPushAllowKeyboardFocus(bool allow_keyboard_focus);
CIMGUI_API void igPopAllowKeyboardFocus(void);
CIMGUI_API void igPushButtonRepeat(bool repeat);
CIMGUI_API void igPopButtonRepeat(void);
CIMGUI_API void igSeparator(void);
CIMGUI_API void igSameLine(float offset_from_start_x, float spacing);
CIMGUI_API void igNewLine(void);
CIMGUI_API void igSpacing(void);
CIMGUI_API void igDummy(const ImVec2 size);
CIMGUI_API void igIndent(float indent_w);
CIMGUI_API void igUnindent(float indent_w);
CIMGUI_API void igBeginGroup(void);
CIMGUI_API void igEndGroup(void);
CIMGUI_API void igGetCursorPos(ImVec2 *pOut);
CIMGUI_API float igGetCursorPosX(void);
CIMGUI_API float igGetCursorPosY(void);
CIMGUI_API void igSetCursorPos(const ImVec2 local_pos);
CIMGUI_API void igSetCursorPosX(float local_x);
CIMGUI_API void igSetCursorPosY(float local_y);
CIMGUI_API void igGetCursorStartPos(ImVec2 *pOut);
CIMGUI_API void igGetCursorScreenPos(ImVec2 *pOut);
CIMGUI_API void igSetCursorScreenPos(const ImVec2 pos);
CIMGUI_API void igAlignTextToFramePadding(void);
CIMGUI_API float igGetTextLineHeight(void);
CIMGUI_API float igGetTextLineHeightWithSpacing(void);
CIMGUI_API float igGetFrameHeight(void);
CIMGUI_API float igGetFrameHeightWithSpacing(void);
CIMGUI_API void igPushIDStr(const char *str_id);
CIMGUI_API void igPushIDStrStr(const char *str_id_begin, const char *str_id_end);
CIMGUI_API void igPushIDPtr(const void *ptr_id);
CIMGUI_API void igPushIDInt(int int_id);
CIMGUI_API void igPopID(void);
CIMGUI_API ImGuiID igGetIDStr(const char *str_id);
CIMGUI_API ImGuiID igGetIDStrStr(const char *str_id_begin, const char *str_id_end);
CIMGUI_API ImGuiID igGetIDPtr(const void *ptr_id);
CIMGUI_API void igTextUnformatted(const char *text, const char *text_end);
CIMGUI_API void igText(const char *fmt, ...);
CIMGUI_API void igTextV(const char *fmt, va_list args);
CIMGUI_API void igTextColored(const ImVec4 col, const char *fmt, ...);
CIMGUI_API void igTextColoredV(const ImVec4 col, const char *fmt, va_list args);
CIMGUI_API void igTextDisabled(const char *fmt, ...);
CIMGUI_API void igTextDisabledV(const char *fmt, va_list args);
CIMGUI_API void igTextWrapped(const char *fmt, ...);
CIMGUI_API void igTextWrappedV(const char *fmt, va_list args);
CIMGUI_API void igLabelText(const char *label, const char *fmt, ...);
CIMGUI_API void igLabelTextV(const char *label, const char *fmt, va_list args);
CIMGUI_API void igBulletText(const char *fmt, ...);
CIMGUI_API void igBulletTextV(const char *fmt, va_list args);
CIMGUI_API bool igButton(const char *label, const ImVec2 size);
CIMGUI_API bool igSmallButton(const char *label);
CIMGUI_API bool igInvisibleButton(const char *str_id, const ImVec2 size, ImGuiButtonFlags flags);
CIMGUI_API bool igArrowButton(const char *str_id, ImGuiDir dir);
CIMGUI_API void igImage(ImTextureID user_texture_id, const ImVec2 size, const ImVec2 uv0, const ImVec2 uv1, const ImVec4 tint_col, const ImVec4 border_col);
CIMGUI_API bool igImageButton(ImTextureID user_texture_id, const ImVec2 size, const ImVec2 uv0, const ImVec2 uv1, int frame_padding, const ImVec4 bg_col, const ImVec4 tint_col);
CIMGUI_API bool igCheckbox(const char *label, bool *v);
CIMGUI_API bool igCheckboxFlags(const char *label, unsigned int *flags, unsigned int flags_value);
CIMGUI_API bool igRadioButtonBool(const char *label, bool active);
CIMGUI_API bool igRadioButtonIntPtr(const char *label, int *v, int v_button);
CIMGUI_API void igProgressBar(float fraction, const ImVec2 size_arg, const char *overlay);
CIMGUI_API void igBullet(void);
CIMGUI_API bool igBeginCombo(const char *label, const char *preview_value, ImGuiComboFlags flags);
CIMGUI_API void igEndCombo(void);
CIMGUI_API bool igComboStr_arr(const char *label, int *current_item, const char *const items[], int items_count, int popup_max_height_in_items);
CIMGUI_API bool igComboStr(const char *label, int *current_item, const char *items_separated_by_zeros, int popup_max_height_in_items);
CIMGUI_API bool igComboFnBoolPtr(const char *label, int *current_item, bool (*items_getter)(void *data, int idx, const char **out_text), void *data, int items_count, int popup_max_height_in_items);
CIMGUI_API bool igDragFloat(const char *label, float *v, float v_speed, float v_min, float v_max, const char *format, ImGuiSliderFlags flags);
CIMGUI_API bool igDragFloat2(const char *label, float v[2], float v_speed, float v_min, float v_max, const char *format, ImGuiSliderFlags flags);
CIMGUI_API bool igDragFloat3(const char *label, float v[3], float v_speed, float v_min, float v_max, const char *format, ImGuiSliderFlags flags);
CIMGUI_API bool igDragFloat4(const char *label, float v[4], float v_speed, float v_min, float v_max, const char *format, ImGuiSliderFlags flags);
CIMGUI_API bool igDragFloatRange2(const char *label, float *v_current_min, float *v_current_max, float v_speed, float v_min, float v_max, const char *format, const char *format_max, ImGuiSliderFlags flags);
CIMGUI_API bool igDragInt(const char *label, int *v, float v_speed, int v_min, int v_max, const char *format, ImGuiSliderFlags flags);
CIMGUI_API bool igDragInt2(const char *label, int v[2], float v_speed, int v_min, int v_max, const char *format, ImGuiSliderFlags flags);
CIMGUI_API bool igDragInt3(const char *label, int v[3], float v_speed, int v_min, int v_max, const char *format, ImGuiSliderFlags flags);
CIMGUI_API bool igDragInt4(const char *label, int v[4], float v_speed, int v_min, int v_max, const char *format, ImGuiSliderFlags flags);
CIMGUI_API bool igDragIntRange2(const char *label, int *v_current_min, int *v_current_max, float v_speed, int v_min, int v_max, const char *format, const char *format_max, ImGuiSliderFlags flags);
CIMGUI_API bool igDragScalar(const char *label, ImGuiDataType data_type, void *p_data, float v_speed, const void *p_min, const void *p_max, const char *format, ImGuiSliderFlags flags);
CIMGUI_API bool igDragScalarN(const char *label, ImGuiDataType data_type, void *p_data, int components, float v_speed, const void *p_min, const void *p_max, const char *format, ImGuiSliderFlags flags);
CIMGUI_API bool igSliderFloat(const char *label, float *v, float v_min, float v_max, const char *format, ImGuiSliderFlags flags);
CIMGUI_API bool igSliderFloat2(const char *label, float v[2], float v_min, float v_max, const char *format, ImGuiSliderFlags flags);
CIMGUI_API bool igSliderFloat3(const char *label, float v[3], float v_min, float v_max, const char *format, ImGuiSliderFlags flags);
CIMGUI_API bool igSliderFloat4(const char *label, float v[4], float v_min, float v_max, const char *format, ImGuiSliderFlags flags);
CIMGUI_API bool igSliderAngle(const char *label, float *v_rad, float v_degrees_min, float v_degrees_max, const char *format, ImGuiSliderFlags flags);
CIMGUI_API bool igSliderInt(const char *label, int *v, int v_min, int v_max, const char *format, ImGuiSliderFlags flags);
CIMGUI_API bool igSliderInt2(const char *label, int v[2], int v_min, int v_max, const char *format, ImGuiSliderFlags flags);
CIMGUI_API bool igSliderInt3(const char *label, int v[3], int v_min, int v_max, const char *format, ImGuiSliderFlags flags);
CIMGUI_API bool igSliderInt4(const char *label, int v[4], int v_min, int v_max, const char *format, ImGuiSliderFlags flags);
CIMGUI_API bool igSliderScalar(const char *label, ImGuiDataType data_type, void *p_data, const void *p_min, const void *p_max, const char *format, ImGuiSliderFlags flags);
CIMGUI_API bool igSliderScalarN(const char *label, ImGuiDataType data_type, void *p_data, int components, const void *p_min, const void *p_max, const char *format, ImGuiSliderFlags flags);
CIMGUI_API bool igVSliderFloat(const char *label, const ImVec2 size, float *v, float v_min, float v_max, const char *format, ImGuiSliderFlags flags);
CIMGUI_API bool igVSliderInt(const char *label, const ImVec2 size, int *v, int v_min, int v_max, const char *format, ImGuiSliderFlags flags);
CIMGUI_API bool igVSliderScalar(const char *label, const ImVec2 size, ImGuiDataType data_type, void *p_data, const void *p_min, const void *p_max, const char *format, ImGuiSliderFlags flags);
CIMGUI_API bool igInputText(const char *label, char *buf, size_t buf_size, ImGuiInputTextFlags flags, ImGuiInputTextCallback callback, void *user_data);
CIMGUI_API bool igInputTextMultiline(const char *label, char *buf, size_t buf_size, const ImVec2 size, ImGuiInputTextFlags flags, ImGuiInputTextCallback callback, void *user_data);
CIMGUI_API bool igInputTextWithHint(const char *label, const char *hint, char *buf, size_t buf_size, ImGuiInputTextFlags flags, ImGuiInputTextCallback callback, void *user_data);
CIMGUI_API bool igInputFloat(const char *label, float *v, float step, float step_fast, const char *format, ImGuiInputTextFlags flags);
CIMGUI_API bool igInputFloat2(const char *label, float v[2], const char *format, ImGuiInputTextFlags flags);
CIMGUI_API bool igInputFloat3(const char *label, float v[3], const char *format, ImGuiInputTextFlags flags);
CIMGUI_API bool igInputFloat4(const char *label, float v[4], const char *format, ImGuiInputTextFlags flags);
CIMGUI_API bool igInputInt(const char *label, int *v, int step, int step_fast, ImGuiInputTextFlags flags);
CIMGUI_API bool igInputInt2(const char *label, int v[2], ImGuiInputTextFlags flags);
CIMGUI_API bool igInputInt3(const char *label, int v[3], ImGuiInputTextFlags flags);
CIMGUI_API bool igInputInt4(const char *label, int v[4], ImGuiInputTextFlags flags);
CIMGUI_API bool igInputDouble(const char *label, double *v, double step, double step_fast, const char *format, ImGuiInputTextFlags flags);
CIMGUI_API bool igInputScalar(const char *label, ImGuiDataType data_type, void *p_data, const void *p_step, const void *p_step_fast, const char *format, ImGuiInputTextFlags flags);
CIMGUI_API bool igInputScalarN(const char *label, ImGuiDataType data_type, void *p_data, int components, const void *p_step, const void *p_step_fast, const char *format, ImGuiInputTextFlags flags);
CIMGUI_API bool igColorEdit3(const char *label, float col[3], ImGuiColorEditFlags flags);
CIMGUI_API bool igColorEdit4(const char *label, float col[4], ImGuiColorEditFlags flags);
CIMGUI_API bool igColorPicker3(const char *label, float col[3], ImGuiColorEditFlags flags);
CIMGUI_API bool igColorPicker4(const char *label, float col[4], ImGuiColorEditFlags flags, const float *ref_col);
CIMGUI_API bool igColorButton(const char *desc_id, const ImVec4 col, ImGuiColorEditFlags flags, ImVec2 size);
CIMGUI_API void igSetColorEditOptions(ImGuiColorEditFlags flags);
CIMGUI_API bool igTreeNodeStr(const char *label);
CIMGUI_API bool igTreeNodeStrStr(const char *str_id, const char *fmt, ...);
CIMGUI_API bool igTreeNodePtr(const void *ptr_id, const char *fmt, ...);
CIMGUI_API bool igTreeNodeVStr(const char *str_id, const char *fmt, va_list args);
CIMGUI_API bool igTreeNodeVPtr(const void *ptr_id, const char *fmt, va_list args);
CIMGUI_API bool igTreeNodeExStr(const char *label, ImGuiTreeNodeFlags flags);
CIMGUI_API bool igTreeNodeExStrStr(const char *str_id, ImGuiTreeNodeFlags flags, const char *fmt, ...);
CIMGUI_API bool igTreeNodeExPtr(const void *ptr_id, ImGuiTreeNodeFlags flags, const char *fmt, ...);
CIMGUI_API bool igTreeNodeExVStr(const char *str_id, ImGuiTreeNodeFlags flags, const char *fmt, va_list args);
CIMGUI_API bool igTreeNodeExVPtr(const void *ptr_id, ImGuiTreeNodeFlags flags, const char *fmt, va_list args);
CIMGUI_API void igTreePushStr(const char *str_id);
CIMGUI_API void igTreePushPtr(const void *ptr_id);
CIMGUI_API void igTreePop(void);
CIMGUI_API float igGetTreeNodeToLabelSpacing(void);
CIMGUI_API bool igCollapsingHeaderTreeNodeFlags(const char *label, ImGuiTreeNodeFlags flags);
CIMGUI_API bool igCollapsingHeaderBoolPtr(const char *label, bool *p_open, ImGuiTreeNodeFlags flags);
CIMGUI_API void igSetNextItemOpen(bool is_open, ImGuiCond cond);
CIMGUI_API bool igSelectableBool(const char *label, bool selected, ImGuiSelectableFlags flags, const ImVec2 size);
CIMGUI_API bool igSelectableBoolPtr(const char *label, bool *p_selected, ImGuiSelectableFlags flags, const ImVec2 size);
CIMGUI_API bool igListBoxStr_arr(const char *label, int *current_item, const char *const items[], int items_count, int height_in_items);
CIMGUI_API bool igListBoxFnBoolPtr(const char *label, int *current_item, bool (*items_getter)(void *data, int idx, const char **out_text), void *data, int items_count, int height_in_items);
CIMGUI_API bool igListBoxHeaderVec2(const char *label, const ImVec2 size);
CIMGUI_API bool igListBoxHeaderInt(const char *label, int items_count, int height_in_items);
CIMGUI_API void igListBoxFooter(void);
CIMGUI_API void igPlotLinesFloatPtr(const char *label, const float *values, int values_count, int values_offset, const char *overlay_text, float scale_min, float scale_max, ImVec2 graph_size, int stride);
CIMGUI_API void igPlotLinesFnFloatPtr(const char *label, float (*values_getter)(void *data, int idx), void *data, int values_count, int values_offset, const char *overlay_text, float scale_min, float scale_max, ImVec2 graph_size);
CIMGUI_API void igPlotHistogramFloatPtr(const char *label, const float *values, int values_count, int values_offset, const char *overlay_text, float scale_min, float scale_max, ImVec2 graph_size, int stride);
CIMGUI_API void igPlotHistogramFnFloatPtr(const char *label, float (*values_getter)(void *data, int idx), void *data, int values_count, int values_offset, const char *overlay_text, float scale_min, float scale_max, ImVec2 graph_size);
CIMGUI_API void igValueBool(const char *prefix, bool b);
CIMGUI_API void igValueInt(const char *prefix, int v);
CIMGUI_API void igValueUint(const char *prefix, unsigned int v);
CIMGUI_API void igValueFloat(const char *prefix, float v, const char *float_format);
CIMGUI_API bool igBeginMenuBar(void);
CIMGUI_API void igEndMenuBar(void);
CIMGUI_API bool igBeginMainMenuBar(void);
CIMGUI_API void igEndMainMenuBar(void);
CIMGUI_API bool igBeginMenu(const char *label, bool enabled);
CIMGUI_API void igEndMenu(void);
CIMGUI_API bool igMenuItemBool(const char *label, const char *shortcut, bool selected, bool enabled);
CIMGUI_API bool igMenuItemBoolPtr(const char *label, const char *shortcut, bool *p_selected, bool enabled);
CIMGUI_API void igBeginTooltip(void);
CIMGUI_API void igEndTooltip(void);
CIMGUI_API void igSetTooltip(const char *fmt, ...);
CIMGUI_API void igSetTooltipV(const char *fmt, va_list args);
CIMGUI_API bool igBeginPopup(const char *str_id, ImGuiWindowFlags flags);
CIMGUI_API bool igBeginPopupModal(const char *name, bool *p_open, ImGuiWindowFlags flags);
CIMGUI_API void igEndPopup(void);
CIMGUI_API void igOpenPopup(const char *str_id, ImGuiPopupFlags popup_flags);
CIMGUI_API void igOpenPopupOnItemClick(const char *str_id, ImGuiPopupFlags popup_flags);
CIMGUI_API void igCloseCurrentPopup(void);
CIMGUI_API bool igBeginPopupContextItem(const char *str_id, ImGuiPopupFlags popup_flags);
CIMGUI_API bool igBeginPopupContextWindow(const char *str_id, ImGuiPopupFlags popup_flags);
CIMGUI_API bool igBeginPopupContextVoid(const char *str_id, ImGuiPopupFlags popup_flags);
CIMGUI_API bool igIsPopupOpenStr(const char *str_id, ImGuiPopupFlags flags);
CIMGUI_API void igColumns(int count, const char *id, bool border);
CIMGUI_API void igNextColumn(void);
CIMGUI_API int igGetColumnIndex(void);
CIMGUI_API float igGetColumnWidth(int column_index);
CIMGUI_API void igSetColumnWidth(int column_index, float width);
CIMGUI_API float igGetColumnOffset(int column_index);
CIMGUI_API void igSetColumnOffset(int column_index, float offset_x);
CIMGUI_API int igGetColumnsCount(void);
CIMGUI_API bool igBeginTabBar(const char *str_id, ImGuiTabBarFlags flags);
CIMGUI_API void igEndTabBar(void);
CIMGUI_API bool igBeginTabItem(const char *label, bool *p_open, ImGuiTabItemFlags flags);
CIMGUI_API void igEndTabItem(void);
CIMGUI_API bool igTabItemButton(const char *label, ImGuiTabItemFlags flags);
CIMGUI_API void igSetTabItemClosed(const char *tab_or_docked_window_label);
CIMGUI_API void igLogToTTY(int auto_open_depth);
CIMGUI_API void igLogToFile(int auto_open_depth, const char *filename);
CIMGUI_API void igLogToClipboard(int auto_open_depth);
CIMGUI_API void igLogFinish(void);
CIMGUI_API void igLogButtons(void);
CIMGUI_API bool igBeginDragDropSource(ImGuiDragDropFlags flags);
CIMGUI_API bool igSetDragDropPayload(const char *type, const void *data, size_t sz, ImGuiCond cond);
CIMGUI_API void igEndDragDropSource(void);
CIMGUI_API bool igBeginDragDropTarget(void);
CIMGUI_API const ImGuiPayload *igAcceptDragDropPayload(const char *type, ImGuiDragDropFlags flags);
CIMGUI_API void igEndDragDropTarget(void);
CIMGUI_API const ImGuiPayload *igGetDragDropPayload(void);
CIMGUI_API void igPushClipRect(const ImVec2 clip_rect_min, const ImVec2 clip_rect_max, bool intersect_with_current_clip_rect);
CIMGUI_API void igPopClipRect(void);
CIMGUI_API void igSetItemDefaultFocus(void);
CIMGUI_API void igSetKeyboardFocusHere(int offset);
CIMGUI_API bool igIsItemHovered(ImGuiHoveredFlags flags);
CIMGUI_API bool igIsItemActive(void);
CIMGUI_API bool igIsItemFocused(void);
CIMGUI_API bool igIsItemClicked(ImGuiMouseButton mouse_button);
CIMGUI_API bool igIsItemVisible(void);
CIMGUI_API bool igIsItemEdited(void);
CIMGUI_API bool igIsItemActivated(void);
CIMGUI_API bool igIsItemDeactivated(void);
CIMGUI_API bool igIsItemDeactivatedAfterEdit(void);
CIMGUI_API bool igIsItemToggledOpen(void);
CIMGUI_API bool igIsAnyItemHovered(void);
CIMGUI_API bool igIsAnyItemActive(void);
CIMGUI_API bool igIsAnyItemFocused(void);
CIMGUI_API void igGetItemRectMin(ImVec2 *pOut);
CIMGUI_API void igGetItemRectMax(ImVec2 *pOut);
CIMGUI_API void igGetItemRectSize(ImVec2 *pOut);
CIMGUI_API void igSetItemAllowOverlap(void);
CIMGUI_API bool igIsRectVisibleNil(const ImVec2 size);
CIMGUI_API bool igIsRectVisibleVec2(const ImVec2 rect_min, const ImVec2 rect_max);
CIMGUI_API double igGetTime(void);
CIMGUI_API int igGetFrameCount(void);
CIMGUI_API ImDrawList *igGetBackgroundDrawList(void);
CIMGUI_API ImDrawList *igGetForegroundDrawListNil(void);
CIMGUI_API ImDrawListSharedData *igGetDrawListSharedData(void);
CIMGUI_API const char *igGetStyleColorName(ImGuiCol idx);
CIMGUI_API void igSetStateStorage(ImGuiStorage *storage);
CIMGUI_API ImGuiStorage *igGetStateStorage(void);
CIMGUI_API void igCalcListClipping(int items_count, float items_height, int *out_items_display_start, int *out_items_display_end);
CIMGUI_API bool igBeginChildFrame(ImGuiID id, const ImVec2 size, ImGuiWindowFlags flags);
CIMGUI_API void igEndChildFrame(void);
CIMGUI_API void igCalcTextSize(ImVec2 *pOut, const char *text, const char *text_end, bool hide_text_after_double_hash, float wrap_width);
CIMGUI_API void igColorConvertU32ToFloat4(ImVec4 *pOut, ImU32 in);
CIMGUI_API ImU32 igColorConvertFloat4ToU32(const ImVec4 in);
CIMGUI_API void igColorConvertRGBtoHSV(float r, float g, float b, float *out_h, float *out_s, float *out_v);
CIMGUI_API void igColorConvertHSVtoRGB(float h, float s, float v, float *out_r, float *out_g, float *out_b);
CIMGUI_API int igGetKeyIndex(ImGuiKey imgui_key);
CIMGUI_API bool igIsKeyDown(int user_key_index);
CIMGUI_API bool igIsKeyPressed(int user_key_index, bool repeat);
CIMGUI_API bool igIsKeyReleased(int user_key_index);
CIMGUI_API int igGetKeyPressedAmount(int key_index, float repeat_delay, float rate);
CIMGUI_API void igCaptureKeyboardFromApp(bool want_capture_keyboard_value);
CIMGUI_API bool igIsMouseDown(ImGuiMouseButton button);
CIMGUI_API bool igIsMouseClicked(ImGuiMouseButton button, bool repeat);
CIMGUI_API bool igIsMouseReleased(ImGuiMouseButton button);
CIMGUI_API bool igIsMouseDoubleClicked(ImGuiMouseButton button);
CIMGUI_API bool igIsMouseHoveringRect(const ImVec2 r_min, const ImVec2 r_max, bool clip);
CIMGUI_API bool igIsMousePosValid(const ImVec2 *mouse_pos);
CIMGUI_API bool igIsAnyMouseDown(void);
CIMGUI_API void igGetMousePos(ImVec2 *pOut);
CIMGUI_API void igGetMousePosOnOpeningCurrentPopup(ImVec2 *pOut);
CIMGUI_API bool igIsMouseDragging(ImGuiMouseButton button, float lock_threshold);
CIMGUI_API void igGetMouseDragDelta(ImVec2 *pOut, ImGuiMouseButton button, float lock_threshold);
CIMGUI_API void igResetMouseDragDelta(ImGuiMouseButton button);
CIMGUI_API ImGuiMouseCursor igGetMouseCursor(void);
CIMGUI_API void igSetMouseCursor(ImGuiMouseCursor cursor_type);
CIMGUI_API void igCaptureMouseFromApp(bool want_capture_mouse_value);
CIMGUI_API const char *igGetClipboardText(void);
CIMGUI_API void igSetClipboardText(const char *text);
CIMGUI_API void igLoadIniSettingsFromDisk(const char *ini_filename);
CIMGUI_API void igLoadIniSettingsFromMemory(const char *ini_data, size_t ini_size);
CIMGUI_API void igSaveIniSettingsToDisk(const char *ini_filename);
CIMGUI_API const char *igSaveIniSettingsToMemory(size_t *out_ini_size);
CIMGUI_API bool igDebugCheckVersionAndDataLayout(const char *version_str, size_t sz_io, size_t sz_style, size_t sz_vec2, size_t sz_vec4, size_t sz_drawvert, size_t sz_drawidx);
CIMGUI_API void igSetAllocatorFunctions(void *(*alloc_func)(size_t sz, void *user_data), void (*free_func)(void *ptr, void *user_data), void *user_data);
CIMGUI_API void *igMemAlloc(size_t size);
CIMGUI_API void igMemFree(void *ptr);
CIMGUI_API ImGuiStyle *ImGuiStyle_ImGuiStyle(void);
CIMGUI_API void ImGuiStyle_destroy(ImGuiStyle *self);
CIMGUI_API void ImGuiStyle_ScaleAllSizes(ImGuiStyle *self, float scale_factor);
CIMGUI_API void ImGuiIO_AddInputCharacter(ImGuiIO *self, unsigned int c);
CIMGUI_API void ImGuiIO_AddInputCharacterUTF16(ImGuiIO *self, ImWchar16 c);
CIMGUI_API void ImGuiIO_AddInputCharactersUTF8(ImGuiIO *self, const char *str);
CIMGUI_API void ImGuiIO_ClearInputCharacters(ImGuiIO *self);
CIMGUI_API ImGuiIO *ImGuiIO_ImGuiIO(void);
CIMGUI_API void ImGuiIO_destroy(ImGuiIO *self);
CIMGUI_API ImGuiInputTextCallbackData *ImGuiInputTextCallbackData_ImGuiInputTextCallbackData(void);
CIMGUI_API void ImGuiInputTextCallbackData_destroy(ImGuiInputTextCallbackData *self);
CIMGUI_API void ImGuiInputTextCallbackData_DeleteChars(ImGuiInputTextCallbackData *self, int pos, int bytes_count);
CIMGUI_API void ImGuiInputTextCallbackData_InsertChars(ImGuiInputTextCallbackData *self, int pos, const char *text, const char *text_end);
CIMGUI_API void ImGuiInputTextCallbackData_SelectAll(ImGuiInputTextCallbackData *self);
CIMGUI_API void ImGuiInputTextCallbackData_ClearSelection(ImGuiInputTextCallbackData *self);
CIMGUI_API bool ImGuiInputTextCallbackData_HasSelection(ImGuiInputTextCallbackData *self);
CIMGUI_API ImGuiPayload *ImGuiPayload_ImGuiPayload(void);
CIMGUI_API void ImGuiPayload_destroy(ImGuiPayload *self);
CIMGUI_API void ImGuiPayload_Clear(ImGuiPayload *self);
CIMGUI_API bool ImGuiPayload_IsDataType(ImGuiPayload *self, const char *type);
CIMGUI_API bool ImGuiPayload_IsPreview(ImGuiPayload *self);
CIMGUI_API bool ImGuiPayload_IsDelivery(ImGuiPayload *self);
CIMGUI_API ImGuiOnceUponAFrame *ImGuiOnceUponAFrame_ImGuiOnceUponAFrame(void);
CIMGUI_API void ImGuiOnceUponAFrame_destroy(ImGuiOnceUponAFrame *self);
CIMGUI_API ImGuiTextFilter *ImGuiTextFilter_ImGuiTextFilter(const char *default_filter);
CIMGUI_API void ImGuiTextFilter_destroy(ImGuiTextFilter *self);
CIMGUI_API bool ImGuiTextFilter_Draw(ImGuiTextFilter *self, const char *label, float width);
CIMGUI_API bool ImGuiTextFilter_PassFilter(ImGuiTextFilter *self, const char *text, const char *text_end);
CIMGUI_API void ImGuiTextFilter_Build(ImGuiTextFilter *self);
CIMGUI_API void ImGuiTextFilter_Clear(ImGuiTextFilter *self);
CIMGUI_API bool ImGuiTextFilter_IsActive(ImGuiTextFilter *self);
CIMGUI_API ImGuiTextRange *ImGuiTextRange_ImGuiTextRangeNil(void);
CIMGUI_API void ImGuiTextRange_destroy(ImGuiTextRange *self);
CIMGUI_API ImGuiTextRange *ImGuiTextRange_ImGuiTextRangeStr(const char *_b, const char *_e);
CIMGUI_API bool ImGuiTextRange_empty(ImGuiTextRange *self);
CIMGUI_API void ImGuiTextRange_split(ImGuiTextRange *self, char separator, ImVector_ImGuiTextRange *out);
CIMGUI_API ImGuiTextBuffer *ImGuiTextBuffer_ImGuiTextBuffer(void);
CIMGUI_API void ImGuiTextBuffer_destroy(ImGuiTextBuffer *self);
CIMGUI_API const char *ImGuiTextBuffer_begin(ImGuiTextBuffer *self);
CIMGUI_API const char *ImGuiTextBuffer_end(ImGuiTextBuffer *self);
CIMGUI_API int ImGuiTextBuffer_size(ImGuiTextBuffer *self);
CIMGUI_API bool ImGuiTextBuffer_empty(ImGuiTextBuffer *self);
CIMGUI_API void ImGuiTextBuffer_clear(ImGuiTextBuffer *self);
CIMGUI_API void ImGuiTextBuffer_reserve(ImGuiTextBuffer *self, int capacity);
CIMGUI_API const char *ImGuiTextBuffer_c_str(ImGuiTextBuffer *self);
CIMGUI_API void ImGuiTextBuffer_append(ImGuiTextBuffer *self, const char *str, const char *str_end);
CIMGUI_API void ImGuiTextBuffer_appendfv(ImGuiTextBuffer *self, const char *fmt, va_list args);
CIMGUI_API ImGuiStoragePair *ImGuiStoragePair_ImGuiStoragePairInt(ImGuiID _key, int _val_i);
CIMGUI_API void ImGuiStoragePair_destroy(ImGuiStoragePair *self);
CIMGUI_API ImGuiStoragePair *ImGuiStoragePair_ImGuiStoragePairFloat(ImGuiID _key, float _val_f);
CIMGUI_API ImGuiStoragePair *ImGuiStoragePair_ImGuiStoragePairPtr(ImGuiID _key, void *_val_p);
CIMGUI_API void ImGuiStorage_Clear(ImGuiStorage *self);
CIMGUI_API int ImGuiStorage_GetInt(ImGuiStorage *self, ImGuiID key, int default_val);
CIMGUI_API void ImGuiStorage_SetInt(ImGuiStorage *self, ImGuiID key, int val);
CIMGUI_API bool ImGuiStorage_GetBool(ImGuiStorage *self, ImGuiID key, bool default_val);
CIMGUI_API void ImGuiStorage_SetBool(ImGuiStorage *self, ImGuiID key, bool val);
CIMGUI_API float ImGuiStorage_GetFloat(ImGuiStorage *self, ImGuiID key, float default_val);
CIMGUI_API void ImGuiStorage_SetFloat(ImGuiStorage *self, ImGuiID key, float val);
CIMGUI_API void *ImGuiStorage_GetVoidPtr(ImGuiStorage *self, ImGuiID key);
CIMGUI_API void ImGuiStorage_SetVoidPtr(ImGuiStorage *self, ImGuiID key, void *val);
CIMGUI_API int *ImGuiStorage_GetIntRef(ImGuiStorage *self, ImGuiID key, int default_val);
CIMGUI_API bool *ImGuiStorage_GetBoolRef(ImGuiStorage *self, ImGuiID key, bool default_val);
CIMGUI_API float *ImGuiStorage_GetFloatRef(ImGuiStorage *self, ImGuiID key, float default_val);
CIMGUI_API void **ImGuiStorage_GetVoidPtrRef(ImGuiStorage *self, ImGuiID key, void *default_val);
CIMGUI_API void ImGuiStorage_SetAllInt(ImGuiStorage *self, int val);
CIMGUI_API void ImGuiStorage_BuildSortByKey(ImGuiStorage *self);
CIMGUI_API ImGuiListClipper *ImGuiListClipper_ImGuiListClipper(void);
CIMGUI_API void ImGuiListClipper_destroy(ImGuiListClipper *self);
CIMGUI_API void ImGuiListClipper_Begin(ImGuiListClipper *self, int items_count, float items_height);
CIMGUI_API void ImGuiListClipper_End(ImGuiListClipper *self);
CIMGUI_API bool ImGuiListClipper_Step(ImGuiListClipper *self);
CIMGUI_API ImColor *ImColor_ImColorNil(void);
CIMGUI_API void ImColor_destroy(ImColor *self);
CIMGUI_API ImColor *ImColor_ImColorInt(int r, int g, int b, int a);
CIMGUI_API ImColor *ImColor_ImColorU32(ImU32 rgba);
CIMGUI_API ImColor *ImColor_ImColorFloat(float r, float g, float b, float a);
CIMGUI_API ImColor *ImColor_ImColorVec4(const ImVec4 col);
CIMGUI_API void ImColor_SetHSV(ImColor *self, float h, float s, float v, float a);
CIMGUI_API void ImColor_HSV(ImColor *pOut, float h, float s, float v, float a);
CIMGUI_API ImDrawCmd *ImDrawCmd_ImDrawCmd(void);
CIMGUI_API void ImDrawCmd_destroy(ImDrawCmd *self);
CIMGUI_API ImDrawListSplitter *ImDrawListSplitter_ImDrawListSplitter(void);
CIMGUI_API void ImDrawListSplitter_destroy(ImDrawListSplitter *self);
CIMGUI_API void ImDrawListSplitter_Clear(ImDrawListSplitter *self);
CIMGUI_API void ImDrawListSplitter_ClearFreeMemory(ImDrawListSplitter *self);
CIMGUI_API void ImDrawListSplitter_Split(ImDrawListSplitter *self, ImDrawList *draw_list, int count);
CIMGUI_API void ImDrawListSplitter_Merge(ImDrawListSplitter *self, ImDrawList *draw_list);
CIMGUI_API void ImDrawListSplitter_SetCurrentChannel(ImDrawListSplitter *self, ImDrawList *draw_list, int channel_idx);
CIMGUI_API ImDrawList *ImDrawList_ImDrawList(const ImDrawListSharedData *shared_data);
CIMGUI_API void ImDrawList_destroy(ImDrawList *self);
CIMGUI_API void ImDrawList_PushClipRect(ImDrawList *self, ImVec2 clip_rect_min, ImVec2 clip_rect_max, bool intersect_with_current_clip_rect);
CIMGUI_API void ImDrawList_PushClipRectFullScreen(ImDrawList *self);
CIMGUI_API void ImDrawList_PopClipRect(ImDrawList *self);
CIMGUI_API void ImDrawList_PushTextureID(ImDrawList *self, ImTextureID texture_id);
CIMGUI_API void ImDrawList_PopTextureID(ImDrawList *self);
CIMGUI_API void ImDrawList_GetClipRectMin(ImVec2 *pOut, ImDrawList *self);
CIMGUI_API void ImDrawList_GetClipRectMax(ImVec2 *pOut, ImDrawList *self);
CIMGUI_API void ImDrawList_AddLine(ImDrawList *self, const ImVec2 p1, const ImVec2 p2, ImU32 col, float thickness);
CIMGUI_API void ImDrawList_AddRect(ImDrawList *self, const ImVec2 p_min, const ImVec2 p_max, ImU32 col, float rounding, ImDrawCornerFlags rounding_corners, float thickness);
CIMGUI_API void ImDrawList_AddRectFilled(ImDrawList *self, const ImVec2 p_min, const ImVec2 p_max, ImU32 col, float rounding, ImDrawCornerFlags rounding_corners);
CIMGUI_API void ImDrawList_AddRectFilledMultiColor(ImDrawList *self, const ImVec2 p_min, const ImVec2 p_max, ImU32 col_upr_left, ImU32 col_upr_right, ImU32 col_bot_right, ImU32 col_bot_left);
CIMGUI_API void ImDrawList_AddQuad(ImDrawList *self, const ImVec2 p1, const ImVec2 p2, const ImVec2 p3, const ImVec2 p4, ImU32 col, float thickness);
CIMGUI_API void ImDrawList_AddQuadFilled(ImDrawList *self, const ImVec2 p1, const ImVec2 p2, const ImVec2 p3, const ImVec2 p4, ImU32 col);
CIMGUI_API void ImDrawList_AddTriangle(ImDrawList *self, const ImVec2 p1, const ImVec2 p2, const ImVec2 p3, ImU32 col, float thickness);
CIMGUI_API void ImDrawList_AddTriangleFilled(ImDrawList *self, const ImVec2 p1, const ImVec2 p2, const ImVec2 p3, ImU32 col);
CIMGUI_API void ImDrawList_AddCircle(ImDrawList *self, const ImVec2 center, float radius, ImU32 col, int num_segments, float thickness);
CIMGUI_API void ImDrawList_AddCircleFilled(ImDrawList *self, const ImVec2 center, float radius, ImU32 col, int num_segments);
CIMGUI_API void ImDrawList_AddNgon(ImDrawList *self, const ImVec2 center, float radius, ImU32 col, int num_segments, float thickness);
CIMGUI_API void ImDrawList_AddNgonFilled(ImDrawList *self, const ImVec2 center, float radius, ImU32 col, int num_segments);
CIMGUI_API void ImDrawList_AddTextVec2(ImDrawList *self, const ImVec2 pos, ImU32 col, const char *text_begin, const char *text_end);
CIMGUI_API void ImDrawList_AddTextFontPtr(ImDrawList *self, const ImFont *font, float font_size, const ImVec2 pos, ImU32 col, const char *text_begin, const char *text_end, float wrap_width, const ImVec4 *cpu_fine_clip_rect);
CIMGUI_API void ImDrawList_AddPolyline(ImDrawList *self, const ImVec2 *points, int num_points, ImU32 col, bool closed, float thickness);
CIMGUI_API void ImDrawList_AddConvexPolyFilled(ImDrawList *self, const ImVec2 *points, int num_points, ImU32 col);
CIMGUI_API void ImDrawList_AddBezierCurve(ImDrawList *self, const ImVec2 p1, const ImVec2 p2, const ImVec2 p3, const ImVec2 p4, ImU32 col, float thickness, int num_segments);
CIMGUI_API void ImDrawList_AddImage(ImDrawList *self, ImTextureID user_texture_id, const ImVec2 p_min, const ImVec2 p_max, const ImVec2 uv_min, const ImVec2 uv_max, ImU32 col);
CIMGUI_API void ImDrawList_AddImageQuad(ImDrawList *self, ImTextureID user_texture_id, const ImVec2 p1, const ImVec2 p2, const ImVec2 p3, const ImVec2 p4, const ImVec2 uv1, const ImVec2 uv2, const ImVec2 uv3, const ImVec2 uv4, ImU32 col);
CIMGUI_API void ImDrawList_AddImageRounded(ImDrawList *self, ImTextureID user_texture_id, const ImVec2 p_min, const ImVec2 p_max, const ImVec2 uv_min, const ImVec2 uv_max, ImU32 col, float rounding, ImDrawCornerFlags rounding_corners);
CIMGUI_API void ImDrawList_PathClear(ImDrawList *self);
CIMGUI_API void ImDrawList_PathLineTo(ImDrawList *self, const ImVec2 pos);
CIMGUI_API void ImDrawList_PathLineToMergeDuplicate(ImDrawList *self, const ImVec2 pos);
CIMGUI_API void ImDrawList_PathFillConvex(ImDrawList *self, ImU32 col);
CIMGUI_API void ImDrawList_PathStroke(ImDrawList *self, ImU32 col, bool closed, float thickness);
CIMGUI_API void ImDrawList_PathArcTo(ImDrawList *self, const ImVec2 center, float radius, float a_min, float a_max, int num_segments);
CIMGUI_API void ImDrawList_PathArcToFast(ImDrawList *self, const ImVec2 center, float radius, int a_min_of_12, int a_max_of_12);
CIMGUI_API void ImDrawList_PathBezierCurveTo(ImDrawList *self, const ImVec2 p2, const ImVec2 p3, const ImVec2 p4, int num_segments);
CIMGUI_API void ImDrawList_PathRect(ImDrawList *self, const ImVec2 rect_min, const ImVec2 rect_max, float rounding, ImDrawCornerFlags rounding_corners);
CIMGUI_API void ImDrawList_AddCallback(ImDrawList *self, ImDrawCallback callback, void *callback_data);
CIMGUI_API void ImDrawList_AddDrawCmd(ImDrawList *self);
CIMGUI_API ImDrawList *ImDrawList_CloneOutput(ImDrawList *self);
CIMGUI_API void ImDrawList_ChannelsSplit(ImDrawList *self, int count);
CIMGUI_API void ImDrawList_ChannelsMerge(ImDrawList *self);
CIMGUI_API void ImDrawList_ChannelsSetCurrent(ImDrawList *self, int n);
CIMGUI_API void ImDrawList_PrimReserve(ImDrawList *self, int idx_count, int vtx_count);
CIMGUI_API void ImDrawList_PrimUnreserve(ImDrawList *self, int idx_count, int vtx_count);
CIMGUI_API void ImDrawList_PrimRect(ImDrawList *self, const ImVec2 a, const ImVec2 b, ImU32 col);
CIMGUI_API void ImDrawList_PrimRectUV(ImDrawList *self, const ImVec2 a, const ImVec2 b, const ImVec2 uv_a, const ImVec2 uv_b, ImU32 col);
CIMGUI_API void ImDrawList_PrimQuadUV(ImDrawList *self, const ImVec2 a, const ImVec2 b, const ImVec2 c, const ImVec2 d, const ImVec2 uv_a, const ImVec2 uv_b, const ImVec2 uv_c, const ImVec2 uv_d, ImU32 col);
CIMGUI_API void ImDrawList_PrimWriteVtx(ImDrawList *self, const ImVec2 pos, const ImVec2 uv, ImU32 col);
CIMGUI_API void ImDrawList_PrimWriteIdx(ImDrawList *self, ImDrawIdx idx);
CIMGUI_API void ImDrawList_PrimVtx(ImDrawList *self, const ImVec2 pos, const ImVec2 uv, ImU32 col);
CIMGUI_API void ImDrawList__ResetForNewFrame(ImDrawList *self);
CIMGUI_API void ImDrawList__ClearFreeMemory(ImDrawList *self);
CIMGUI_API void ImDrawList__PopUnusedDrawCmd(ImDrawList *self);
CIMGUI_API void ImDrawList__OnChangedClipRect(ImDrawList *self);
CIMGUI_API void ImDrawList__OnChangedTextureID(ImDrawList *self);
CIMGUI_API void ImDrawList__OnChangedVtxOffset(ImDrawList *self);
CIMGUI_API ImDrawData *ImDrawData_ImDrawData(void);
CIMGUI_API void ImDrawData_destroy(ImDrawData *self);
CIMGUI_API void ImDrawData_Clear(ImDrawData *self);
CIMGUI_API void ImDrawData_DeIndexAllBuffers(ImDrawData *self);
CIMGUI_API void ImDrawData_ScaleClipRects(ImDrawData *self, const ImVec2 fb_scale);
CIMGUI_API ImFontConfig *ImFontConfig_ImFontConfig(void);
CIMGUI_API void ImFontConfig_destroy(ImFontConfig *self);
CIMGUI_API ImFontGlyphRangesBuilder *ImFontGlyphRangesBuilder_ImFontGlyphRangesBuilder(void);
CIMGUI_API void ImFontGlyphRangesBuilder_destroy(ImFontGlyphRangesBuilder *self);
CIMGUI_API void ImFontGlyphRangesBuilder_Clear(ImFontGlyphRangesBuilder *self);
CIMGUI_API bool ImFontGlyphRangesBuilder_GetBit(ImFontGlyphRangesBuilder *self, size_t n);
CIMGUI_API void ImFontGlyphRangesBuilder_SetBit(ImFontGlyphRangesBuilder *self, size_t n);
CIMGUI_API void ImFontGlyphRangesBuilder_AddChar(ImFontGlyphRangesBuilder *self, ImWchar c);
CIMGUI_API void ImFontGlyphRangesBuilder_AddText(ImFontGlyphRangesBuilder *self, const char *text, const char *text_end);
CIMGUI_API void ImFontGlyphRangesBuilder_AddRanges(ImFontGlyphRangesBuilder *self, const ImWchar *ranges);
CIMGUI_API void ImFontGlyphRangesBuilder_BuildRanges(ImFontGlyphRangesBuilder *self, ImVector_ImWchar *out_ranges);
CIMGUI_API ImFontAtlasCustomRect *ImFontAtlasCustomRect_ImFontAtlasCustomRect(void);
CIMGUI_API void ImFontAtlasCustomRect_destroy(ImFontAtlasCustomRect *self);
CIMGUI_API bool ImFontAtlasCustomRect_IsPacked(ImFontAtlasCustomRect *self);
CIMGUI_API ImFontAtlas *ImFontAtlas_ImFontAtlas(void);
CIMGUI_API void ImFontAtlas_destroy(ImFontAtlas *self);
CIMGUI_API ImFont *ImFontAtlas_AddFont(ImFontAtlas *self, const ImFontConfig *font_cfg);
CIMGUI_API ImFont *ImFontAtlas_AddFontDefault(ImFontAtlas *self, const ImFontConfig *font_cfg);
CIMGUI_API ImFont *ImFontAtlas_AddFontFromFileTTF(ImFontAtlas *self, const char *filename, float size_pixels, const ImFontConfig *font_cfg, const ImWchar *glyph_ranges);
CIMGUI_API ImFont *ImFontAtlas_AddFontFromMemoryTTF(ImFontAtlas *self, void *font_data, int font_size, float size_pixels, const ImFontConfig *font_cfg, const ImWchar *glyph_ranges);
CIMGUI_API ImFont *ImFontAtlas_AddFontFromMemoryCompressedTTF(ImFontAtlas *self, const void *compressed_font_data, int compressed_font_size, float size_pixels, const ImFontConfig *font_cfg, const ImWchar *glyph_ranges);
CIMGUI_API ImFont *ImFontAtlas_AddFontFromMemoryCompressedBase85TTF(ImFontAtlas *self, const char *compressed_font_data_base85, float size_pixels, const ImFontConfig *font_cfg, const ImWchar *glyph_ranges);
CIMGUI_API void ImFontAtlas_ClearInputData(ImFontAtlas *self);
CIMGUI_API void ImFontAtlas_ClearTexData(ImFontAtlas *self);
CIMGUI_API void ImFontAtlas_ClearFonts(ImFontAtlas *self);
CIMGUI_API void ImFontAtlas_Clear(ImFontAtlas *self);
CIMGUI_API bool ImFontAtlas_Build(ImFontAtlas *self);
CIMGUI_API void ImFontAtlas_GetTexDataAsAlpha8(ImFontAtlas *self, unsigned char **out_pixels, int *out_width, int *out_height, int *out_bytes_per_pixel);
CIMGUI_API void ImFontAtlas_GetTexDataAsRGBA32(ImFontAtlas *self, unsigned char **out_pixels, int *out_width, int *out_height, int *out_bytes_per_pixel);
CIMGUI_API bool ImFontAtlas_IsBuilt(ImFontAtlas *self);
CIMGUI_API void ImFontAtlas_SetTexID(ImFontAtlas *self, ImTextureID id);
CIMGUI_API const ImWchar *ImFontAtlas_GetGlyphRangesDefault(ImFontAtlas *self);
CIMGUI_API const ImWchar *ImFontAtlas_GetGlyphRangesKorean(ImFontAtlas *self);
CIMGUI_API const ImWchar *ImFontAtlas_GetGlyphRangesJapanese(ImFontAtlas *self);
CIMGUI_API const ImWchar *ImFontAtlas_GetGlyphRangesChineseFull(ImFontAtlas *self);
CIMGUI_API const ImWchar *ImFontAtlas_GetGlyphRangesChineseSimplifiedCommon(ImFontAtlas *self);
CIMGUI_API const ImWchar *ImFontAtlas_GetGlyphRangesCyrillic(ImFontAtlas *self);
CIMGUI_API const ImWchar *ImFontAtlas_GetGlyphRangesThai(ImFontAtlas *self);
CIMGUI_API const ImWchar *ImFontAtlas_GetGlyphRangesVietnamese(ImFontAtlas *self);
CIMGUI_API int ImFontAtlas_AddCustomRectRegular(ImFontAtlas *self, int width, int height);
CIMGUI_API int ImFontAtlas_AddCustomRectFontGlyph(ImFontAtlas *self, ImFont *font, ImWchar id, int width, int height, float advance_x, const ImVec2 offset);
CIMGUI_API ImFontAtlasCustomRect *ImFontAtlas_GetCustomRectByIndex(ImFontAtlas *self, int index);
CIMGUI_API void ImFontAtlas_CalcCustomRectUV(ImFontAtlas *self, const ImFontAtlasCustomRect *rect, ImVec2 *out_uv_min, ImVec2 *out_uv_max);
CIMGUI_API bool ImFontAtlas_GetMouseCursorTexData(ImFontAtlas *self, ImGuiMouseCursor cursor, ImVec2 *out_offset, ImVec2 *out_size, ImVec2 out_uv_border[2], ImVec2 out_uv_fill[2]);
CIMGUI_API ImFont *ImFont_ImFont(void);
CIMGUI_API void ImFont_destroy(ImFont *self);
CIMGUI_API const ImFontGlyph *ImFont_FindGlyph(ImFont *self, ImWchar c);
CIMGUI_API const ImFontGlyph *ImFont_FindGlyphNoFallback(ImFont *self, ImWchar c);
CIMGUI_API float ImFont_GetCharAdvance(ImFont *self, ImWchar c);
CIMGUI_API bool ImFont_IsLoaded(ImFont *self);
CIMGUI_API const char *ImFont_GetDebugName(ImFont *self);
CIMGUI_API void ImFont_CalcTextSizeA(ImVec2 *pOut, ImFont *self, float size, float max_width, float wrap_width, const char *text_begin, const char *text_end, const char **remaining);
CIMGUI_API const char *ImFont_CalcWordWrapPositionA(ImFont *self, float scale, const char *text, const char *text_end, float wrap_width);
CIMGUI_API void ImFont_RenderChar(ImFont *self, ImDrawList *draw_list, float size, ImVec2 pos, ImU32 col, ImWchar c);
CIMGUI_API void ImFont_RenderText(ImFont *self, ImDrawList *draw_list, float size, ImVec2 pos, ImU32 col, const ImVec4 clip_rect, const char *text_begin, const char *text_end, float wrap_width, bool cpu_fine_clip);
CIMGUI_API void ImFont_BuildLookupTable(ImFont *self);
CIMGUI_API void ImFont_ClearOutputData(ImFont *self);
CIMGUI_API void ImFont_GrowIndex(ImFont *self, int new_size);
CIMGUI_API void ImFont_AddGlyph(ImFont *self, const ImFontConfig *src_cfg, ImWchar c, float x0, float y0, float x1, float y1, float u0, float v0, float u1, float v1, float advance_x);
CIMGUI_API void ImFont_AddRemapChar(ImFont *self, ImWchar dst, ImWchar src, bool overwrite_dst);
CIMGUI_API void ImFont_SetGlyphVisible(ImFont *self, ImWchar c, bool visible);
CIMGUI_API void ImFont_SetFallbackChar(ImFont *self, ImWchar c);
CIMGUI_API bool ImFont_IsGlyphRangeUnused(ImFont *self, unsigned int c_begin, unsigned int c_last);
CIMGUI_API ImU32 igImHashData(const void *data, size_t data_size, ImU32 seed);
CIMGUI_API ImU32 igImHashStr(const char *data, size_t data_size, ImU32 seed);
CIMGUI_API ImU32 igImAlphaBlendColors(ImU32 col_a, ImU32 col_b);
CIMGUI_API bool igImIsPowerOfTwo(int v);
CIMGUI_API int igImUpperPowerOfTwo(int v);
CIMGUI_API int igImStricmp(const char *str1, const char *str2);
CIMGUI_API int igImStrnicmp(const char *str1, const char *str2, size_t count);
CIMGUI_API void igImStrncpy(char *dst, const char *src, size_t count);
CIMGUI_API char *igImStrdup(const char *str);
CIMGUI_API char *igImStrdupcpy(char *dst, size_t *p_dst_size, const char *str);
CIMGUI_API const char *igImStrchrRange(const char *str_begin, const char *str_end, char c);
CIMGUI_API int igImStrlenW(const ImWchar *str);
CIMGUI_API const char *igImStreolRange(const char *str, const char *str_end);
CIMGUI_API const ImWchar *igImStrbolW(const ImWchar *buf_mid_line, const ImWchar *buf_begin);
CIMGUI_API const char *igImStristr(const char *haystack, const char *haystack_end, const char *needle, const char *needle_end);
CIMGUI_API void igImStrTrimBlanks(char *str);
CIMGUI_API const char *igImStrSkipBlank(const char *str);
CIMGUI_API int igImFormatString(char *buf, size_t buf_size, const char *fmt, ...);
CIMGUI_API int igImFormatStringV(char *buf, size_t buf_size, const char *fmt, va_list args);
CIMGUI_API const char *igImParseFormatFindStart(const char *format);
CIMGUI_API const char *igImParseFormatFindEnd(const char *format);
CIMGUI_API const char *igImParseFormatTrimDecorations(const char *format, char *buf, size_t buf_size);
CIMGUI_API int igImParseFormatPrecision(const char *format, int default_value);
CIMGUI_API bool igImCharIsBlankA(char c);
CIMGUI_API bool igImCharIsBlankW(unsigned int c);
CIMGUI_API int igImTextStrToUtf8(char *buf, int buf_size, const ImWchar *in_text, const ImWchar *in_text_end);
CIMGUI_API int igImTextCharFromUtf8(unsigned int *out_char, const char *in_text, const char *in_text_end);
CIMGUI_API int igImTextStrFromUtf8(ImWchar *buf, int buf_size, const char *in_text, const char *in_text_end, const char **in_remaining);
CIMGUI_API int igImTextCountCharsFromUtf8(const char *in_text, const char *in_text_end);
CIMGUI_API int igImTextCountUtf8BytesFromChar(const char *in_text, const char *in_text_end);
CIMGUI_API int igImTextCountUtf8BytesFromStr(const ImWchar *in_text, const ImWchar *in_text_end);
CIMGUI_API ImFileHandle igImFileOpen(const char *filename, const char *mode);
CIMGUI_API bool igImFileClose(ImFileHandle file);
CIMGUI_API ImU64 igImFileGetSize(ImFileHandle file);
CIMGUI_API ImU64 igImFileRead(void *data, ImU64 size, ImU64 count, ImFileHandle file);
CIMGUI_API ImU64 igImFileWrite(const void *data, ImU64 size, ImU64 count, ImFileHandle file);
CIMGUI_API void *igImFileLoadToMemory(const char *filename, const char *mode, size_t *out_file_size, int padding_bytes);
CIMGUI_API float igImPowFloat(float x, float y);
CIMGUI_API double igImPowdouble(double x, double y);
CIMGUI_API float igImLogFloat(float x);
CIMGUI_API double igImLogdouble(double x);
CIMGUI_API float igImAbsFloat(float x);
CIMGUI_API double igImAbsdouble(double x);
CIMGUI_API float igImSignFloat(float x);
CIMGUI_API double igImSigndouble(double x);
CIMGUI_API void igImMin(ImVec2 *pOut, const ImVec2 lhs, const ImVec2 rhs);
CIMGUI_API void igImMax(ImVec2 *pOut, const ImVec2 lhs, const ImVec2 rhs);
CIMGUI_API void igImClamp(ImVec2 *pOut, const ImVec2 v, const ImVec2 mn, ImVec2 mx);
CIMGUI_API void igImLerpVec2Float(ImVec2 *pOut, const ImVec2 a, const ImVec2 b, float t);
CIMGUI_API void igImLerpVec2Vec2(ImVec2 *pOut, const ImVec2 a, const ImVec2 b, const ImVec2 t);
CIMGUI_API void igImLerpVec4(ImVec4 *pOut, const ImVec4 a, const ImVec4 b, float t);
CIMGUI_API float igImSaturate(float f);
CIMGUI_API float igImLengthSqrVec2(const ImVec2 lhs);
CIMGUI_API float igImLengthSqrVec4(const ImVec4 lhs);
CIMGUI_API float igImInvLength(const ImVec2 lhs, float fail_value);
CIMGUI_API float igImFloorFloat(float f);
CIMGUI_API void igImFloorVec2(ImVec2 *pOut, const ImVec2 v);
CIMGUI_API int igImModPositive(int a, int b);
CIMGUI_API float igImDot(const ImVec2 a, const ImVec2 b);
CIMGUI_API void igImRotate(ImVec2 *pOut, const ImVec2 v, float cos_a, float sin_a);
CIMGUI_API float igImLinearSweep(float current, float target, float speed);
CIMGUI_API void igImMul(ImVec2 *pOut, const ImVec2 lhs, const ImVec2 rhs);
CIMGUI_API void igImBezierCalc(ImVec2 *pOut, const ImVec2 p1, const ImVec2 p2, const ImVec2 p3, const ImVec2 p4, float t);
CIMGUI_API void igImBezierClosestPoint(ImVec2 *pOut, const ImVec2 p1, const ImVec2 p2, const ImVec2 p3, const ImVec2 p4, const ImVec2 p, int num_segments);
CIMGUI_API void igImBezierClosestPointCasteljau(ImVec2 *pOut, const ImVec2 p1, const ImVec2 p2, const ImVec2 p3, const ImVec2 p4, const ImVec2 p, float tess_tol);
CIMGUI_API void igImLineClosestPoint(ImVec2 *pOut, const ImVec2 a, const ImVec2 b, const ImVec2 p);
CIMGUI_API bool igImTriangleContainsPoint(const ImVec2 a, const ImVec2 b, const ImVec2 c, const ImVec2 p);
CIMGUI_API void igImTriangleClosestPoint(ImVec2 *pOut, const ImVec2 a, const ImVec2 b, const ImVec2 c, const ImVec2 p);
CIMGUI_API void igImTriangleBarycentricCoords(const ImVec2 a, const ImVec2 b, const ImVec2 c, const ImVec2 p, float *out_u, float *out_v, float *out_w);
CIMGUI_API float igImTriangleArea(const ImVec2 a, const ImVec2 b, const ImVec2 c);
CIMGUI_API ImGuiDir igImGetDirQuadrantFromDelta(float dx, float dy);
CIMGUI_API ImVec1 *ImVec1_ImVec1Nil(void);
CIMGUI_API void ImVec1_destroy(ImVec1 *self);
CIMGUI_API ImVec1 *ImVec1_ImVec1Float(float _x);
CIMGUI_API ImVec2ih *ImVec2ih_ImVec2ihNil(void);
CIMGUI_API void ImVec2ih_destroy(ImVec2ih *self);
CIMGUI_API ImVec2ih *ImVec2ih_ImVec2ihshort(short _x, short _y);
CIMGUI_API ImVec2ih *ImVec2ih_ImVec2ihVec2(const ImVec2 rhs);
CIMGUI_API ImRect *ImRect_ImRectNil(void);
CIMGUI_API void ImRect_destroy(ImRect *self);
CIMGUI_API ImRect *ImRect_ImRectVec2(const ImVec2 min, const ImVec2 max);
CIMGUI_API ImRect *ImRect_ImRectVec4(const ImVec4 v);
CIMGUI_API ImRect *ImRect_ImRectFloat(float x1, float y1, float x2, float y2);
CIMGUI_API void ImRect_GetCenter(ImVec2 *pOut, ImRect *self);
CIMGUI_API void ImRect_GetSize(ImVec2 *pOut, ImRect *self);
CIMGUI_API float ImRect_GetWidth(ImRect *self);
CIMGUI_API float ImRect_GetHeight(ImRect *self);
CIMGUI_API void ImRect_GetTL(ImVec2 *pOut, ImRect *self);
CIMGUI_API void ImRect_GetTR(ImVec2 *pOut, ImRect *self);
CIMGUI_API void ImRect_GetBL(ImVec2 *pOut, ImRect *self);
CIMGUI_API void ImRect_GetBR(ImVec2 *pOut, ImRect *self);
CIMGUI_API bool ImRect_ContainsVec2(ImRect *self, const ImVec2 p);
CIMGUI_API bool ImRect_ContainsRect(ImRect *self, const ImRect r);
CIMGUI_API bool ImRect_Overlaps(ImRect *self, const ImRect r);
CIMGUI_API void ImRect_AddVec2(ImRect *self, const ImVec2 p);
CIMGUI_API void ImRect_AddRect(ImRect *self, const ImRect r);
CIMGUI_API void ImRect_ExpandFloat(ImRect *self, const float amount);
CIMGUI_API void ImRect_ExpandVec2(ImRect *self, const ImVec2 amount);
CIMGUI_API void ImRect_Translate(ImRect *self, const ImVec2 d);
CIMGUI_API void ImRect_TranslateX(ImRect *self, float dx);
CIMGUI_API void ImRect_TranslateY(ImRect *self, float dy);
CIMGUI_API void ImRect_ClipWith(ImRect *self, const ImRect r);
CIMGUI_API void ImRect_ClipWithFull(ImRect *self, const ImRect r);
CIMGUI_API void ImRect_Floor(ImRect *self);
CIMGUI_API bool ImRect_IsInverted(ImRect *self);
CIMGUI_API void ImRect_ToVec4(ImVec4 *pOut, ImRect *self);
CIMGUI_API bool igImBitArrayTestBit(const ImU32 *arr, int n);
CIMGUI_API void igImBitArrayClearBit(ImU32 *arr, int n);
CIMGUI_API void igImBitArraySetBit(ImU32 *arr, int n);
CIMGUI_API void igImBitArraySetBitRange(ImU32 *arr, int n, int n2);
CIMGUI_API void ImBitVector_Create(ImBitVector *self, int sz);
CIMGUI_API void ImBitVector_Clear(ImBitVector *self);
CIMGUI_API bool ImBitVector_TestBit(ImBitVector *self, int n);
CIMGUI_API void ImBitVector_SetBit(ImBitVector *self, int n);
CIMGUI_API void ImBitVector_ClearBit(ImBitVector *self, int n);
CIMGUI_API ImDrawListSharedData *ImDrawListSharedData_ImDrawListSharedData(void);
CIMGUI_API void ImDrawListSharedData_destroy(ImDrawListSharedData *self);
CIMGUI_API void ImDrawListSharedData_SetCircleSegmentMaxError(ImDrawListSharedData *self, float max_error);
CIMGUI_API void ImDrawDataBuilder_Clear(ImDrawDataBuilder *self);
CIMGUI_API void ImDrawDataBuilder_ClearFreeMemory(ImDrawDataBuilder *self);
CIMGUI_API void ImDrawDataBuilder_FlattenIntoSingleLayer(ImDrawDataBuilder *self);
CIMGUI_API ImGuiStyleMod *ImGuiStyleMod_ImGuiStyleModInt(ImGuiStyleVar idx, int v);
CIMGUI_API void ImGuiStyleMod_destroy(ImGuiStyleMod *self);
CIMGUI_API ImGuiStyleMod *ImGuiStyleMod_ImGuiStyleModFloat(ImGuiStyleVar idx, float v);
CIMGUI_API ImGuiStyleMod *ImGuiStyleMod_ImGuiStyleModVec2(ImGuiStyleVar idx, ImVec2 v);
CIMGUI_API ImGuiMenuColumns *ImGuiMenuColumns_ImGuiMenuColumns(void);
CIMGUI_API void ImGuiMenuColumns_destroy(ImGuiMenuColumns *self);
CIMGUI_API void ImGuiMenuColumns_Update(ImGuiMenuColumns *self, int count, float spacing, bool clear);
CIMGUI_API float ImGuiMenuColumns_DeclColumns(ImGuiMenuColumns *self, float w0, float w1, float w2);
CIMGUI_API float ImGuiMenuColumns_CalcExtraSpace(ImGuiMenuColumns *self, float avail_w);
CIMGUI_API ImGuiInputTextState *ImGuiInputTextState_ImGuiInputTextState(void);
CIMGUI_API void ImGuiInputTextState_destroy(ImGuiInputTextState *self);
CIMGUI_API void ImGuiInputTextState_ClearText(ImGuiInputTextState *self);
CIMGUI_API void ImGuiInputTextState_ClearFreeMemory(ImGuiInputTextState *self);
CIMGUI_API int ImGuiInputTextState_GetUndoAvailCount(ImGuiInputTextState *self);
CIMGUI_API int ImGuiInputTextState_GetRedoAvailCount(ImGuiInputTextState *self);
CIMGUI_API void ImGuiInputTextState_OnKeyPressed(ImGuiInputTextState *self, int key);
CIMGUI_API void ImGuiInputTextState_CursorAnimReset(ImGuiInputTextState *self);
CIMGUI_API void ImGuiInputTextState_CursorClamp(ImGuiInputTextState *self);
CIMGUI_API bool ImGuiInputTextState_HasSelection(ImGuiInputTextState *self);
CIMGUI_API void ImGuiInputTextState_ClearSelection(ImGuiInputTextState *self);
CIMGUI_API void ImGuiInputTextState_SelectAll(ImGuiInputTextState *self);
CIMGUI_API ImGuiPopupData *ImGuiPopupData_ImGuiPopupData(void);
CIMGUI_API void ImGuiPopupData_destroy(ImGuiPopupData *self);
CIMGUI_API ImGuiNavMoveResult *ImGuiNavMoveResult_ImGuiNavMoveResult(void);
CIMGUI_API void ImGuiNavMoveResult_destroy(ImGuiNavMoveResult *self);
CIMGUI_API void ImGuiNavMoveResult_Clear(ImGuiNavMoveResult *self);
CIMGUI_API ImGuiNextWindowData *ImGuiNextWindowData_ImGuiNextWindowData(void);
CIMGUI_API void ImGuiNextWindowData_destroy(ImGuiNextWindowData *self);
CIMGUI_API void ImGuiNextWindowData_ClearFlags(ImGuiNextWindowData *self);
CIMGUI_API ImGuiNextItemData *ImGuiNextItemData_ImGuiNextItemData(void);
CIMGUI_API void ImGuiNextItemData_destroy(ImGuiNextItemData *self);
CIMGUI_API void ImGuiNextItemData_ClearFlags(ImGuiNextItemData *self);
CIMGUI_API ImGuiPtrOrIndex *ImGuiPtrOrIndex_ImGuiPtrOrIndexPtr(void *ptr);
CIMGUI_API void ImGuiPtrOrIndex_destroy(ImGuiPtrOrIndex *self);
CIMGUI_API ImGuiPtrOrIndex *ImGuiPtrOrIndex_ImGuiPtrOrIndexInt(int index);
CIMGUI_API ImGuiColumnData *ImGuiColumnData_ImGuiColumnData(void);
CIMGUI_API void ImGuiColumnData_destroy(ImGuiColumnData *self);
CIMGUI_API ImGuiColumns *ImGuiColumns_ImGuiColumns(void);
CIMGUI_API void ImGuiColumns_destroy(ImGuiColumns *self);
CIMGUI_API void ImGuiColumns_Clear(ImGuiColumns *self);
CIMGUI_API ImGuiWindowSettings *ImGuiWindowSettings_ImGuiWindowSettings(void);
CIMGUI_API void ImGuiWindowSettings_destroy(ImGuiWindowSettings *self);
CIMGUI_API char *ImGuiWindowSettings_GetName(ImGuiWindowSettings *self);
CIMGUI_API ImGuiSettingsHandler *ImGuiSettingsHandler_ImGuiSettingsHandler(void);
CIMGUI_API void ImGuiSettingsHandler_destroy(ImGuiSettingsHandler *self);
CIMGUI_API ImGuiContext *ImGuiContext_ImGuiContext(ImFontAtlas *shared_font_atlas);
CIMGUI_API void ImGuiContext_destroy(ImGuiContext *self);
CIMGUI_API ImGuiWindowTempData *ImGuiWindowTempData_ImGuiWindowTempData(void);
CIMGUI_API void ImGuiWindowTempData_destroy(ImGuiWindowTempData *self);
CIMGUI_API ImGuiWindow *ImGuiWindow_ImGuiWindow(ImGuiContext *context, const char *name);
CIMGUI_API void ImGuiWindow_destroy(ImGuiWindow *self);
CIMGUI_API ImGuiID ImGuiWindow_GetIDStr(ImGuiWindow *self, const char *str, const char *str_end);
CIMGUI_API ImGuiID ImGuiWindow_GetIDPtr(ImGuiWindow *self, const void *ptr);
CIMGUI_API ImGuiID ImGuiWindow_GetIDInt(ImGuiWindow *self, int n);
CIMGUI_API ImGuiID ImGuiWindow_GetIDNoKeepAliveStr(ImGuiWindow *self, const char *str, const char *str_end);
CIMGUI_API ImGuiID ImGuiWindow_GetIDNoKeepAlivePtr(ImGuiWindow *self, const void *ptr);
CIMGUI_API ImGuiID ImGuiWindow_GetIDNoKeepAliveInt(ImGuiWindow *self, int n);
CIMGUI_API ImGuiID ImGuiWindow_GetIDFromRectangle(ImGuiWindow *self, const ImRect r_abs);
CIMGUI_API void ImGuiWindow_Rect(ImRect *pOut, ImGuiWindow *self);
CIMGUI_API float ImGuiWindow_CalcFontSize(ImGuiWindow *self);
CIMGUI_API float ImGuiWindow_TitleBarHeight(ImGuiWindow *self);
CIMGUI_API void ImGuiWindow_TitleBarRect(ImRect *pOut, ImGuiWindow *self);
CIMGUI_API float ImGuiWindow_MenuBarHeight(ImGuiWindow *self);
CIMGUI_API void ImGuiWindow_MenuBarRect(ImRect *pOut, ImGuiWindow *self);
CIMGUI_API ImGuiLastItemDataBackup *ImGuiLastItemDataBackup_ImGuiLastItemDataBackup(void);
CIMGUI_API void ImGuiLastItemDataBackup_destroy(ImGuiLastItemDataBackup *self);
CIMGUI_API void ImGuiLastItemDataBackup_Backup(ImGuiLastItemDataBackup *self);
CIMGUI_API void ImGuiLastItemDataBackup_Restore(ImGuiLastItemDataBackup *self);
CIMGUI_API ImGuiTabItem *ImGuiTabItem_ImGuiTabItem(void);
CIMGUI_API void ImGuiTabItem_destroy(ImGuiTabItem *self);
CIMGUI_API ImGuiTabBar *ImGuiTabBar_ImGuiTabBar(void);
CIMGUI_API void ImGuiTabBar_destroy(ImGuiTabBar *self);
CIMGUI_API int ImGuiTabBar_GetTabOrder(ImGuiTabBar *self, const ImGuiTabItem *tab);
CIMGUI_API const char *ImGuiTabBar_GetTabName(ImGuiTabBar *self, const ImGuiTabItem *tab);
CIMGUI_API ImGuiWindow *igGetCurrentWindowRead(void);
CIMGUI_API ImGuiWindow *igGetCurrentWindow(void);
CIMGUI_API ImGuiWindow *igFindWindowByID(ImGuiID id);
CIMGUI_API ImGuiWindow *igFindWindowByName(const char *name);
CIMGUI_API void igUpdateWindowParentAndRootLinks(ImGuiWindow *window, ImGuiWindowFlags flags, ImGuiWindow *parent_window);
CIMGUI_API void igCalcWindowExpectedSize(ImVec2 *pOut, ImGuiWindow *window);
CIMGUI_API bool igIsWindowChildOf(ImGuiWindow *window, ImGuiWindow *potential_parent);
CIMGUI_API bool igIsWindowNavFocusable(ImGuiWindow *window);
CIMGUI_API void igGetWindowAllowedExtentRect(ImRect *pOut, ImGuiWindow *window);
CIMGUI_API void igSetWindowPosWindowPtr(ImGuiWindow *window, const ImVec2 pos, ImGuiCond cond);
CIMGUI_API void igSetWindowSizeWindowPtr(ImGuiWindow *window, const ImVec2 size, ImGuiCond cond);
CIMGUI_API void igSetWindowCollapsedWindowPtr(ImGuiWindow *window, bool collapsed, ImGuiCond cond);
CIMGUI_API void igSetWindowHitTestHole(ImGuiWindow *window, const ImVec2 pos, const ImVec2 size);
CIMGUI_API void igFocusWindow(ImGuiWindow *window);
CIMGUI_API void igFocusTopMostWindowUnderOne(ImGuiWindow *under_this_window, ImGuiWindow *ignore_window);
CIMGUI_API void igBringWindowToFocusFront(ImGuiWindow *window);
CIMGUI_API void igBringWindowToDisplayFront(ImGuiWindow *window);
CIMGUI_API void igBringWindowToDisplayBack(ImGuiWindow *window);
CIMGUI_API void igSetCurrentFont(ImFont *font);
CIMGUI_API ImFont *igGetDefaultFont(void);
CIMGUI_API ImDrawList *igGetForegroundDrawListWindowPtr(ImGuiWindow *window);
CIMGUI_API void igInitialize(ImGuiContext *context);
CIMGUI_API void igShutdown(ImGuiContext *context);
CIMGUI_API void igUpdateHoveredWindowAndCaptureFlags(void);
CIMGUI_API void igStartMouseMovingWindow(ImGuiWindow *window);
CIMGUI_API void igUpdateMouseMovingWindowNewFrame(void);
CIMGUI_API void igUpdateMouseMovingWindowEndFrame(void);
CIMGUI_API void igMarkIniSettingsDirtyNil(void);
CIMGUI_API void igMarkIniSettingsDirtyWindowPtr(ImGuiWindow *window);
CIMGUI_API void igClearIniSettings(void);
CIMGUI_API ImGuiWindowSettings *igCreateNewWindowSettings(const char *name);
CIMGUI_API ImGuiWindowSettings *igFindWindowSettings(ImGuiID id);
CIMGUI_API ImGuiWindowSettings *igFindOrCreateWindowSettings(const char *name);
CIMGUI_API ImGuiSettingsHandler *igFindSettingsHandler(const char *type_name);
CIMGUI_API void igSetNextWindowScroll(const ImVec2 scroll);
CIMGUI_API void igSetScrollXWindowPtr(ImGuiWindow *window, float scroll_x);
CIMGUI_API void igSetScrollYWindowPtr(ImGuiWindow *window, float scroll_y);
CIMGUI_API void igSetScrollFromPosXWindowPtr(ImGuiWindow *window, float local_x, float center_x_ratio);
CIMGUI_API void igSetScrollFromPosYWindowPtr(ImGuiWindow *window, float local_y, float center_y_ratio);
CIMGUI_API void igScrollToBringRectIntoView(ImVec2 *pOut, ImGuiWindow *window, const ImRect item_rect);
CIMGUI_API ImGuiID igGetItemID(void);
CIMGUI_API ImGuiItemStatusFlags igGetItemStatusFlags(void);
CIMGUI_API ImGuiID igGetActiveID(void);
CIMGUI_API ImGuiID igGetFocusID(void);
CIMGUI_API void igSetActiveID(ImGuiID id, ImGuiWindow *window);
CIMGUI_API void igSetFocusID(ImGuiID id, ImGuiWindow *window);
CIMGUI_API void igClearActiveID(void);
CIMGUI_API ImGuiID igGetHoveredID(void);
CIMGUI_API void igSetHoveredID(ImGuiID id);
CIMGUI_API void igKeepAliveID(ImGuiID id);
CIMGUI_API void igMarkItemEdited(ImGuiID id);
CIMGUI_API void igPushOverrideID(ImGuiID id);
CIMGUI_API ImGuiID igGetIDWithSeed(const char *str_id_begin, const char *str_id_end, ImGuiID seed);
CIMGUI_API void igItemSizeVec2(const ImVec2 size, float text_baseline_y);
CIMGUI_API void igItemSizeRect(const ImRect bb, float text_baseline_y);
CIMGUI_API bool igItemAdd(const ImRect bb, ImGuiID id, const ImRect *nav_bb);
CIMGUI_API bool igItemHoverable(const ImRect bb, ImGuiID id);
CIMGUI_API bool igIsClippedEx(const ImRect bb, ImGuiID id, bool clip_even_when_logged);
CIMGUI_API void igSetLastItemData(ImGuiWindow *window, ImGuiID item_id, ImGuiItemStatusFlags status_flags, const ImRect item_rect);
CIMGUI_API bool igFocusableItemRegister(ImGuiWindow *window, ImGuiID id);
CIMGUI_API void igFocusableItemUnregister(ImGuiWindow *window);
CIMGUI_API void igCalcItemSize(ImVec2 *pOut, ImVec2 size, float default_w, float default_h);
CIMGUI_API float igCalcWrapWidthForPos(const ImVec2 pos, float wrap_pos_x);
CIMGUI_API void igPushMultiItemsWidths(int components, float width_full);
CIMGUI_API void igPushItemFlag(ImGuiItemFlags option, bool enabled);
CIMGUI_API void igPopItemFlag(void);
CIMGUI_API bool igIsItemToggledSelection(void);
CIMGUI_API void igGetContentRegionMaxAbs(ImVec2 *pOut);
CIMGUI_API void igShrinkWidths(ImGuiShrinkWidthItem *items, int count, float width_excess);
CIMGUI_API void igLogBegin(ImGuiLogType type, int auto_open_depth);
CIMGUI_API void igLogToBuffer(int auto_open_depth);
CIMGUI_API bool igBeginChildEx(const char *name, ImGuiID id, const ImVec2 size_arg, bool border, ImGuiWindowFlags flags);
CIMGUI_API void igOpenPopupEx(ImGuiID id, ImGuiPopupFlags popup_flags);
CIMGUI_API void igClosePopupToLevel(int remaining, bool restore_focus_to_window_under_popup);
CIMGUI_API void igClosePopupsOverWindow(ImGuiWindow *ref_window, bool restore_focus_to_window_under_popup);
CIMGUI_API bool igIsPopupOpenID(ImGuiID id, ImGuiPopupFlags popup_flags);
CIMGUI_API bool igBeginPopupEx(ImGuiID id, ImGuiWindowFlags extra_flags);
CIMGUI_API void igBeginTooltipEx(ImGuiWindowFlags extra_flags, ImGuiTooltipFlags tooltip_flags);
CIMGUI_API ImGuiWindow *igGetTopMostPopupModal(void);
CIMGUI_API void igFindBestWindowPosForPopup(ImVec2 *pOut, ImGuiWindow *window);
CIMGUI_API void igFindBestWindowPosForPopupEx(ImVec2 *pOut, const ImVec2 ref_pos, const ImVec2 size, ImGuiDir *last_dir, const ImRect r_outer, const ImRect r_avoid, ImGuiPopupPositionPolicy policy);
CIMGUI_API void igNavInitWindow(ImGuiWindow *window, bool force_reinit);
CIMGUI_API bool igNavMoveRequestButNoResultYet(void);
CIMGUI_API void igNavMoveRequestCancel(void);
CIMGUI_API void igNavMoveRequestForward(ImGuiDir move_dir, ImGuiDir clip_dir, const ImRect bb_rel, ImGuiNavMoveFlags move_flags);
CIMGUI_API void igNavMoveRequestTryWrapping(ImGuiWindow *window, ImGuiNavMoveFlags move_flags);
CIMGUI_API float igGetNavInputAmount(ImGuiNavInput n, ImGuiInputReadMode mode);
CIMGUI_API void igGetNavInputAmount2d(ImVec2 *pOut, ImGuiNavDirSourceFlags dir_sources, ImGuiInputReadMode mode, float slow_factor, float fast_factor);
CIMGUI_API int igCalcTypematicRepeatAmount(float t0, float t1, float repeat_delay, float repeat_rate);
CIMGUI_API void igActivateItem(ImGuiID id);
CIMGUI_API void igSetNavID(ImGuiID id, int nav_layer, ImGuiID focus_scope_id);
CIMGUI_API void igSetNavIDWithRectRel(ImGuiID id, int nav_layer, ImGuiID focus_scope_id, const ImRect rect_rel);
CIMGUI_API void igPushFocusScope(ImGuiID id);
CIMGUI_API void igPopFocusScope(void);
CIMGUI_API ImGuiID igGetFocusScopeID(void);
CIMGUI_API bool igIsActiveIdUsingNavDir(ImGuiDir dir);
CIMGUI_API bool igIsActiveIdUsingNavInput(ImGuiNavInput input);
CIMGUI_API bool igIsActiveIdUsingKey(ImGuiKey key);
CIMGUI_API bool igIsMouseDragPastThreshold(ImGuiMouseButton button, float lock_threshold);
CIMGUI_API bool igIsKeyPressedMap(ImGuiKey key, bool repeat);
CIMGUI_API bool igIsNavInputDown(ImGuiNavInput n);
CIMGUI_API bool igIsNavInputTest(ImGuiNavInput n, ImGuiInputReadMode rm);
CIMGUI_API ImGuiKeyModFlags igGetMergedKeyModFlags(void);
CIMGUI_API bool igBeginDragDropTargetCustom(const ImRect bb, ImGuiID id);
CIMGUI_API void igClearDragDrop(void);
CIMGUI_API bool igIsDragDropPayloadBeingAccepted(void);
CIMGUI_API void igSetWindowClipRectBeforeSetChannel(ImGuiWindow *window, const ImRect clip_rect);
CIMGUI_API void igBeginColumns(const char *str_id, int count, ImGuiColumnsFlags flags);
CIMGUI_API void igEndColumns(void);
CIMGUI_API void igPushColumnClipRect(int column_index);
CIMGUI_API void igPushColumnsBackground(void);
CIMGUI_API void igPopColumnsBackground(void);
CIMGUI_API ImGuiID igGetColumnsID(const char *str_id, int count);
CIMGUI_API ImGuiColumns *igFindOrCreateColumns(ImGuiWindow *window, ImGuiID id);
CIMGUI_API float igGetColumnOffsetFromNorm(const ImGuiColumns *columns, float offset_norm);
CIMGUI_API float igGetColumnNormFromOffset(const ImGuiColumns *columns, float offset);
CIMGUI_API bool igBeginTabBarEx(ImGuiTabBar *tab_bar, const ImRect bb, ImGuiTabBarFlags flags);
CIMGUI_API ImGuiTabItem *igTabBarFindTabByID(ImGuiTabBar *tab_bar, ImGuiID tab_id);
CIMGUI_API void igTabBarRemoveTab(ImGuiTabBar *tab_bar, ImGuiID tab_id);
CIMGUI_API void igTabBarCloseTab(ImGuiTabBar *tab_bar, ImGuiTabItem *tab);
CIMGUI_API void igTabBarQueueReorder(ImGuiTabBar *tab_bar, const ImGuiTabItem *tab, int dir);
CIMGUI_API bool igTabBarProcessReorder(ImGuiTabBar *tab_bar);
CIMGUI_API bool igTabItemEx(ImGuiTabBar *tab_bar, const char *label, bool *p_open, ImGuiTabItemFlags flags);
CIMGUI_API void igTabItemCalcSize(ImVec2 *pOut, const char *label, bool has_close_button);
CIMGUI_API void igTabItemBackground(ImDrawList *draw_list, const ImRect bb, ImGuiTabItemFlags flags, ImU32 col);
CIMGUI_API bool igTabItemLabelAndCloseButton(ImDrawList *draw_list, const ImRect bb, ImGuiTabItemFlags flags, ImVec2 frame_padding, const char *label, ImGuiID tab_id, ImGuiID close_button_id, bool is_contents_visible);
CIMGUI_API void igRenderText(ImVec2 pos, const char *text, const char *text_end, bool hide_text_after_hash);
CIMGUI_API void igRenderTextWrapped(ImVec2 pos, const char *text, const char *text_end, float wrap_width);
CIMGUI_API void igRenderTextClipped(const ImVec2 pos_min, const ImVec2 pos_max, const char *text, const char *text_end, const ImVec2 *text_size_if_known, const ImVec2 align, const ImRect *clip_rect);
CIMGUI_API void igRenderTextClippedEx(ImDrawList *draw_list, const ImVec2 pos_min, const ImVec2 pos_max, const char *text, const char *text_end, const ImVec2 *text_size_if_known, const ImVec2 align, const ImRect *clip_rect);
CIMGUI_API void igRenderTextEllipsis(ImDrawList *draw_list, const ImVec2 pos_min, const ImVec2 pos_max, float clip_max_x, float ellipsis_max_x, const char *text, const char *text_end, const ImVec2 *text_size_if_known);
CIMGUI_API void igRenderFrame(ImVec2 p_min, ImVec2 p_max, ImU32 fill_col, bool border, float rounding);
CIMGUI_API void igRenderFrameBorder(ImVec2 p_min, ImVec2 p_max, float rounding);
CIMGUI_API void igRenderColorRectWithAlphaCheckerboard(ImDrawList *draw_list, ImVec2 p_min, ImVec2 p_max, ImU32 fill_col, float grid_step, ImVec2 grid_off, float rounding, int rounding_corners_flags);
CIMGUI_API void igRenderNavHighlight(const ImRect bb, ImGuiID id, ImGuiNavHighlightFlags flags);
CIMGUI_API const char *igFindRenderedTextEnd(const char *text, const char *text_end);
CIMGUI_API void igLogRenderedText(const ImVec2 *ref_pos, const char *text, const char *text_end);
CIMGUI_API void igRenderArrow(ImDrawList *draw_list, ImVec2 pos, ImU32 col, ImGuiDir dir, float scale);
CIMGUI_API void igRenderBullet(ImDrawList *draw_list, ImVec2 pos, ImU32 col);
CIMGUI_API void igRenderCheckMark(ImDrawList *draw_list, ImVec2 pos, ImU32 col, float sz);
CIMGUI_API void igRenderMouseCursor(ImDrawList *draw_list, ImVec2 pos, float scale, ImGuiMouseCursor mouse_cursor, ImU32 col_fill, ImU32 col_border, ImU32 col_shadow);
CIMGUI_API void igRenderArrowPointingAt(ImDrawList *draw_list, ImVec2 pos, ImVec2 half_sz, ImGuiDir direction, ImU32 col);
CIMGUI_API void igRenderRectFilledRangeH(ImDrawList *draw_list, const ImRect rect, ImU32 col, float x_start_norm, float x_end_norm, float rounding);
CIMGUI_API void igRenderRectFilledWithHole(ImDrawList *draw_list, ImRect outer, ImRect inner, ImU32 col, float rounding);
CIMGUI_API void igTextEx(const char *text, const char *text_end, ImGuiTextFlags flags);
CIMGUI_API bool igButtonEx(const char *label, const ImVec2 size_arg, ImGuiButtonFlags flags);
CIMGUI_API bool igCloseButton(ImGuiID id, const ImVec2 pos);
CIMGUI_API bool igCollapseButton(ImGuiID id, const ImVec2 pos);
CIMGUI_API bool igArrowButtonEx(const char *str_id, ImGuiDir dir, ImVec2 size_arg, ImGuiButtonFlags flags);
CIMGUI_API void igScrollbar(ImGuiAxis axis);
CIMGUI_API bool igScrollbarEx(const ImRect bb, ImGuiID id, ImGuiAxis axis, float *p_scroll_v, float avail_v, float contents_v, ImDrawCornerFlags rounding_corners);
CIMGUI_API bool igImageButtonEx(ImGuiID id, ImTextureID texture_id, const ImVec2 size, const ImVec2 uv0, const ImVec2 uv1, const ImVec2 padding, const ImVec4 bg_col, const ImVec4 tint_col);
CIMGUI_API void igGetWindowScrollbarRect(ImRect *pOut, ImGuiWindow *window, ImGuiAxis axis);
CIMGUI_API ImGuiID igGetWindowScrollbarID(ImGuiWindow *window, ImGuiAxis axis);
CIMGUI_API ImGuiID igGetWindowResizeID(ImGuiWindow *window, int n);
CIMGUI_API void igSeparatorEx(ImGuiSeparatorFlags flags);
CIMGUI_API bool igButtonBehavior(const ImRect bb, ImGuiID id, bool *out_hovered, bool *out_held, ImGuiButtonFlags flags);
CIMGUI_API bool igDragBehavior(ImGuiID id, ImGuiDataType data_type, void *p_v, float v_speed, const void *p_min, const void *p_max, const char *format, ImGuiSliderFlags flags);
CIMGUI_API bool igSliderBehavior(const ImRect bb, ImGuiID id, ImGuiDataType data_type, void *p_v, const void *p_min, const void *p_max, const char *format, ImGuiSliderFlags flags, ImRect *out_grab_bb);
CIMGUI_API bool igSplitterBehavior(const ImRect bb, ImGuiID id, ImGuiAxis axis, float *size1, float *size2, float min_size1, float min_size2, float hover_extend, float hover_visibility_delay);
CIMGUI_API bool igTreeNodeBehavior(ImGuiID id, ImGuiTreeNodeFlags flags, const char *label, const char *label_end);
CIMGUI_API bool igTreeNodeBehaviorIsOpen(ImGuiID id, ImGuiTreeNodeFlags flags);
CIMGUI_API void igTreePushOverrideID(ImGuiID id);
CIMGUI_API const ImGuiDataTypeInfo *igDataTypeGetInfo(ImGuiDataType data_type);
CIMGUI_API int igDataTypeFormatString(char *buf, int buf_size, ImGuiDataType data_type, const void *p_data, const char *format);
CIMGUI_API void igDataTypeApplyOp(ImGuiDataType data_type, int op, void *output, const void *arg_1, const void *arg_2);
CIMGUI_API bool igDataTypeApplyOpFromText(const char *buf, const char *initial_value_buf, ImGuiDataType data_type, void *p_data, const char *format);
CIMGUI_API int igDataTypeCompare(ImGuiDataType data_type, const void *arg_1, const void *arg_2);
CIMGUI_API bool igDataTypeClamp(ImGuiDataType data_type, void *p_data, const void *p_min, const void *p_max);
CIMGUI_API bool igInputTextEx(const char *label, const char *hint, char *buf, int buf_size, const ImVec2 size_arg, ImGuiInputTextFlags flags, ImGuiInputTextCallback callback, void *user_data);
CIMGUI_API bool igTempInputText(const ImRect bb, ImGuiID id, const char *label, char *buf, int buf_size, ImGuiInputTextFlags flags);
CIMGUI_API bool igTempInputScalar(const ImRect bb, ImGuiID id, const char *label, ImGuiDataType data_type, void *p_data, const char *format, const void *p_clamp_min, const void *p_clamp_max);
CIMGUI_API bool igTempInputIsActive(ImGuiID id);
CIMGUI_API ImGuiInputTextState *igGetInputTextState(ImGuiID id);
CIMGUI_API void igColorTooltip(const char *text, const float *col, ImGuiColorEditFlags flags);
CIMGUI_API void igColorEditOptionsPopup(const float *col, ImGuiColorEditFlags flags);
CIMGUI_API void igColorPickerOptionsPopup(const float *ref_col, ImGuiColorEditFlags flags);
CIMGUI_API int igPlotEx(ImGuiPlotType plot_type, const char *label, float (*values_getter)(void *data, int idx), void *data, int values_count, int values_offset, const char *overlay_text, float scale_min, float scale_max, ImVec2 frame_size);
CIMGUI_API void igShadeVertsLinearColorGradientKeepAlpha(ImDrawList *draw_list, int vert_start_idx, int vert_end_idx, ImVec2 gradient_p0, ImVec2 gradient_p1, ImU32 col0, ImU32 col1);
CIMGUI_API void igShadeVertsLinearUV(ImDrawList *draw_list, int vert_start_idx, int vert_end_idx, const ImVec2 a, const ImVec2 b, const ImVec2 uv_a, const ImVec2 uv_b, bool clamp);
CIMGUI_API void igGcCompactTransientWindowBuffers(ImGuiWindow *window);
CIMGUI_API void igGcAwakeTransientWindowBuffers(ImGuiWindow *window);
CIMGUI_API void igDebugDrawItemRect(ImU32 col);
CIMGUI_API void igDebugStartItemPicker(void);
CIMGUI_API bool igImFontAtlasBuildWithStbTruetype(ImFontAtlas *atlas);
CIMGUI_API void igImFontAtlasBuildInit(ImFontAtlas *atlas);
CIMGUI_API void igImFontAtlasBuildSetupFont(ImFontAtlas *atlas, ImFont *font, ImFontConfig *font_config, float ascent, float descent);
CIMGUI_API void igImFontAtlasBuildPackCustomRects(ImFontAtlas *atlas, void *stbrp_context_opaque);
CIMGUI_API void igImFontAtlasBuildFinish(ImFontAtlas *atlas);
CIMGUI_API void igImFontAtlasBuildRender1bppRectFromString(ImFontAtlas *atlas, int atlas_x, int atlas_y, int w, int h, const char *in_str, char in_marker_char, unsigned char in_marker_pixel_value);
CIMGUI_API void igImFontAtlasBuildMultiplyCalcLookupTable(unsigned char out_table[256], float in_multiply_factor);
CIMGUI_API void igImFontAtlasBuildMultiplyRectAlpha8(const unsigned char table[256], unsigned char *pixels, int x, int y, int w, int h, int stride);

/////////////////////////hand written functions
//no LogTextV
CIMGUI_API void igLogText(CONST char *fmt, ...);
//no appendfV
CIMGUI_API void ImGuiTextBuffer_appendf(struct ImGuiTextBuffer *buffer, const char *fmt, ...);
//for getting FLT_MAX in bindings
CIMGUI_API float igGET_FLT_MAX();

CIMGUI_API ImVector_ImWchar *ImVector_ImWchar_create();
CIMGUI_API void ImVector_ImWchar_destroy(ImVector_ImWchar *self);
CIMGUI_API void ImVector_ImWchar_Init(ImVector_ImWchar *p);
CIMGUI_API void ImVector_ImWchar_UnInit(ImVector_ImWchar *p);

#endif //CIMGUI_INCLUDED
