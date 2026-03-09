import QtQuick
import QtQuick.Layouts
import qs.Commons
import qs.Services.System
import qs.Widgets

ColumnLayout {
    id: root

    property var cfg: pluginApi.pluginSettings || ({})
    property var defaults: pluginApi?.manifest?.metadata?.defaultSettings || ({})
    property var pluginApi: null
    
    property string pluginName: "Modern Clock"
    property bool valueColourChoice: cfg.colourChoice ?? defaults.colourChoice
    property string valueCustomDateFont: cfg.customDateFont ?? defaults.customDateFont

    // Font
    property string valueCustomDayFont: cfg.customDayFont ?? defaults.customDayFont
    property string valueCustomTimeFont: cfg.customTimeFont ?? defaults.customTimeFont
    property string valueDateColourChoice: cfg.dateColourChoice ?? defaults.dateColourChoice
    property string valueDateColourPicker: cfg.dateColourPicker ?? defaults.dateColourPicker
    property real valueDateFontSize: cfg.dateFontSize ?? 1.0
    property string valueDayColourChoice: cfg.dayColourChoice ?? defaults.dayColourChoice

    // DateTime Colour
    property string valueDayColourPicker: cfg.dayColourPicker ?? defaults.dayColourPicker
    property real valueDayFontSize: cfg.dayFontSize ?? 1.0
    property bool valueShowBackground: false
    property real valueTextOpacity: cfg.textOpacity ?? defaults.textOpacity
    property string valueTimeColourChoice: cfg.timeColourChoice ?? defaults.timeColourChoice
    property string valueTimeColourPicker: cfg.timeColourPicker ?? defaults.timeColourPicker
    property real valueTimeFontSize: cfg.timeFontSize ?? 1.0

    function saveSettings() {
        if (!pluginApi) {
            Logger.e(pluginName, "Cannot save settings: pluginApi is null");
            return;
        }

        pluginApi.pluginSettings.dayColourPicker = root.valueDayColourPicker.toUpperCase();
        pluginApi.pluginSettings.dateColourPicker = root.valueDateColourPicker.toUpperCase();
        pluginApi.pluginSettings.timeColourPicker = root.valueTimeColourPicker.toUpperCase();
        pluginApi.pluginSettings.dayColourChoice = root.valueDayColourChoice;
        pluginApi.pluginSettings.dateColourChoice = root.valueDateColourChoice;
        pluginApi.pluginSettings.timeColourChoice = root.valueTimeColourChoice;
        pluginApi.pluginSettings.colourChoice = root.valueColourChoice;
        pluginApi.pluginSettings.customDayFont = root.valueCustomDayFont;
        pluginApi.pluginSettings.customDateFont = root.valueCustomDateFont;
        pluginApi.pluginSettings.customTimeFont = root.valueCustomTimeFont;
        pluginApi.pluginSettings.dayFontSize = root.valueDayFontSize;
        pluginApi.pluginSettings.dateFontSize = root.valueDateFontSize;
        pluginApi.pluginSettings.timeFontSize = root.valueTimeFontSize;
        pluginApi.pluginSettings.textOpacity = root.valueTextOpacity;

        pluginApi.saveSettings();

        Logger.d(pluginName, "Settings saved successfully");
    }

    spacing: Style.marginM
    width: 700

    Component.onCompleted: {
        Logger.d(pluginName, "Settings UI loaded");
    }

    ColumnLayout {
        Layout.fillWidth: true
        spacing: Style.marginM

        // General Settings
        NHeader {
            label: pluginApi?.tr("settings.menu.header")
            visible: true
        }
        NToggle {
            checked: valueColourChoice
            defaultValue: valueColourChoice
            description: pluginApi?.tr("settings.menu.colourToggle.description")
            label: pluginApi?.tr("settings.menu.colourToggle.label")

            onToggled: checked => {
                valueColourChoice = checked;
                saveSettings();
            }
        }
        RowLayout {
            Layout.fillWidth: true
            spacing: Style.marginS

            NLabel {
                label: pluginApi?.tr("settings.font.fontOpacity")
            }
            NValueSlider {
                from: 0
                to: 1
                value: valueTextOpacity

                onMoved: function (value) {
                    valueTextOpacity = value;
                    saveSettings();
                }
            }
        }

        // End General Settings

        NDivider {
            Layout.fillWidth: true
            visible: true
        }

        // Day Settings
        NHeader {
            label: pluginApi?.tr("settings.font.day.header")
            visible: true
        }
        RowLayout {
            Layout.fillWidth: true
            spacing: Style.marginS
            visible: !valueColourChoice

            NLabel {
                description: pluginApi?.tr("settings.font.day.colour.description")
                label: pluginApi?.tr("settings.font.day.colour.label")
            }
            NColorPicker {
                Layout.preferredHeight: Style.baseWidgetSize
                Layout.preferredWidth: Style.sliderWidth
                selectedColor: valueDayColourPicker

                onColorSelected: function (color) {
                    valueDayColourPicker = color;
                    saveSettings();
                }
            }
        }
        NColorChoice {
            currentKey: valueDayColourChoice
            defaultValue: cfg.dayColourChoice
            description: pluginApi?.tr("settings.font.day.colour.description")
            label: pluginApi?.tr("settings.font.day.colour.label")
            visible: valueColourChoice

            onSelected: function (color) {
                valueDayColourChoice = color;
                saveSettings();
            }
        }
        NSearchableComboBox {
            Layout.fillWidth: true
            currentKey: valueCustomDayFont
            description: I18n.tr("bar.clock.custom-font-description")
            label: I18n.tr("bar.clock.custom-font-label")
            minimumWidth: 300
            model: FontService.availableFonts
            placeholder: I18n.tr("bar.clock.custom-font-placeholder")
            popupHeight: 420
            searchPlaceholder: I18n.tr("bar.clock.custom-font-search-placeholder")
            visible: true

            onSelected: function (key) {
                valueCustomDayFont = key;
                saveSettings();
            }
        }
        RowLayout {
            Layout.fillWidth: true
            spacing: Style.marginS

            NLabel {
                label: I18n.tr("panels.bar.appearance-font-scale-label")
            }
            NValueSlider {
                from: 1
                to: 10
                value: valueDayFontSize

                onMoved: function (value) {
                    valueDayFontSize = value;
                    saveSettings();
                }
            }
        }

        // End Day Settings

        NDivider {
            Layout.fillWidth: true
            visible: true
        }

        // Date Settings
        NHeader {
            label: pluginApi?.tr("settings.font.date.header")
            visible: true
        }
        RowLayout {
            Layout.fillWidth: true
            spacing: Style.marginS
            visible: !valueColourChoice

            NLabel {
                description: pluginApi?.tr("settings.font.date.colour.description")
                label: pluginApi?.tr("settings.font.date.colour.label")
            }
            NColorPicker {
                Layout.preferredHeight: Style.baseWidgetSize
                Layout.preferredWidth: Style.sliderWidth
                selectedColor: valueDateColourPicker

                onColorSelected: function (color) {
                    valueDateColourPicker = color;
                    saveSettings();
                }
            }
        }
        NColorChoice {
            currentKey: valueDateColourChoice
            defaultValue: cfg.dateColourChoice
            description: pluginApi?.tr("settings.font.day.colour.description")
            label: pluginApi?.tr("settings.font.day.colour.label")
            visible: valueColourChoice

            onSelected: function (color) {
                valueDateColourChoice = color;
                saveSettings();
            }
        }
        NSearchableComboBox {
            Layout.fillWidth: true
            currentKey: valueCustomDateFont
            description: I18n.tr("bar.clock.custom-font-description")
            label: I18n.tr("bar.clock.custom-font-label")
            minimumWidth: 300
            model: FontService.availableFonts
            placeholder: I18n.tr("bar.clock.custom-font-placeholder")
            popupHeight: 420
            searchPlaceholder: I18n.tr("bar.clock.custom-font-search-placeholder")
            visible: true

            onSelected: function (key) {
                valueCustomDateFont = key;
                saveSettings();
            }
        }
        RowLayout {
            Layout.fillWidth: true
            spacing: Style.marginS

            NLabel {
                label: I18n.tr("panels.bar.appearance-font-scale-label")
            }
            NValueSlider {
                from: 1
                to: 10
                value: valueDateFontSize

                onMoved: function (value) {
                    valueDateFontSize = value;
                    saveSettings();
                }
            }
        }

        // End Date Settings

        NDivider {
            Layout.fillWidth: true
            visible: true
        }

        // Time Settings
        NHeader {
            label: pluginApi?.tr("settings.font.time.header")
            visible: true
        }
        RowLayout {
            Layout.fillWidth: true
            spacing: Style.marginS
            visible: !valueColourChoice

            NLabel {
                description: pluginApi?.tr("settings.font.time.colour.description")
                label: pluginApi?.tr("settings.font.time.colour.label")
            }
            NColorPicker {
                Layout.preferredHeight: Style.baseWidgetSize
                Layout.preferredWidth: Style.sliderWidth
                selectedColor: valueTimeColourPicker

                onColorSelected: function (color) {
                    valueTimeColourPicker = color;
                    saveSettings();
                }
            }
        }
        NColorChoice {
            currentKey: valueTimeColourChoice
            defaultValue: cfg.timeColourChoice
            description: pluginApi?.tr("settings.font.day.colour.description")
            label: pluginApi?.tr("settings.font.day.colour.label")
            visible: valueColourChoice

            onSelected: function (color) {
                valueTimeColourChoice = color;
                saveSettings();
            }
        }
        NSearchableComboBox {
            Layout.fillWidth: true
            currentKey: valueCustomTimeFont
            description: I18n.tr("bar.clock.custom-font-description")
            label: I18n.tr("bar.clock.custom-font-label")
            minimumWidth: 300
            model: FontService.availableFonts
            placeholder: I18n.tr("bar.clock.custom-font-placeholder")
            popupHeight: 420
            searchPlaceholder: I18n.tr("bar.clock.custom-font-search-placeholder")
            visible: true

            onSelected: function (key) {
                valueCustomTimeFont = key;
                saveSettings();
            }
        }
        RowLayout {
            Layout.fillWidth: true
            spacing: Style.marginS

            NLabel {
                label: I18n.tr("panels.bar.appearance-font-scale-label")
            }
            NValueSlider {
                from: 1
                to: 10
                value: valueTimeFontSize

                onMoved: function (value) {
                    valueTimeFontSize = value;
                    saveSettings();
                }
            }
        }

        // End Time Settings
    }
}
