///// AI GENERATED: Using it just as a placeholder, module not implemented yet. /////
// QML documentation: https://doc.qt.io/qt-6/qtqml-index.html
//Quickshell documentation: https://quickshell.org/docs/v0.3.0/types/Quickshell/





// modules/Bar.qml
import Quickshell
import QtQuick
import QtQuick.Layouts

PanelWindow {
    anchors { top: true; left: true; right: true }
    implicitHeight: 32

    Rectangle {
        anchors.fill: parent
        color: "#1e1e2e"

        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 12
            anchors.rightMargin: 12

            Text {
                text: "Pansy Shell"
                color: "#cdd6f4"
                font.pixelSize: 14
                font.bold: true
            }

            Item { Layout.fillWidth: true }

            Text {
                id: clock
                color: "#89b4fa"
                font.pixelSize: 14
            }
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: clock.text = Qt.formatDateTime(new Date(), "hh:mm:ss")
    }
}