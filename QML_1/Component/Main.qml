import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    visible: true
    width: 800
    height: 600

    Rectangle {
        id: header
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }
        height: 50
        color: "lightgray"

        Label {
            text: "Header"
            anchors.centerIn: parent
        }
    }

    Rectangle {
        id: content
        anchors {
            top: header.bottom
            bottom: footer.top
            left: parent.left
            right: parent.right
            margins: 10
        }
        border {
            color: "black"
            width: 2
        }

        Label {
            text: "Content"
            anchors.centerIn: parent
        }
    }

    Row {
        id: footer
        anchors {
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }
        height: 80
        spacing: 5

        Repeater {
            model: 3
            Rectangle {
                width: (parent.width - parent.spacing * 2) / 3
                height: parent.height
                color: "lightgray"

                Label {
                    text: index + 1
                    anchors.centerIn: parent
                }
            }
        }
    }
}
