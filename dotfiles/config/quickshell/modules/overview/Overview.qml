import QtQuick
import quickshell
import quickshell.Wayland

ShellWindow {
    anchors.fill: parent

    WlrLayershell.layer: WlrLayershell.Top
    WlrLayershell.namespace: "quickshell-overview"

    Rectangle {
        anchors.fill: parent
        color: "#1e1e2e"
        opacity: 0.95
        border.color: "#a6e3a1"
        border.width: 4

        Text {
            anchors.centerIn: parent
            text: "OVERVIEW"
            color: "#a6e3a1"
            font.pixelSize: 22
            font.bold: true
        }
    }
}
