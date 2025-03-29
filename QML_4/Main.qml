import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    visible: true
    width: 400
    height: 600
    minimumWidth: 300
    minimumHeight: 400
    title: "Пример страницы"

    header: ToolBar {
        height: 50
        Label {
            text: "Header 1"
            anchors.centerIn: parent
            font.pixelSize: 20
        }
    }

    Item {
        anchors {
            top: header.bottom
            bottom: footer.top
            left: parent.left
            right: parent.right
            topMargin: 20
            bottomMargin: 20
        }

        Rectangle {
            anchors {
                fill: parent
                margins: 15
            }

            width: parent.width * 0.9
            height: 300
            color: "white"
            border.color: "black"
            border.width: 1
            radius: 5

            Column {
                anchors.centerIn: parent
                spacing: 15
                padding: 10

                Text {
                    text: "Content"
                    font.pixelSize: 18
                    font.bold: true
                }
            }
        }
    }

    footer: ToolBar {
        height: 60
        padding: 5
        background: Rectangle {
            color: "#e0e0e0"
            radius: 5
        }

        RowLayout {
            anchors.centerIn: parent
            spacing: 25

            Button {
                text: "Item 1"
                padding: 10
                background: Rectangle {
                    color: "#ff5722"
                }
                font.bold: true
            }
            Button {
                text: "Item 2"
                padding: 10
                background: Rectangle {
                    color: "#ffc107"
                    radius: 5
                }
                font.bold: true
            }
            Button {
                text: "Item 3"
                padding: 10
                background: Rectangle {
                    color: "#03a9f4"
                    radius: 5
                }
                font.bold: true
            }
        }
    }



}
