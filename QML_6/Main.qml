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
            background: Rectangle { color: "red" }

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
            background: Rectangle { color: "green" }

            ColumnLayout {
                anchors.centerIn: parent
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
            background: Rectangle { color: "yellow" }

            ColumnLayout {
                anchors.centerIn: parent
                spacing: 15

                Button {
                    text: "Красный"
                    onClicked: stackView.replace(redPage)
                }
                Button {
                    text: "Зеленый"
                    onClicked: stackView.replace(greenPage)
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
                onClicked: stackView.pop()
            }
        }
    }
}




