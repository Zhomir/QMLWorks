import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Window {
    width: 360
    height: 640
    visible: true
    title: qsTr("Светофор")

    property int defMargin: 10

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: logoPage

        onDepthChanged: console.log("Глубина стека:", depth)
    }

    Component {
        id: logoPage
        Page {
            background: Rectangle { color: "white" }

            ColumnLayout {
                anchors.centerIn: parent
                spacing: 20

                Label {
                    text: "Светофор"
                    font.pixelSize: 24
                }

                Button {
                    text: "Начать"
                    onClicked: stackView.push(redPage)
                }
            }
        }
    }


    Component {
        id: redPage
        Page {
            title: "Красный"
            background: Rectangle { color: "#e74c3c" }

            ColumnLayout {
                anchors.centerIn: parent
                spacing: 15

                Button {
                    text: "Зеленый"
                    onClicked: stackView.replace(greenPage)
                }
                Button {
                    text: "Желтый"
                    onClicked: stackView.replace(yellowPage)
                }
            }
        }
    }

    Component {
        id: greenPage
        Page {
            title: "Зеленый"
            background: Rectangle { color: "#2ecc71" }

            RowLayout {
                anchors {
                    bottom: parent.bottom
                    horizontalCenter: parent.horizontalCenter
                    margins: 20
                }
                spacing: 15

                Button {
                    text: "Красный"
                    onClicked: stackView.replace(redPage)
                }
                Button {
                    text: "Желтый"
                    onClicked: stackView.replace(yellowPage)
                }
            }
        }
    }

    Component {
        id: yellowPage
        Page {
            title: "Желтый"
            background: Rectangle { color: "#f1c40f" }

            ColumnLayout {
                anchors {
                    top: parent.top
                    right: parent.right
                    margins: 15
                }
                spacing: 10

                Button {
                    text: "🔴"
                    onClicked: stackView.replace(redPage)
                    background: Rectangle { opacity: 0 }
                }

                Button {
                    text: "🟢"
                    onClicked: stackView.replace(greenPage)
                    background: Rectangle { opacity: 0 }
                }
            }
        }
    }

    ToolBar {
        RowLayout {
            anchors.fill: parent
            spacing: 10

            ToolButton {
                visible: stackView.depth > 1
                text: "Назад"
                font.pixelSize: 20
                onClicked: stackView.pop()
            }

        }
    }
}

