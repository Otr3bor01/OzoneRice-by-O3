// QML documentation: https://doc.qt.io/qt-6/qtqml-index.html
//Quickshell documentation: https://quickshell.org/docs/v0.3.0/types/Quickshell/
import Quickshell
import QtQuick
import QtQuick.Layouts

PanelWindow {
    screen: Quickshell.screens.find(s => s.name === "DP-1")
    exclusionMode: ExclusionMode.Ignore
    anchors {
        bottom: false;
        right: true;
        left: true;
        top: true;
    }

    implicitHeight: 35
    width: 1120
    color: "transparent"

    margins{
        right: 350;
        top: 10;
        left: 350;
    }
    
    Rectangle{
        anchors.fill: parent
        color: Qt.rgba(18/255, 13/255, 30/255, 0.5)
        radius: 100
        border.color: "#443355"
        border.width: 2
    }
}