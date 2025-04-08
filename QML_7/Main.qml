import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    visible: true
    width: 400
    height: 500
    title: "Password Input"

    ColumnLayout {
        anchors.fill: parent
        spacing: 20
        anchors.margins: 20

        Text {
            text: "Enter your password:"
            font.pixelSize: 18
            Layout.alignment: Qt.AlignCenter
        }

        Row {
            spacing: 10
            Layout.alignment: Qt.AlignCenter
            Repeater {
                model: 6
                Text {
                    text: "*"
                    font.pixelSize: 24
                    opacity: {
                        if (index < passwordField.text.length) {
                            return 0.2 + (0.13 * index)
                        } else {
                            return 0.1
                        }
                    }
                }
            }
        }

        Rectangle {
            Layout.alignment: Qt.AlignCenter
            width: 260
            height: 280
            color: "white"

            GridLayout {
                anchors.centerIn: parent
                columns: 3
                rowSpacing: 15
                columnSpacing: 15

                Repeater {
                    model: 9
                    Button {
                        text: (index + 1).toString()
                        onClicked: if (passwordField.text.length < 6) passwordField.text += text
                        implicitWidth: 70
                        implicitHeight: 50

                        background: Rectangle {
                            color: parent.pressed ? "#808080" : "#f5f5f5"
                            radius: 5
                            Behavior on color { ColorAnimation { duration: 100 } }
                        }
                    }
                }

                Item { visible: false }

                Button {
                    text: "0"
                    onClicked: if (passwordField.text.length < 6) passwordField.text += text
                    implicitWidth: 70
                    implicitHeight: 50

                    background: Rectangle {
                        color: parent.pressed ? "#808080" : "#f5f5f5"
                        radius: 5
                        Behavior on color { ColorAnimation { duration: 100 } }
                    }
                }

                Button {
                    text: "Clear"
                    onClicked: passwordField.text = ""
                    implicitWidth: 70
                    implicitHeight: 50

                    background: Rectangle {
                        color: parent.pressed ? "#808080" : "#ff4444"
                        radius: 5
                        Behavior on color { ColorAnimation { duration: 100 } }
                    }
                }

                Button {
                    text: "Log In"
                    onClicked: console.log("Залогинились")
                    implicitWidth: 70
                    implicitHeight: 50

                    background: Rectangle {
                        color: parent.pressed ? "#808080" : "#f5f5f5"
                        radius: 5
                        Behavior on color { ColorAnimation { duration: 100 } }
                    }
                }
            }
        }

        TextField {
            id: passwordField
            visible: false
            maximumLength: 6
        }
    }
}
