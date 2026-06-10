import QtQuick
import quickshell
import quickshell.Wayland

ShellWindow {
    anchors.top: true
    anchors.bottom: true
    anchors.right: true
    width: 350

    WlrLayershell.layer: WlrLayershell.Top
    WlrLayershell.namespace: "quickshell-sidebar"

    Rectangle {
        anchors.fill: parent
        color: "#11111b"
        border.color: "#cba6f7"
        border.width: 2

        Text {
            anchors.centerIn: parent
            text: "SIDEBAR"
            color: "#cba6f7"
            font.pixelSize: 18
            font.bold: true
        }
    }
}
