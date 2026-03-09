import QtQuick
import QtQuick.Layouts
import qs.Commons
import qs.Modules.DesktopWidgets
import qs.Widgets

DraggableDesktopWidget {
  id: root
  showBackground: false
  roundedCorners: false
  
  property var pluginApi: null
  readonly property var settings: pluginApi?.pluginSettings
  readonly property var now: Time.now

  // DateTime Colour
  readonly property color dayColour: colourChoice ? Color.resolveColorKey(settings?.dayColourChoice) : settings?.dayColourPicker 
  readonly property color dateColour: colourChoice ? Color.resolveColorKey(settings?.dateColourChoice) : settings?.dateColourPicker 
  readonly property color timeColour: colourChoice ? Color.resolveColorKey(settings?.timeColourChoice) : settings?.timeColourPicker 
  readonly property bool colourChoice: settings?.colourChoice

  // Font
  readonly property string customDayFont: settings?.customDayFont
  readonly property string customDateFont: settings?.customDateFont
  readonly property string customTimeFont: settings?.customTimeFont

  readonly property real dayFontSize: (settings?.dayFontSize !== undefined) ? settings?.dayFontSize : Style.fontSizeXXL
  readonly property real dateFontSize: (settings?.dateFontSize !== undefined) ? settings?.dateFontSize : Style.fontSizeM
  readonly property real timeFontSize: (settings?.timeFontSize !== undefined) ? settings?.timeFontSize : Style.fontSizeM

  readonly property real textOpacity: settings?.textOpacity
  readonly property real contentPadding: Math.round(Style.marginL * widgetScale)

  // Width = Max(FontWidth) + padding
  implicitWidth: Math.round(Math.max(
      (Style.fontSizeXXL * dayFontSize) * 9,   
      (Style.fontSizeM * dateFontSize) * 11, 
      (Style.fontSizeM * timeFontSize) * 10
  ) * widgetScale + (contentPadding * 2))

// Height = sum of fontSize + spacings + margins
  implicitHeight: Math.round((
      ((Style.fontSizeXXL * dayFontSize) + 
       (Style.fontSizeM * dateFontSize) + 
       (Style.fontSizeM * timeFontSize)) 
      * widgetScale * 1.4 // distance between lines of text
  ) + (Style.marginS * 2) + (contentPadding * 2))

  ColumnLayout {
    anchors.fill: parent
    anchors.margins: Style.marginL
    spacing: Style.marginS

    NText {
        opacity: textOpacity
        text: timeNowFormat("dddd").toUpperCase()
        font.pointSize: (Style.fontSizeXXL * dayFontSize) * widgetScale
        minimumPointSize: Style.fontSizeM * widgetScale
        color: dayColour
        wrapMode: Text.WordWrap
        Layout.alignment: Qt.AlignHCenter
        family: root.customDayFont ?? root.customFont
      }

      NText {
        opacity: textOpacity
        text: timeNowFormat("dd MMM yyyy").toUpperCase()
        font.pointSize: (Style.fontSizeM * dateFontSize) * widgetScale
        minimumPointSize: Style.fontSizeM * widgetScale
        color: dateColour
        wrapMode: Text.WordWrap
        Layout.alignment: Qt.AlignHCenter
        family: root.customDateFont ?? root.customFont
      }

      NText {
        opacity: textOpacity
        text: "- " + timeNowFormat("h:mm AP") + " -"
        font.pointSize: (Style.fontSizeM * timeFontSize) * widgetScale
        minimumPointSize: Style.fontSizeM * widgetScale
        color: timeColour
        wrapMode: Text.WordWrap
        Layout.alignment: Qt.AlignHCenter
        family: root.customTimeFont ?? root.customFont
      }
  }

  function timeNowFormat(format) {
    var currentTimeString = "";
    var timeStrings = I18n.locale.toString(root.now, format).split(" ");

    timeStrings.forEach((element, index) => {
      if (index === timeStrings.length - 1) {
        currentTimeString += element;
      }
      else {
        currentTimeString += element + " ";
      }
    
    });
    return currentTimeString;
  }
}
