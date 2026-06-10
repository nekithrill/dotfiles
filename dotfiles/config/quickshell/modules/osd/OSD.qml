import QtQuick
import quickshell
import quickshell.Wayland

ShellWindow {
    anchors.bottom: true
    anchors.horizontalCenter: true
    anchors.bottomMargin: 100
    width: 200
    height: 50

    WlrLayershell.layer: WlrLayershell.Overlay
    WlrLayershell.namespace: "quickshell-osd"

    Rectangle {
        anchors.fill: parent
        color: "#313244"
        radius: 25
        border.color: "#f9e2af"
        border.width: 2

        Text {
            anchors.centerIn: parent
            text: "OSD 🔊 50%"
            color: "#f9e2af"
            font.bold: true
        }
    }
}
