import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    visible: true
    width: 800
    height: 600
    minimumWidth: 400
    minimumHeight: 300

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        Rectangle {
            Layout.alignment: Qt.AlignTop
            Layout.fillWidth: true
            Layout.preferredHeight: 50
            color: "lightgray"

            Label {
                text: "Header"
                anchors.centerIn: parent
                font.bold: true
            }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.margins: 10
            border {
                color: "black"
                width: 2
            }
            radius: 5

            Label {
                text: "Content"
                anchors.centerIn: parent
                font.pixelSize: 24
            }
        }

        Rectangle {
            Layout.fillWidth: true
            color: "black"
            implicitHeight: footerLayout.implicitHeight

            RowLayout {
                id: footerLayout
                anchors.fill: parent
                spacing: 15

                Repeater {
                    model: 3
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        color: "lightgray"
                        border {
                            color: "#333"
                            width: 1
                        }

                        Label {
                            text: index + 1
                            anchors.centerIn: parent
                            font {
                                pixelSize: 28
                                bold: true
                            }
                            color: "#333"
                        }
                    }
                }
            }
        }
    }
}
