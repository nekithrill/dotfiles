import QtQuick
import quickshell

import "modules/bar"
import "modules/osd"
import "modules/sidebar"
import "modules/lock"
import "modules/overview"
import "modules/notifications"

ShellRoot {
    Bar {}
    Osd {}
    Sidebar {}
    Notifications {}

    // Экраны на весь экран пока комментируем, чтобы не мешали
    // Lock {}
    // Overview {}
}
