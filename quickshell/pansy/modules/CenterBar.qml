// QML documentation: https://doc.qt.io/qt-6/qtqml-index.html
//Quickshell documentation: https://quickshell.org/docs/v0.3.0/types/Quickshell/
import Quickshell
import QtQuick
import QtQuick.Layouts

PanelWindow {
    exclusionMode: ExclusionMode.Ignore
    anchors {
        bottom: false;
        right: true;
        top: true;
    }

    implicitHeight: 35
    width: 1120

    margins{
        right: 400;
        top: 10;
    }
}